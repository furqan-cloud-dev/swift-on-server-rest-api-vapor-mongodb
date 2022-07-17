//
//  UserController.swift
//  
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com


/***** Some Best Practices

 - Create separate functions for controllers for processing request
 - Use custom sturct/classes conform to Content for return value to avoid any typo mistake when using dictionaries as return object like:  ["vlueKey": "somevalue"] etc.
 
*/

import Vapor
import FluentKit
import FluentMongoDriver


struct CreateUser: Content {
    var name: String
    var email: String
}

extension CreateUser: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
    }
}


enum UserResponseError: Error {
    case invalidId
    case notFound
}


final class UserController {
    
    private static func create(req: Request) async throws -> [String: String] {
        try CreateUser.validate(content: req)
        let user = try req.content.decode(User.self)
        try await user.create(on: req.db)
        return ["id": user.id?.hexString ?? ""]
    }
    
    
    private static func getAll(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }
    
    
    private static func getUser(req: Request) async throws -> User {
        let id = req.parameters.get("id")!
        if let dbObjectId = ObjectId(id) {
            let user = try await User.query(on: req.db)
                .filter(\.$id == dbObjectId)
                .first()
            
            if let userFound = user {
                let responseUser = User(id: userFound.id, name: userFound.name, email: userFound.email)
                return responseUser
            }
            else {
                throw UserResponseError.notFound
            }
        }
        throw UserResponseError.invalidId
    }
    
    
    
    
    public static func configureRoutes(app: Application) {
        let users = app.grouped("users")
        // POST /users
        users.post(use: create)
        
        // Get All Users
        users.get(use: getAll)
        
        // GET /users/:id
        users.get(":id", use: getUser)
    }
}

//
//  UserController.swift
//  
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com

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


final class UserController {
    
    static func configureRoutes(app: Application) {
        let users = app.grouped("users")
        
        // POST /users
        users.post { req async throws -> [String: String] in
            try CreateUser.validate(content: req)
            let user = try req.content.decode(User.self)
            try await user.create(on: req.db)
            return ["id": user.id?.hexString ?? ""]
        }
        
        // Get Users
        users.get { req async throws in
            try await User.query(on: req.db).all()
        }
        
        
        // GET /users/:id
        users.get(":id") { req -> [String: String] in
            let id = req.parameters.get("id")!
            if let dbObjectId = ObjectId(id) {
                let user = try await User.query(on: req.db)
                    .filter(\.$id == dbObjectId)
                    .first()
                
                return ["name": user?.name ?? "", "email": user?.email ?? ""]
            }
            return [:]
        }
    }
}

//
//  File.swift
//  
//
//  Created by Furqan on 17/07/2022.
//

import Vapor
import FluentKit
import FluentMongoDriver
import JWT


struct LoginCredentials: Content {
    var email: String
    var password: String
}

extension LoginCredentials: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self)
    }
}


final class LoginController {
    
    public static func configureRoutes(app: Application) {
        app.post("login", use: login)
    }
    
    
    private static func login(req: Request) async throws -> [String: String] {
        try LoginCredentials.validate(content: req)
        let loginCredentials = try req.content.decode(LoginCredentials.self)

        let user = try await User.query(on: req.db)
            .filter(\.$email == loginCredentials.email)
            .first()
        
        if let userFound = user {
            if userFound.password == loginCredentials.password {
                // authenticated user
                return try await generateJWTToken(req: req)
            }
        }
        
        throw Abort(.unauthorized, reason: "Invalid Credentials")
    }
    
    
    // Generate and return a new JWT.
    private static func generateJWTToken(req: Request) async throws -> [String: String] {
        let payload = TestPayload(
            subject: "vapor",
            expiration: .init(value: .distantFuture),
            isAdmin: true
        )
        // Return the signed JWT
        return try [
            "token": req.jwt.sign(payload)
        ]
    }
    
}

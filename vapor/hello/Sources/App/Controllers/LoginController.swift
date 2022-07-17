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

final class LoginController {
    
    public static func configureRoutes(app: Application) {
        
        // login functionality to verify user in db needs to implemented here....
        /*           */
        
        // Generate and return a new JWT.
        app.post("login") { req -> [String: String] in
            // Create a new instance of our JWTPayload
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
    
    
}

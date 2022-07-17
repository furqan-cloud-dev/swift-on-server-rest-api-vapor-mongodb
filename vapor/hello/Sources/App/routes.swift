
//
//  routes.swift
//
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com


import Vapor
import JWT

struct Greeting: Content {
    var name: String
}


func routes(_ app: Application) throws {
    
    app.get { req in
        return "vapor server running!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    
    // [POST] /greeting -  Expecting Json Request: {"name": "furqan"}
    // Return a Json Response
    app.post("greeting") { req -> [String: String] in
        let greeting = try req.content.decode(Greeting.self)
        print(greeting.name)
        return ["welcome": greeting.name]
    }
    
    // Fetch and verify JWT from incoming request.
    app.get("me") { req -> HTTPStatus in
        let payload = try req.jwt.verify(as: TestPayload.self)
        print(payload)
        return .ok
    }
    
    // Configure Controllers routes
    LoginController.configureRoutes(app: app)
    UserController.configureRoutes(app: app)
    
}

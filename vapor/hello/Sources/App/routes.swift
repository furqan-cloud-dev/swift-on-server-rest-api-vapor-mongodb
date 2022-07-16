
//
//  routes.swift
//
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com


import Vapor

struct Greeting: Content {
    var name: String
}


func routes(_ app: Application) throws {
    
    app.get { req in
        return "vapor server!"
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
    
    // Configure UserController for "users" routes
    UserController.configureRoutes(app: app)
    
}

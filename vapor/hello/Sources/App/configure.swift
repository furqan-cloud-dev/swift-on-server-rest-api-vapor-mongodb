//
//  configure.swift
//
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com


import Vapor
import Fluent
import FluentMongoDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    try app.databases.use(.mongo(connectionString: "mongodb://localhost:27017/vapor"), as: .mongo)

    // Json Web Token Configuration
    app.jwt.signers.use(.hs256(key: "h7k92lmn90cdf"))
    

    // register routes
    try routes(app)
}

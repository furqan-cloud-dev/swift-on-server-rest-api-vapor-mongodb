//
//  User.swift
//  
//
//  Created by Furqan on 16/07/2022.
//  Email: furqan.cloud.dev@gmail.com

import Vapor
import Fluent
import FluentMongoDriver
import Foundation

final class User: Model, AsyncResponseEncodable, Content {
    func encodeResponse(for request: Request) async throws -> Response {
        let res = Response(status: .ok)
        return res
    }
    
    // Name of the table or collection.
    static let schema = "users"

    // Unique identifier - MongoDB ObjectID
    @ID(custom: .id)
    var id: ObjectId?

//    var id: String?
//
//    @Field(key: "user_id")
//    var userId: UUID = UUID()

    
    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    init() { }

    // Creates a new User with all properties set.
    init(id: ObjectId? = nil, name: String, email: String) {
        self.id = id
//        self.userId = userId
        self.name = name
        self.email = email
    }
}

# swift-on-server-rest-api-vapor-mongodb
Swift is a general-purpose programming language built using a modern approach to safety & performance that make it specifically suitable for Server applications. Vapor is a web framework for Swift, allowing you to write backends, web apps APIs and HTTP servers in Swift
<br/><br/>

This Project domonstrate the latest Swift on Server to create RESTFul API's connected via Database: MongoDB NoSql 
<br/>

Swift 5.5+ - support async/await structured concurrency pattern <br/>
( https://developer.apple.com/videos/play/wwdc2021/10132 )
<br/><br/>
Requirements: mac OS Monterey (v 12), Xcode 13.0 
<br/>
Clone the repo <br/>
Open the folder "hello" in Xcode 13 or later <br/>
Package dependencies will be installed by Xcode <br/>
MongoDB instance required at cloud or localhost: "mongodb://localhost:27017/vapor" <br/>

Run the project -> http Server will be available at:   Server starting on http://127.0.0.1:8080 <br/><br/>

From Postman following APIs are accessible:<br/>

Create User :    [ POST ] http://localhost:8080/users <br/>
Get All Users :  [ GET ] http://localhost:8080/users <br/><br/>

JWT Authentication Middleware: <br/>
Login :          [ POST ] http://localhost:8080/login <br/>
Response: { "token": "eyJhbG..." } <br/><br/>

Header: [ 'Authorization': Bearer eyJhbGciO... ] <br/>
Get A User:      [ GET ] http://localhost:8080/users/id <br/><br/>


Deployments options available via Docker, Systemd, Supervisor for Linux / Unix based OS <br/><br/>
Vapor Framework <br/>
https://vapor.codes/
<br/><br/>
If you are interested to know more about the Future of SwiftOnServer, please check my recent post:
<br/>
https://www.linkedin.com/posts/muhammad-furqan-121b691a_swiftonserver-swift-server-activity-6954367874148749312-JBrD?utm_source=linkedin_share&utm_medium=member_desktop_web
<br/><br/><br/>

Furqan<br/>
(Software Developer / Solution Architect)

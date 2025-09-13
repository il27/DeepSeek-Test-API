//
//  Model.swift
//  DeepSeek Test API
//
//  Created by Ильяс on 25.07.2025.
//

import Foundation

struct AIRequestBody: Encodable {
    let model: String
    let messages: [Message]
}

struct Message: Encodable {
    let role: String
    let content: String
}

struct AIResponse: Decodable {
    let choices: [Choice]
    
    struct Choice: Decodable {
        let message: ResponseMessage
    }
    
    struct ResponseMessage: Decodable {
        let role: String
        let content: String
    }
}

//{
//  "model": "deepseek/deepseek-r1-0528:free",
//  "messages": [
//    {
//      "role": "user",
//      "content": "What is the meaning of life?"
//    }
//  ]
//  
//}
//123

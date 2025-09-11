//
//  RequestDeepSeek.swift
//  DeepSeek Test API
//
//  Created by Ильяс on 25.07.2025.
//

/*
 COMMIT MESSAGER
 
 NEW FEATURE:
 [Feature] Deacription of the feature
 [Feature] если добавил какую-то функцию в код
 
 BUG NOT IN PRODUCTION:
 [Bug] Description of the bug
 [Bug] Исправление бага в приложении
 
 RELESE:
 [Release] Description of release
 [Release] Если выпустил новую версию и отправил в продакшен
 
 BUG IN PRODUCTION:
 [Patch] Description of the bug
 [Patch] Исправление уже существующих функций в релизе
 
 MUNDANE TASKS:
 [Clean] Description of changes
 [Clean] Чистка и приведение в порядок существующего кода
*/

import Foundation

class RequestDeepSeek {
    private let apiKey = "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"
    private let urlDeepSeek = "https://openrouter.ai/api/v1/chat/completions"
    
    func sendRequest(message: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlDeepSeek) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let requestBody = AIRequestBody(
            model: "deepseek/deepseek-r1-0528:free",
            messages: [Message(role: "user", content: message)]
        )
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completion(.failure(NSError(domain: "HTTP Error", code: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AIResponse.self, from: data)
                if let firstChoice = response.choices.first {
                    completion(.success(firstChoice.message.content))
                } else {
                    completion(.failure(NSError(domain: "No Choices", code: -2)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


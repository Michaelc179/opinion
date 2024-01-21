////
////  APIService.swift
////  CEREBRUS MAXIMUS
////
////  Created by Jack Blair on 10/13/23.
////
//
//import Firebase
//import FirebaseFirestore
//import Foundation
//
//
//public class APIService {
//    
//    public static let shared = APIService()
//    
//    private init() {}
//    
////    func processChunk(audioFile: URL, startTime: Int, completion: @escaping (AudioChunk?) -> Void) {
////        let url = AudioChunkResource().url
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        
////        let boundary = "Boundary-\(UUID().uuidString)"
////        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////        
////        print(request)
////        print(Auth.auth().currentUser?.displayName)
////        
////        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
////            if let error = error {
////                // Handle error
////                print(error.localizedDescription)
////                completion(nil)
////                return
////            }
////            
////            if let token = token {
////                request.addValue("\(token)", forHTTPHeaderField: "Authorization")
////                print("Auth Token")
////                print(token)
////            }
////            
////            
////            var httpBody = Data()
////            
////            // Add audio file to form data
////            do {
////                let audioData = try Data(contentsOf: audioFile)
////                httpBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
////                let filename = "\(startTime).m4a" // Use startTime variable in the filename
////                httpBody.append("Content-Disposition: form-data; name=\"audioFile\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
////                httpBody.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!) // Change content type to audio/m4a
////                httpBody.append(audioData)
////                httpBody.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
////            } catch {
////                print("Failed to load audio data: \(error)")
////                completion(nil)
////                return
////            }
////            
////            request.httpBody = httpBody
////            
////            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
////                guard let data = data else {
////                    completion(AudioChunk(transcribedText: "", recordingChunkURL: "", recordingStored: false, audioTranscribed: false, startTime: startTime))
////                    return
////                }
////                print(data)
////                
////                do {
////                    let response = try JSONDecoder().decode(AudioChunkResponse.self, from: data)
////                    print(response.transcribedText)
////                    print(response.error)
////                    completion(AudioChunk(transcribedText: response.transcribedText, recordingChunkURL: response.recordingChunkURL, recordingStored: response.recordingStored, audioTranscribed: response.audioTranscribed, startTime: startTime))
////                } catch {
////                    print("Failed to decode JSON: \(error)")
////                    completion(nil)
////                }
////            }
////            task.resume()
////        })
////    }
//    
////    func setNotificationToken(notificationToken: String, completion: @escaping (Bool) -> Void) {
////        print("setNotificationToken")
////        guard let uid = Auth.auth().currentUser?.uid else {
////            print("Not able to find Auth for BronzeWaffle API Call")
////            completion(false)
////            return
////        }
////        
////        let parameters = ["notificationToken": notificationToken]
////        let url = SetNotificationTokenResource().url
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        
////        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
////            if let error = error {
////                // Handle error
////                print(error.localizedDescription)
////                completion(false)
////                return
////            }
////            
////            if let token = token {
////                request.addValue("\(token)", forHTTPHeaderField: "Authorization")
////            }
////            
////            do {
////                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
////            } catch {
////                print("Failed to serialize parameters to JSON: \(error)")
////                completion(false)
////                return
////            }
////            
////            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
////                guard let data = data else {
////                    completion(false)
////                    return
////                }
////                
////                let jsonString = String(data: data, encoding: .utf8)
////                
////                do {
////                    print(jsonString)
////                    let response = try JSONDecoder().decode(SuccessResponse.self, from: data)
////                    completion(response.success)
////                    
////                } catch {
////                    print("Failed to decode JSON: \(error)")
////                    completion(false)
////                }
////            }
////            task.resume()
////        })
////    }
//    
//    func createNewUser(firstName: String, lastName: String, email: String, referredBy: String?, completion: @escaping (User?) -> Void) {
//        guard let userID = Auth.auth().currentUser?.uid else {
//            print("Not able to find Auth for BronzeWaffle API Call")
//            completion(nil)
//            return
//        }
//        
//        let parameters: [String: Any] = [
//            "firstName": firstName,
//            "lastName": lastName,
//            "email": email,
//            "userID": userID,
//            "referredBy": referredBy ?? ""
//        ]
//        
//        let url = CreateNewUserResource().url
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
//            if let error = error {
//                // Handle error
//                print(error.localizedDescription)
//                return
//            }
//            if let token = token {
//                request.addValue("\(token)", forHTTPHeaderField: "Authorization")
//            }
//            
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                print("Failed to serialize parameters to JSON: \(error)")
//                return
//            }
//            
//            //            if let httpBody = request.httpBody, let httpBodyString = String(data: httpBody, encoding: .utf8) {
//            //                print("HTTP body: \(httpBodyString)")
//            //            }
//            
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    completion(nil)
//                    return
//                }
//                let jsonString = String(data: data, encoding: .utf8)
//                
//                do {
//                    print(jsonString)
//                    let response = try JSONDecoder().decode(UserResponse.self, from: data)
//                    print(response.userData)
//                    completion(response.userData)
//                } catch {
//                    print("Failed to decode JSON: \(error)")
//                    completion(nil)
//                }
//            }
//            task.resume()
//            
//        })
//    }
//    
//    func queryHumanCallback(communicationID: String, userResponse: String, completion: @escaping (Bool) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("Not able to find Auth for BronzeWaffle API Call")
//            completion(false)
//            return
//        }
//        
//        let parameters = ["communicationID": communicationID, "userResponse": userResponse]
//        let url = QueryHumanCallbackResource().url
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let timeoutInterval: TimeInterval = 60 * 60 * 24 * 365  // 1 year
//        request.timeoutInterval = timeoutInterval
//        
//        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
//            if let error = error {
//                // Handle error
//                print(error.localizedDescription)
//                completion(false)
//                return
//            }
//            
//            if let token = token {
//                request.addValue("\(token)", forHTTPHeaderField: "Authorization")
//            }
//            
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                print("Failed to serialize parameters to JSON: \(error)")
//                completion(false)
//                return
//            }
//            
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    completion(false)
//                    return
//                }
//                
//                let jsonString = String(data: data, encoding: .utf8)
//                
//                do {
//                    print(jsonString)
//                    let response = try JSONDecoder().decode(SuccessResponse.self, from: data)
//                    completion(response.success)
//                    
//                } catch {
//                    print("Failed to decode JSON: \(error)")
//                    completion(false)
//                }
//            }
//            task.resume()
//        })
//    }
//    
//    func sendContacts(contacts: [ExtendedContact], completion: @escaping (Bool) -> Void) {
//            let url = SendContactsResource().url
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    completion(false)
//                    return
//                }
//                
//                if let token = token {
//                    request.addValue("\(token)", forHTTPHeaderField: "Authorization")
//                }
//                
//                do {
//                    let jsonData = try JSONEncoder().encode(contacts)
//                    request.httpBody = jsonData
//                } catch {
//                    print("Failed to encode contacts to JSON: \(error)")
//                    completion(false)
//                    return
//                }
//                
//                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                    guard let data = data else {
//                        completion(false)
//                        return
//                    }
//                    
//                    let jsonString = String(data: data, encoding: .utf8)
//                    print(jsonString ?? "No JSON String")
//                    
//                    do {
//                        let response = try JSONDecoder().decode(SuccessResponse.self, from: data)
//                        completion(response.success)
//                        
//                    } catch {
//                        print("Failed to decode JSON: \(error)")
//                        completion(false)
//                    }
//                }
//                task.resume()
//            })
//        }
//    
//    func deleteUser(completion: @escaping (Bool) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("Not able to find Auth for BronzeWaffle API Call")
//            completion(false)
//            return
//        }
//        
//        let url = QueryHumanCallbackResource().url
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        Auth.auth().currentUser?.getIDToken(completion: { (token, error) in
//            if let error = error {
//                // Handle error
//                print(error.localizedDescription)
//                completion(false)
//                return
//            }
//            
//            if let token = token {
//                request.addValue("\(token)", forHTTPHeaderField: "Authorization")
//            }
//            
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    completion(false)
//                    return
//                }
//                
//                let jsonString = String(data: data, encoding: .utf8)
//                
//                do {
//                    print(jsonString)
//                    let response = try JSONDecoder().decode(SuccessResponse.self, from: data)
//                    completion(response.success)
//                    
//                } catch {
//                    print("Failed to decode JSON: \(error)")
//                    completion(false)
//                }
//            }
//            task.resume()
//        })
//    }
//    
//    func queryHuman(query: String, agentID: String? = nil, agentName: String? = nil, completion: @escaping (QueryHumanResponse?) -> Void) {
//        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("Not able to find Auth for BronzeWaffle API Call")
//            completion(nil)
//            return
//        }
//    
//        let currentTimestamp = Date().timeIntervalSince1970
//        let communicationID = "\(uid)-\(currentTimestamp)"
//     
//        
//            let parameters: [String: Any] = [
//                "apiKey": uid,
//                "query": query,
//                "communicationID": communicationID,
//                "agentID": agentID ?? "",
//                "agentName": agentName ?? ""
//            ]
//
//        let url = QueryHumanResource().url
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                print("Failed to serialize parameters to JSON: \(error)")
//                completion(nil)
//                return
//            }
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    completion(nil)
//                    return
//                }
//
//                do {
//                    let response = try JSONDecoder().decode(QueryHumanResponse.self, from: data)
//                    completion(response)
//                } catch {
//                    print("Failed to decode JSON: \(error)")
//                    completion(nil)
//                }
//            }
//            task.resume()
//        }
//}
//

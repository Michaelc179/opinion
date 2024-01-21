//
//  QuestionView.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//

import SwiftUI
//import SwiftData
import Firebase

struct QuestionView: View {
    let defaults = UserDefaults.standard
    struct DefaultsKeys {
        static let userEmoji = "firstStringKey"
    }
    
    var databaseRef: DatabaseReference!

        init() {
            // Set the reference to the root of your database
            databaseRef = Database.database().reference()
        }
//    databaseRef = Database.database().reference()
    @State private var textInput: String = ""
    @State private var isAnswered: Bool = false
    @State private var currentQuestion: String = "Are mashed potatoes just Irish guacamole?" // change to firebase axios call (I think)

    var body: some View {
        ZStack {
            if !isAnswered {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .bottom, spacing: 10) {
                        Text("opinions")
                            .font(Font.custom("DMSerifText-Regular", size: 35))
                            .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                    }
                    .padding(.leading, 30)
                    
                    Text(currentQuestion)
                        .font(Font.custom("PTSerif-Regular", size: 25))
                        .foregroundColor(Color.white)
                        .padding(.leading, 30)
                    
                    TextField("Enter text", text: $textInput, onCommit: {
                        isAnswered = true
                        print("ANSWERED!!!!")
                        let dataToWrite: [String: Any] = [
                                            "timestamp": Int(Date().timeIntervalSince1970),
                                            "numLikes": 0,
                                            "response": textInput,
                                            "userEmoji": "🥹",
                                            "likedBy": [],
                                            "userID": UIDevice.current.identifierForVendor!.uuidString
                                        ]
                        writeToDatabase(data: dataToWrite)
                        
                    })
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 15)
                    .font(Font.custom("PTSerif-Regular", size: 25))
                    
                }
            } else {
                AnswerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.06, green: 0.06, blue: 0.06))
        }
            
        }
        
    }
    
    func writeToDatabase(data: [String: Any]) {
            // Create a child reference with a unique ID
        print("called")
        let db = Firestore.firestore()
        let questionDoc = db.collection("questions").document("questionID")
        questionDoc.updateData([
            "responses." + UUID().uuidString : data
        ]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Response successfully appended!")
            }
        }
        
//        let responsesRef = databaseRef.child("questions").child("questionID").child("responses")
//        print(responsesRef)
//        responsesRef.observeSingleEvent(of: .value) { (snapshot) in
//            print("called1")
//            if var currentResponses = snapshot.value as? [[String: Any]] {
//                print("called2")
//                // Append the new response data to the array
//                currentResponses.append(data)
//
//                // Update the "responses" array in Firebase
//                responsesRef.setValue(currentResponses) { (error, _) in
//                    if let error = error {
//                        print("Error appending response to Firebase: \(error.localizedDescription)")
//                    } else {
//                        print("Response appended successfully!")
//                    }
//                }
//            } else {
//                print("called3")
//                // If the array doesn't exist yet, create a new one with the new response data
//                responsesRef.setValue([data]) { (error, _) in
//                    if let error = error {
//                        print("Error creating and appending response to Firebase: \(error.localizedDescription)")
//                    } else {
//                        print("Response array created and response appended successfully!")
//                    }
//                }
//            }
        }
//            let newResponseRef = responsesRef.childByAutoId()
//
//            // Write the dictionary to the child reference
//            newResponseRef.setValue(data) { (error, _) in
//                if let error = error {
//                    print("Error writing to Firebase: \(error.localizedDescription)")
//                } else {
//                    print("Data written successfully!")
//                }
//            }
//        }
}



#Preview {
    QuestionView()
}

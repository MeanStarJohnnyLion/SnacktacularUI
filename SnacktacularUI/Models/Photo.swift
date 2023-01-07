//
//  Photo.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 1/7/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = "" // This will hold the URL for loading the image
    var description = ""
    var reviewer = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    
    
    var dictionary: [String: Any] {
        return  ["imageURLString": imageURLString, "description": description, "reviewer": reviewer,"postedOn": Timestamp(date: Date())]
    }
}

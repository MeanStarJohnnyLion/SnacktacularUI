//
//  ReviewViewModel.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 11/29/22.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var review = Review()
    
    
    func saveReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        
        guard let spotID = spot.id else {
            print("😡 ERROR: spot.id = nill")
            return false
        }
       
        let collectionString = "spots/\(spotID)/reviews"
        
        if let id = review.id {
            do  {
                try await db.collection(collectionString).document(id).setData(review.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'reviews' \(error.localizedDescription)")
                return false
            }
        } else {
                do {
                    _ = try await db.collection(collectionString).addDocument(data: review.dictionary)
                    print("🐣 Data added successfully")
                    return true
                    
                } catch {
                    print("😡 ERROR: Could not create a new review in 'reviews' \(error.localizedDescription)")
                    return false
                }
            }
        }
    }

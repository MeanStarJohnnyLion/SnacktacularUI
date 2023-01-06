//
//  ReviewView.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 11/28/22.
//

import SwiftUI
import Firebase

struct ReviewView: View {
    @StateObject var reviewVM  = ReviewViewModel()
    @State var spot: Spot
    @State var review: Review
    @State var postedByThisUser = false
    @State var rateOrReviewerString = "Click to Rate:"// Otherwise will say poster email and date
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(spot.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text(spot.address)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(rateOrReviewerString)
                .font(postedByThisUser ?  .title2 : .subheadline)
                .bold(postedByThisUser)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal)
            HStack {
                StarsSelectionView(rating: $review.rating)
                    .disabled(!postedByThisUser) // disable if not posted by this user
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0)
                    }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Review Title:")
                    .bold()
                
                TextField("Title", text: $review.title)
                    .padding(.horizontal, 6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0.3)
                    }
                Text("Review")
                    .bold()
                TextField("review", text: $review.body, axis: .vertical)
                    .padding(.horizontal, 6)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0.3)
                    }
                
            }
            .disabled(!postedByThisUser) // disable if not posted by this user.No Editing!
            .padding(.horizontal)
            .font(.title2)
            
            
            Spacer()
            
        }
        .onAppear {
            if review.reviewer == Auth.auth().currentUser?.email {
                postedByThisUser = true
            } else {
                let reviewPostedOn = review.postedOn.formatted(date: .numeric, time: .omitted)
                rateOrReviewerString = "by:\(review.reviewer) on: \(reviewPostedOn)"
            }
        }
        .navigationBarBackButtonHidden(postedByThisUser)// Hide back button if posted by this user
        .toolbar {
            if postedByThisUser {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await reviewVM.saveReview(spot: spot, review: review)
                            if success {
                                dismiss()
                            } else {
                                print("😡 ERROR saving data in reviewView")
                            }
                        }
                    }
                }
            }
            
            if review.id != nil {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Spacer()
                    
                    Button {
                        Task {
                            let success = await reviewVM.deleteReview(spot: spot, review: review)
                            if success {
                                dismiss()
                            }
                        }
                       
                    } label: {
                        Image(systemName: "trash")
                    
                    
                }
            }
            }
                
            
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReviewView(spot: Spot(name: "Shake Shack", address: "49 Boyleston St., Chestnut Hill, MA 02467"), review: Review())
        }
    }
}

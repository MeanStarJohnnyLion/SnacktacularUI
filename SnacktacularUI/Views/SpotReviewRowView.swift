//
//  SpotReviewRowView.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 12/3/22.
//

import SwiftUI

struct SpotReviewRowView: View {
    
    @State var review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.title)
                .font(.title2)
            HStack {
                StarsSelectionView(rating: $review.rating, interactive: false, font: .callout)
                Text(review.body)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
    }
}

struct SpotReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpotReviewRowView(review: Review(title: "Fantastic Food!", body: "I love this place so much", rating: 4))
    }
}

//
//  PlaceViewModel.swift
//  PlaceLookupDemo
//
//  Created by Johnny Lion on 11/18/22.
//

import Foundation
import MapKit

@MainActor
class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    func search(text: String, region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("😡 ERROR: \(error?.localizedDescription ?? "Unkown Error")")
                return
            }
            self.places = response.mapItems.map(Place.init)
        }
    }
}
 

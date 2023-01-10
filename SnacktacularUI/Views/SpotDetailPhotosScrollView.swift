//
//  SpotDetailPhotosScrollView.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 1/10/23.
//

import SwiftUI

struct SpotDetailPhotosScrollView: View {
//    struct FakePhoto: Identifiable {
//        let id = UUID().uuidString
//        var uimageURLString = "https://firebasestorage.googleapis.com:443/v0/b/snacktacularui-814fb.appspot.com/o/c8dIdLTBWyihsodojcpI%2FAE3DF9BC-ED20-426D-A76C-9D7BD1E4910F.jpeg?alt=media&token=d083b554-6e3c-4156-ae11-6eed4b9266e7"
//    }
//
//    let photos = [FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(),]
//
    
    @State private var showPhotoViewerView = false
    @State private var uiImage = UIImage()
    @State private var selectedPhoto = Photo()
    var photos: [Photo]
    var spot : Spot
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack (spacing: 4) {
                ForEach(photos) { photo in
                    let imageURL = URL(string: photo.imageURLString) ?? URL(string: "")
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            // Order is important here!
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                            .onTapGesture {
                                let renderer = ImageRenderer(content: image)
                                selectedPhoto = photo
                                uiImage = renderer.uiImage ?? UIImage()
                                showPhotoViewerView.toggle()
                            }
                        
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }

                    
                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 4)
        .sheet(isPresented: $showPhotoViewerView) {
            PhotoView(photo: $selectedPhoto, uiImage: uiImage, spot: spot)
        }
    }
}

struct SpotDetailPhotosScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailPhotosScrollView(photos: [Photo(imageURLString: "https://firebasestorage.googleapis.com:443/v0/b/snacktacularui-814fb.appspot.com/o/c8dIdLTBWyihsodojcpI%2FAE3DF9BC-ED20-426D-A76C-9D7BD1E4910F.jpeg?alt=media&token=d083b554-6e3c-4156-ae11-6eed4b9266e7")], spot: Spot(id: "c8dIdLTBWyihsodojcpI"))
    }
}

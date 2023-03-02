//
//  FaceDisplayView.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/22/22.
//

import SwiftUI
import MapKit

struct FaceDisplayView: View {
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    VStack {
      if let image = viewModel.namedFace.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Image(systemName: "person.crop.square")
          .resizable()
          .scaledToFit()
          .padding()
      }
      
      Button(viewModel.showingMeetLocation ? "Hide meet location" : "Show meet location") {
        withAnimation {
          viewModel.showingMeetLocation.toggle()
        }
      }
      
      if viewModel.showingMeetLocation {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.annotations) { annotation in
          MapAnnotation(coordinate: annotation.coordinate) {
            ZStack {
              Image(systemName: "circle")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(.white)
                .clipShape(Circle())
              Image(systemName: "figure.stand.line.dotted.figure.stand")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 35, height: 25)
            }
          }
        }
        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
      } else {
        Spacer()
      }
    }
    .navigationTitle("\(viewModel.namedFace.name)")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  init(namedFace: NamedFace) {
    _viewModel = StateObject(wrappedValue: ViewModel(namedFace: namedFace))
  }
}

struct FaceDisplayView_Previews: PreviewProvider {
  static var previews: some View {
    FaceDisplayView(namedFace: .example)
  }
}

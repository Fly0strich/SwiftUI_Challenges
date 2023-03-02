//
//  FaceDisplayView-ViewModel.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/23/22.
//

import SwiftUI
import MapKit

extension FaceDisplayView {
  struct IdentifiableLocation: Identifiable {
    var id: UUID
    var coordinate: CLLocationCoordinate2D
  }
  
  @MainActor class ViewModel: ObservableObject {
    @Published var showingMeetLocation: Bool
    @Published var mapRegion: MKCoordinateRegion
    
    let namedFace: NamedFace
      
    var annotations: [IdentifiableLocation] {
      var array = [IdentifiableLocation]()
      if let meetLocation = namedFace.meetLocation {
        array.append(IdentifiableLocation(id: UUID(), coordinate: meetLocation))
      }
      return array
    }
    
    init(namedFace: NamedFace) {
      self.namedFace = namedFace
      self.showingMeetLocation = false
      let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      let mapCenter = namedFace.meetLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
      self.mapRegion = MKCoordinateRegion(center: mapCenter, span: mapSpan)
    }
  }
}

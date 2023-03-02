//
//  NamedFace.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/17/22.
//

import MapKit
import SwiftUI

struct NamedFace: Codable, Comparable, Equatable, Identifiable {
  static let example = NamedFace(id: UUID(), name: "James Bond", image: nil, meetLocation: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141))
  
  var id: UUID
  var name: String
  var image: UIImage?
  var meetLocation: CLLocationCoordinate2D?
  
  enum CodingKeys: CodingKey {
    case id
    case name
    case image
    case meetLatitude
    case meetLongitude
  }
  
  init(id: UUID, name: String, image: UIImage?, meetLocation: CLLocationCoordinate2D?) {
    self.id = id
    self.name = name
    self.image = image
    self.meetLocation = meetLocation
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    let imageData = try container.decode(Data.self, forKey: .image)
    self.image = UIImage(data: imageData)
    let meetLatitude = try container.decode(Double.self, forKey: .meetLatitude)
    let meetLongitude = try container.decode(Double.self, forKey: .meetLongitude)
    self.meetLocation = CLLocationCoordinate2D(latitude: meetLatitude, longitude: meetLongitude)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    let imageData = image?.jpegData(compressionQuality: 0.8)
    try container.encode(imageData ?? Data(), forKey: .image)
    try container.encode(meetLocation?.latitude ?? 0, forKey: .meetLatitude)
    try container.encode(meetLocation?.longitude ?? 0, forKey: .meetLongitude)
  }
  
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
  
  static func <(lhs: Self, rhs: Self) -> Bool {
    lhs.name < rhs.name
  }
}

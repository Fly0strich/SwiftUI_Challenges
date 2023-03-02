//
//  ContentView-ViewModel.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/17/22.
//

import MapKit
import SwiftUI

extension ContentView {
  @MainActor class ViewModel: ObservableObject {
    @Published var namedFaces: [NamedFace]
    @Published var selectedImage: UIImage?
    @Published var showingImagePicker = false
    @Published var showingEditView = false
    
    var sortedNamedFaces: [NamedFace] {
      namedFaces.sorted()
    }
    
    let locationFetcher = LocationFetcher()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("NamedFaces")
    
    init() {
      do {
        let data = try Data(contentsOf: savePath)
        namedFaces = try JSONDecoder().decode([NamedFace].self, from: data)
      } catch {
        namedFaces = []
        print("Unable to load saved data")
      }
    }
    
    func addNamedFace(newNamedFace: NamedFace) {
      namedFaces.append(newNamedFace)
      save()
    }
    
    func save() {
      do {
        let data = try JSONEncoder().encode(namedFaces)
        try data.write(to: savePath, options: [.atomic])
      } catch {
        print("Unable to save data")
      }
    }
  }
}

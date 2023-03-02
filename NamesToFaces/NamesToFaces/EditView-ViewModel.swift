//
//  EditView-ViewModel.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/18/22.
//

import SwiftUI

extension EditView {
  @MainActor class ViewModel: ObservableObject {
    @Published var namedFace: NamedFace
    @Published var showingImagePicker: Bool
    
    init(namedFace: NamedFace) {
      self.namedFace = namedFace
      self.showingImagePicker = false
    }
  }
}

//
//  ImagePicker.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/11/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
            
      guard let provider = results.first?.itemProvider else { return }
      
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, _ in
          Task { @MainActor in
            self.parent.image = image as? UIImage
          }
        }
      }
    }
  }
  
  @Binding var image: UIImage?
  
  func makeUIViewController(context: Context) -> some UIViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    //This function is not used in this app but must be defined to conform to UIViewControllerRepresentable
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

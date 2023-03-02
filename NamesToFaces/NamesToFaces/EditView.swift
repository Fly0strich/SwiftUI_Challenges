//
//  EditView.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/18/22.
//

import SwiftUI

struct EditView: View {
  @Environment(\.dismiss) private var dismiss
  
  @StateObject var viewModel: ViewModel
  
  var onSave: (NamedFace) -> Void
  
  var body: some View {
    NavigationView {
      VStack {
        VStack {
          if let image = viewModel.namedFace.image {
            Image(uiImage: image)
              .resizable()
              .scaledToFit()
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.blue, lineWidth: 2))
              .padding([.horizontal, .top])
          } else {
            Image(systemName: "person.crop.square")
              .resizable()
              .scaledToFit()
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .padding([.horizontal, .top])
          }
          
          HStack {
            Spacer()
            
            Button {
              viewModel.showingImagePicker = true
            } label: {
              Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFit()
                .frame(width:50, height: 50)
                .foregroundColor(.secondary.opacity(0.5))
                .padding()
            }
          }
          .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(image: $viewModel.namedFace.image)
          }
        }
        Form {
          TextField("Name", text: $viewModel.namedFace.name)
            .font(.largeTitle.bold())
        }
      }
      .navigationTitle("Edit Info")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button("Save") {
          onSave(viewModel.namedFace)
          dismiss()
        }
      }
    }
  }
  
  init(namedFace: NamedFace, onSave: @escaping (NamedFace) -> Void) {
    _viewModel = StateObject(wrappedValue: ViewModel(namedFace: namedFace))
    self.onSave = onSave
  }
}

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(namedFace: NamedFace.example) { newFace in }
  }
}

//
//  ContentView.swift
//  NamesToFaces
//
//  Created by Shae Willes on 9/16/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ViewModel()
  
  var body: some View {
    NavigationView {
      List() {
        ForEach(viewModel.sortedNamedFaces) { namedFace in
          NavigationLink {
            FaceDisplayView(namedFace: namedFace)
          } label: {
            HStack {
              if let image = namedFace.image {
                Image(uiImage: image)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100)
                  .background(.black)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.blue, lineWidth: 1))
                  .padding([.trailing])
              } else {
                Image(systemName: "person.crop.square")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .padding([.trailing])
              }
              
              Text(namedFace.name)
                .font(.title)
                .foregroundColor(.blue)
            }
          }
        }
        .onDelete(perform: deleteNamedFace)
      }
      .navigationTitle("Names to Faces")
      .toolbar {
        Button {
          viewModel.showingImagePicker = true
        } label: {
          Image(systemName: "plus")
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
          ImagePicker(image: $viewModel.selectedImage)
        }
      }
      .onChange(of: viewModel.selectedImage) { _ in
        viewModel.locationFetcher.start()
        viewModel.showingEditView = true
      }
      .sheet(isPresented: $viewModel.showingEditView) {
        EditView(namedFace: NamedFace(id: UUID(), name: "", image: viewModel.selectedImage, meetLocation: viewModel.locationFetcher.lastKnownLocation)) { newNamedFace in
          viewModel.addNamedFace(newNamedFace: newNamedFace)
        }
      }
    }
  }
  
  func deleteNamedFace(at offsets: IndexSet) {
    Task { @MainActor in
      for offset in offsets {
        let deletableID = viewModel.sortedNamedFaces[offset].id
        let deletableIndex = viewModel.namedFaces.firstIndex(where: { $0.id == deletableID })
        viewModel.namedFaces.remove(at: deletableIndex!)
      }
      viewModel.save()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

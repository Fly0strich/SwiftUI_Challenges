//
//  AddActivityView.swift
//  OnTrack
//
//  Created by Shae Willes on 9/1/22.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let item = Activity(name: name, description: description, counter: 0)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}

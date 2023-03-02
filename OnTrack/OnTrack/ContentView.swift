//
//  ContentView.swift
//  OnTrack
//
//  Created by Shae Willes on 9/1/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var addItemShowing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        ActivityDescriptionView(activities: activities, activity: item)
                    } label: {
                        Text(item.name)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("OnTrack")
            .toolbar {
                Button {
                    addItemShowing = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $addItemShowing) {
            AddActivityView(activities: activities)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

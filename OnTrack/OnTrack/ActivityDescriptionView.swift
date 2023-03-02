//
//  ActivityDescriptionView.swift
//  OnTrack
//
//  Created by Shae Willes on 9/1/22.
//

import SwiftUI

struct ActivityDescriptionView: View {
    @ObservedObject var activities: Activities
    
    var activity: Activity

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .font(.title)
                    .padding()
                
                Text("Number of times completed: \(activity.counter)")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .navigationTitle(activity.name)
            .toolbar {
                Button {
                    var tempActivity = activity
                    tempActivity.counter += 1
                    activities.items[activities.items.firstIndex(of: activity)!] = tempActivity
                } label: {
                    HStack{
                        Text("Completed")
                        Image(systemName: "checkmark.square")
                    }
                }
            }
        }
    }
}

struct ActivityDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewActivity = Activity(name: "Name", description: "Description of activity", counter: 0)

        ActivityDescriptionView(activities: Activities(), activity: previewActivity)
    }
}

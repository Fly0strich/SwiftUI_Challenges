//
//  ContentView.swift
//  FriendFace
//
//  Created by Shae Willes on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                
                                Text(user.company)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if user.isActive {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.green)
                                    .overlay(Circle().strokeBorder(.secondary, lineWidth: 1))
                            } else {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.red)
                                    .overlay(Circle().strokeBorder(.secondary, lineWidth: 1))
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if users.isEmpty {
                    await loadOnlineData()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func loadOnlineData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("error: Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            decoder.dateDecodingStrategy = .iso8601
            if let decodedUsers = try? decoder.decode([User].self, from: data) {
                users = decodedUsers
                storeOfflineData()
                print("Data Loaded From URL Successfully!")
            } else {
                print("error: Unable to decode data")
            }
        } catch {
            print("error: Unable to retrieve data from URL")
            await MainActor.run {
                loadOfflineData()
            }
        }
    }
    
    func loadOfflineData() {
        for cachedUser in cachedUsers {
            var friends = [User.Friend]()
            for cachedFriend in cachedUser.friendsArray {
                let friend = User.Friend(id: cachedFriend.wrappedID, name: cachedFriend.wrappedName)
                friends.append(friend)
            }
            
            let user = User(id: cachedUser.wrappedID, isActive: cachedUser.isActive, name: cachedUser.wrappedName, age: cachedUser.age, company: cachedUser.wrappedCompany, email: cachedUser.wrappedEmail, address: cachedUser.wrappedAddress, about: cachedUser.wrappedAbout, registered: cachedUser.wrappedRegistrationDate, tags: cachedUser.wrappedTags.components(separatedBy: ","), friends: friends)
            
            users.append(user)
        }
        
        print("Data Loaded From Device Storage Successfully!")
    }
    
    func storeOfflineData() {
        for user in users {
            let cachedUser = CachedUser(context: moc)
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = user.age
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            var cachedFriends = [CachedFriend]()
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedFriends.append(cachedFriend)
            }
            cachedUser.friends = NSSet(array: cachedFriends)
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

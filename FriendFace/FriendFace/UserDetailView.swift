//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Shae Willes on 9/5/22.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)
            
            Form {
                Section {
                    HStack {
                        VStack {
                            Text("\(user.age)")
                                .font(.headline)
                            
                            Text("Age")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(user.formattedRegistrationDate)
                                .font(.headline)
                            
                            Text("Member Since")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack {
                            if user.isActive {
                                Text("Active")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            } else {
                                Text("Inactive")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            
                            Text("Status")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    VStack {
                        Text(user.about)
                            .font(.headline)
                        
                        Text("About Me")
                            .foregroundColor(.secondary)
                    }
                    
                } header: {
                    Text("Personal Info")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text(user.company)
                            .font(.headline)
                        
                        Text("Company")
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.email)
                            .font(.headline)
                        
                        Text("Email")
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.address)
                            .font(.headline)
                        
                        Text("Address")
                            .foregroundColor(.secondary)
                    }
                
                } header: {
                    Text("Contact Info")
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.headline)
                                    .padding(10)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                } header: {
                    Text("Tags")
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.friends) { friend in
                                VStack {
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                        .foregroundColor(.secondary)
                                    
                                    Text(friend.name)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                .padding(5)
                                .frame(width: 105, height: 130)
                                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.secondary, lineWidth: 3))
                            }
                        }
                    }
                } header: {
                    Text("Friends")
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let previewUser = User(id: UUID(), isActive: true, name: "Jonathan Huntbach", age: 30, company: "Apple Inc", email: "JH_RockstarNerd88@gmail.com", address: "454 Imaginary lane, Orem, UT, 84057", about: "I'm just an ordinary guy who does a lot of ordinary stuff and lives a normal life.", registered: Date.now, tags: ["cool","athlete","loser"], friends: [User.Friend]())
    
    static var previews: some View {
        UserDetailView(user: previewUser)
    }
}

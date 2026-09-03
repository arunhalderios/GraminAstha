//
//  GroupList.swift
//  Gramin Astha
//
//  Created by Sayan Das on 03/09/2026.
//

import SwiftUI
import CoreData


struct GroupList: View {
    
   // @State private var GroupsArr: [GroupModel] = []
    
    @Environment(\.managedObjectContext) private var viewContext

        @FetchRequest(
            entity: GroupEntity.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \GroupEntity.createdAt, ascending: false)
            ]
        )
    
    private var GroupsArr: FetchedResults<GroupEntity>

    @State private var showCreateGroup = false
    @State private var groupName = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                Button {
                    groupName = ""
                    showCreateGroup = true
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Create Group")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .cornerRadius(10)
                }
                Spacer(minLength: 20)
                VStack {
                    HStack {
                        Text("Group List")
                            .font(.title)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding()
                    List(GroupsArr) { group in
                        HStack(spacing: 20) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            
                            Text(group.name ?? "")
                                .font(.headline)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        // Popup
        .sheet(isPresented: $showCreateGroup) {
            VStack(spacing: 20) {
                Text("Create Group")
                    .font(.title2)
                    .bold()
                TextField("Name", text: $groupName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                Button {
//                    let trimmedName = groupName.trimmingCharacters( in: .whitespacesAndNewlines )
//                    if !trimmedName.isEmpty
//                    {
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "dd/MM/yyyy"
//
//                        let today = formatter.string(from: Date())
//
//                        
//                        //GroupsArr.append( GroupModel(name: trimmedName, createdAt: Date()))
//                        showCreateGroup = false
//                    }
                    saveGroup()
                } label: {
                    Text("Submit") .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.top, 30)
            .presentationDetents([.height(250)])
        }
    }
    
    
    // MARK: - Save Group

       private func saveGroup() {

           let trimmedName = groupName.trimmingCharacters(
               in: .whitespacesAndNewlines
           )

           guard !trimmedName.isEmpty else {
               return
           }

           let newGroup = GroupEntity(context: viewContext)

           newGroup.id = UUID()
           newGroup.name = trimmedName

           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"

           newGroup.createdAt = Date() //formatter.string(from: Date())

           do {
               try viewContext.save()

               // Close popup
               showCreateGroup = false
               groupName = ""

           } catch {
               print("Error saving group: \(error.localizedDescription)")
           }
       }
    
    
  }
 


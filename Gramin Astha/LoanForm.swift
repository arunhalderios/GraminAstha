import SwiftUI
import CoreData

struct LoanForm: View {
    
    // MARK: - Core Data
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Group Fetch
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \GroupEntity.name,
                ascending: true
            )
        ],
        animation: .default
    )
    private var groups: FetchedResults<GroupEntity>
    
    // MARK: - Member Information
    
    @State private var name = ""
    @State private var husbandName = ""
    @State private var fatherName = ""
    
    @State private var phoneNumber = ""
    @State private var aadhaarNumber = ""
    
    @State private var referenceMember = ""
    
    // MARK: - Address
    
    @State private var postOffice = ""
    @State private var place = ""
    @State private var district = ""
    @State private var pincode = ""
    
    // MARK: - Group
    
    @State private var selectedGroup: GroupEntity?
    
    // MARK: - Loan
    
    @State private var loanAmount = ""
    
    // MARK: - Alert
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                // MARK: Member Information
                
                Section("Member Information") {
                    
                    TextField(
                        "Member Name",
                        text: $name
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "Husband Name",
                        text: $husbandName
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "Father Name",
                        text: $fatherName
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "Phone Number",
                        text: $phoneNumber
                    )
                    .keyboardType(.phonePad)
                    
                    TextField(
                        "Aadhaar Number",
                        text: $aadhaarNumber
                    )
                    .keyboardType(.numberPad)
                    
                    TextField(
                        "Reference Member",
                        text: $referenceMember
                    )
                    .textInputAutocapitalization(.words)
                }
                
                // MARK: Group
                
                Section("Group") {
                    
                    if groups.isEmpty {
                        
                        Text("No groups available")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        Picker(
                            "Select Group",
                            selection: $selectedGroup
                        ) {
                            
                            Text("Select Group")
                                .tag(nil as GroupEntity?)
                            
                            ForEach(groups) { group in
                                
                                Text(group.name ?? "Unnamed")
                                    .tag(group as GroupEntity?)
                            }
                        }
                    }
                }
                
                // MARK: Address
                
                Section("Address") {
                    
                    TextField(
                        "Post Office",
                        text: $postOffice
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "Place",
                        text: $place
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "District",
                        text: $district
                    )
                    .textInputAutocapitalization(.words)
                    
                    TextField(
                        "PIN Code",
                        text: $pincode
                    )
                    .keyboardType(.numberPad)
                }
                
                // MARK: Loan
                
                Section("Loan Information") {
                    
                    HStack {
                        
                        Text("Loan Amount")
                        
                        Spacer()
                        
                        TextField(
                            "Amount",
                            text: $loanAmount
                        )
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                    }
                }
                
                // MARK: Submit
                
                Section {
                    
                    Button {
                        saveMember()
                    } label: {
                        
                        HStack {
                            Spacer()
                            
                            Image(
                                systemName: "checkmark.circle.fill"
                            )
                            
                            Text("Submit")
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Loan Form")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: Toolbar
            
            .toolbar {
                
                ToolbarItem(
                    placement: .topBarLeading
                ) {
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
            // MARK: Alert
            
            .alert(
                alertTitle,
                isPresented: $showAlert
            ) {
                
                Button("OK") {
                    
                    if alertTitle == "Success" {
                        dismiss()
                    }
                }
                
            } message: {
                
                Text(alertMessage)
            }
        }
    }
}

// MARK: - Core Data Save

extension LoanForm {
    
    private func saveMember() {
        
        // MARK: Validation
        
        let cleanName = name
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        
        guard !cleanName.isEmpty else {
            
            showError(
                "Please enter the member name."
            )
            return
        }
        
        guard !husbandName
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty else {
            
            showError(
                "Please enter the husband name."
            )
            return
        }
        
        guard selectedGroup != nil else {
            
            showError(
                "Please select a group."
            )
            return
        }
        
        guard let loan = Int64(loanAmount),
              loan > 0 else {
            
            showError(
                "Please enter a valid loan amount."
            )
            return
        }
        
        // MARK: PIN Code
        
        var pinValue: String = ""
        
        if pincode != "" {
            
//            guard let pin = String(pincode) else {
//                
//                showError(
//                    "Please enter a valid PIN code."
//                )
//                return
//            }
            
            pinValue = pincode
        }
        
        // MARK: Create Member
        
        let member = MemberEntity(
            context: viewContext
        )
        
        // MARK: Auto Generated
        
        member.id = UUID()
        member.createdAt = Date()
        
        // MARK: Member Data
        
        member.name = cleanName
        
        member.husbandName = husbandName
        member.fatherName = fatherName
        
        member.phoneNumber = phoneNumber
        member.aadhaarNumber = aadhaarNumber
        
        member.referenceMember = referenceMember
        
        // MARK: Address
        
        member.postOffice = postOffice
        member.place = place
        member.district = district
        member.pincode = pinValue
        
        // MARK: Loan
        
        member.loan = loan
        
        // MARK: Group Relationship
        
        member.group = selectedGroup
        
        // MARK: Save
        
        do {
            
            try viewContext.save()
            
            showSuccess(
                "Member and loan information saved successfully."
            )
            
        } catch {
            
            // Remove unsaved object if save fails
            
            viewContext.delete(member)
            
            showError(
                "Unable to save data.\n\n\(error.localizedDescription)"
            )
        }
    }
}

// MARK: - Alert Helpers

extension LoanForm {
    
    private func showError(_ message: String) {
        
        alertTitle = "Error"
        alertMessage = message
        showAlert = true
    }
    
    private func showSuccess(_ message: String) {
        
        alertTitle = "Success"
        alertMessage = message
        showAlert = true
    }
}


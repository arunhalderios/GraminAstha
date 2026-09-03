import SwiftUI

struct DashboardView: View {
    
    @State private var showLogoutAlert = false
    @State private var logout = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // MARK: - Background
                Color(red: 0.95, green: 0.98, blue: 0.96)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        // MARK: - Header
                        ZStack(alignment: .bottomLeading) {
                            
                            LinearGradient(
                                colors: [
                                    Color(red: 0.08, green: 0.45, blue: 0.25),
                                    Color(red: 0.18, green: 0.60, blue: 0.35)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(height: 210)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        
                                        Text("Welcome Back!")
                                            .font(.system(
                                                size: 16,
                                                weight: .medium
                                            ))
                                            .foregroundColor(.white.opacity(0.85))
                                        
                                        Text("My Dashboard")
                                            .font(.system(
                                                size: 30,
                                                weight: .bold
                                            ))
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                
                                Text("Manage your members, accounts and transactions easily.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.85))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.horizontal, 22)
                            .padding(.bottom, 25)
                        }
                        
                        // MARK: - Quick Access
                        VStack(alignment: .leading, spacing: 18) {
                            
                            Text("Quick Access")
                                .font(.system(
                                    size: 22,
                                    weight: .bold
                                ))
                                .foregroundColor(
                                    Color(red: 0.08, green: 0.30, blue: 0.18)
                                )
                            
                            LazyVGrid(
                                columns: columns,
                                spacing: 16
                            ) {
                                
                                // MARK: New Member
                                // MARK: Loan Form
                                Link(destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScRueTwWwNjEbB9pqhmI4cuOqasewCc89UaTzWY4_y3KgYG1A/viewform?usp=publish-editor4")!) {
                                    DashboardCard(
                                        title: "Loan Form",
                                        subtitle: "Apply for a loan",
                                        icon: "doc.text.fill",
                                        color: .blue
                                    )
                                }
                                
                                // MARK: New Member
                                NavigationLink {
                                    GroupList()
                                } label: {
                                    DashboardCard(
                                        title: "Group",
                                        subtitle: "Add a member",
                                        icon: "person.3.fill",
                                        color: .green
                                    )
                                }
                                
                                // MARK: Master Roll
                                NavigationLink {
                                    MasterRollView()
                                } label: {
                                    DashboardCard(
                                        title: "Master Roll",
                                        subtitle: "Manage master roll",
                                        icon: "list.clipboard.fill",
                                        color: .cyan
                                    )
                                }
                                
                                // MARK: Collection Sheet
                                NavigationLink {
                                    CollectionSheetView()
                                } label: {
                                    DashboardCard(
                                        title: "Collection Sheet",
                                        subtitle: "View collections",
                                        icon: "doc.plaintext.fill",
                                        color: .orange
                                    )
                                }
                                

                                
                                // MARK: Cash Book
                                NavigationLink {
                                    CashBookView()
                                } label: {
                                    DashboardCard(
                                        title: "Cash Book",
                                        subtitle: "Manage cash",
                                        icon: "indianrupeesign.circle.fill",
                                        color: .orange
                                    )
                                }
                                
                                // MARK: Ledger
                                NavigationLink {
                                    LedgerView()
                                } label: {
                                    DashboardCard(
                                        title: "Ledger",
                                        subtitle: "View ledger",
                                        icon: "book.closed.fill",
                                        color: .purple
                                    )
                                }
                                
                                  
                                NavigationLink {
                                    LoanForm()
                                } label: {
                                    DashboardCard(
                                        title: "Offline Data Save",
                                        subtitle: "Data save in coredata",
                                        icon: "gearshape.fill",
                                        color: .indigo
                                    )
                                }
                                
                                // MARK: Top Sheet
                                NavigationLink {
                                    TopSheetView()
                                } label: {
                                    DashboardCard(
                                        title: "Top Sheet",
                                        subtitle: "View top sheet",
                                        icon: "doc.text.fill",
                                        color: .teal
                                    )
                                }
                                

                            }
                            
                            // MARK: - Logout Button
                            Button {
                                showLogoutAlert = true
                            } label: {
                                
                                HStack(spacing: 10) {
                                    
                                    Image(
                                        systemName:
                                            "rectangle.portrait.and.arrow.right"
                                    )
                                    .font(.system(
                                        size: 18,
                                        weight: .semibold
                                    ))
                                    
                                    Text("Logout")
                                        .font(.system(
                                            size: 16,
                                            weight: .semibold
                                        ))
                                }
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.white)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 15)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(
                                            Color.red.opacity(0.25),
                                            lineWidth: 1
                                        )
                                )
                            }
                            .padding(.top, 8)
                            
                            Text("© 2026 গ্রামীণ আস্থা")
                                .font(.system(size: 11))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 5)
                        }
                        .padding(22)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            
            // MARK: - Logout Alert
            .alert(
                "Logout",
                isPresented: $showLogoutAlert
            ) {
                
                Button("Cancel", role: .cancel) { }
                
                Button("Logout", role: .destructive) {
                    logout = true
                }
                
            } message: {
                Text("Are you sure you want to logout?")
            }
            
            // MARK: - Go to PIN
            .fullScreenCover(isPresented: $logout) {
                PinView()
            }
        }
    }
}





// MARK: - Top Sheet

struct TopSheetView: View {
    
    var body: some View {
        
        VStack {
            Text("Top Sheet")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .navigationTitle("Top Sheet")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Master Roll

struct MasterRollView: View {
    
    var body: some View {
        
        VStack {
            Text("Master Roll")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .navigationTitle("Master Roll")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Collection Sheet

struct CollectionSheetView: View {
    
    var body: some View {
        
        VStack {
            Text("Collection Sheet")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .navigationTitle("Collection Sheet")
        .navigationBarTitleDisplayMode(.inline)
    }
}

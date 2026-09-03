import SwiftUI
import LocalAuthentication

struct PinView: View {
    
    @State private var pin = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var goToDashboard = false
    @State private var isAuthenticating = false
    
    let correctPin = "3514"
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // MARK: - Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    
                    Spacer()
                    
                    // MARK: - Lock Icon
                    Image(systemName: "faceid")
                        .font(.system(size: 65))
                        .foregroundColor(.green)
                    
                    // MARK: - Title
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Enter your PIN or use Face ID to continue")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    // MARK: - PIN Field
                    SecureField("Enter PIN", text: $pin)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 300)
                    
                    // MARK: - Error
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // MARK: - GO Button
                    Button {
                        verifyPin()
                    } label: {
                        Text("GO")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 300)
                            .frame(height: 50)
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    
                    // MARK: - Face ID Button
                    Button {
                        authenticateWithFaceID()
                    } label: {
                        
                        HStack(spacing: 10) {
                            Image(systemName: "faceid")
                                .font(.system(size: 22))
                            
                            Text("Unlock with Face ID")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.green)
                        .frame(maxWidth: 300)
                        .frame(height: 50)
                        .background(Color.green.opacity(0.12))
                        .cornerRadius(12)
                    }
                    .disabled(isAuthenticating)
                    
                    Spacer()
                    
                    Text("Your information is secure")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $goToDashboard) {
                DashboardView()
            }
        }
        .onAppear {
            // Automatically show Face ID when the PIN screen opens
            authenticateWithFaceID()
        }
    }
    
    
    // MARK: - PIN Verification
    
    private func verifyPin() {
        
        if pin == correctPin {
            
            showError = false
            errorMessage = ""
            
            goToDashboard = true
            
        } else {
            
            showError = true
            errorMessage = "Invalid PIN. Please try again."
        }
    }
    
    
    // MARK: - Face ID Authentication
    
    private func authenticateWithFaceID() {
        
        guard !isAuthenticating else {
            return
        }
        
        isAuthenticating = true
        showError = false
        
        let context = LAContext()
        
        var error: NSError?
        
        // Check whether biometric authentication is available
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else {
            
            isAuthenticating = false
            
            showError = true
            errorMessage = "Face ID is not available. Please enter your PIN."
            
            return
        }
        
        let reason = "Use Face ID to securely unlock the application."
        
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason
        ) { success, authenticationError in
            
            DispatchQueue.main.async {
                
                isAuthenticating = false
                
                if success {
                    
                    showError = false
                    errorMessage = ""
                    
                    goToDashboard = true
                    
                } else {
                    
                    showError = true
                    errorMessage = "Face ID authentication failed. Please use your PIN."
                }
            }
        }
    }
}

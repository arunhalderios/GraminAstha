
import SwiftUI

struct SplashView: View {
    
    @State private var goToPinScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Background
                LinearGradient(
                    colors: [
                        Color(red: 0.88, green: 0.97, blue: 0.91),
                        Color(red: 0.72, green: 0.91, blue: 0.80)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Decorative circles
                Circle()
                    .fill(Color.white.opacity(0.20))
                    .frame(width: 280, height: 280)
                    .offset(x: 150, y: -300)
                
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 220, height: 220)
                    .offset(x: -160, y: 300)
                
                // MARK: - Content
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    // Logo Container
                    ZStack {
                        
                        Circle()
                            .fill(Color.white.opacity(0.95))
                            .frame(width: 175, height: 175)
                            .shadow(
                                color: Color.black.opacity(0.15),
                                radius: 20,
                                x: 0,
                                y: 10
                            )
                        
                        Image("baseLogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 145, height: 145)
                            .clipShape(Circle())
                    }
                    
                    // App Name
                    Text("গ্রামীণ আস্থা")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(
                            Color(red: 0.08, green: 0.35, blue: 0.20)
                        )
                    
                    // Subtitle
                    Text("সবার সাথে, সবার পাশে।")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(
                            Color(red: 0.20, green: 0.45, blue: 0.30)
                        )
                    
                    Spacer()
                    
                    // Loading indicator
                    ProgressView()
                        .tint(
                            Color(red: 0.08, green: 0.35, blue: 0.20)
                        )
                        .scaleEffect(1.2)
                    
                    Text("Loading...")
                        .font(.system(size: 13))
                        .foregroundColor(
                            Color(red: 0.20, green: 0.45, blue: 0.30)
                        )
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding()
            }
            .navigationDestination(isPresented: $goToPinScreen) {
                PinView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    goToPinScreen = true
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}



import SwiftUI

// MARK: - Dashboard Card

struct DashboardCard: View {
    
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.12))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(
                            size: 22,
                            weight: .semibold
                        ))
                        .foregroundColor(color)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(
                        size: 12,
                        weight: .bold
                    ))
                    .foregroundColor(.gray.opacity(0.6))
            }
            
            Spacer()
            
            Text(title)
                .font(.system(
                    size: 16,
                    weight: .bold
                ))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 165)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: Color.black.opacity(0.07),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

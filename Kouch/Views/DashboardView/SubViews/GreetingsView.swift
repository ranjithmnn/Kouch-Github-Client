//
//  GreetingsView.swift
//  Kouch
//
//  Created by Ranjith Menon on 06/04/2026.
//

import SwiftUI

struct GreetingsView: View {
    let user: User
    
    private var timeBasedGreeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:  return "Good Morning"
        case 12..<17: return "Good Afternoon"
        default:      return "Good Evening"
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(timeBasedGreeting)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Text(user.name ?? "")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

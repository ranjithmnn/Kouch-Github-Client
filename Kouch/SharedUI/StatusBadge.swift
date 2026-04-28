//
//  StatusBadge.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//


import SwiftUI

struct StatusBadge: View {
    let state: String
    var isOpen: Bool { state.lowercased() == "open" }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: isOpen ? "circle.circle" : "checkmark.circle.fill")
            Text(state.capitalized)
        }
        .font(.caption)
        .fontWeight(.bold)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(isOpen ? Color.green.opacity(0.15) : Color.purple.opacity(0.15))
        .foregroundStyle(isOpen ? .green : .purple)
        .clipShape(Capsule())
    }
}
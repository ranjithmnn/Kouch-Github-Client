//
//  CapsuleLabel.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//


import SwiftUI

struct CapsuleLabel: View {
    let label: IssueLabel
    
    var body: some View {
        Text(label.name ?? "")
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(
                Capsule()
                    .fill(Color(hex: label.color ?? "888888").opacity(0.2))
            )
            .overlay(
                Capsule()
                    .strokeBorder(Color(hex: label.color ?? "888888").opacity(0.5), lineWidth: 1)
            )
            .foregroundColor(Color(hex: label.color ?? "888888"))
    }
}
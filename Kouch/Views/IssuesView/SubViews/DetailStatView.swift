//
//  DetailStatView.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//


import SwiftUI

struct DetailStatView: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption2).foregroundStyle(.tertiary)
            Label(value, systemImage: icon)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}
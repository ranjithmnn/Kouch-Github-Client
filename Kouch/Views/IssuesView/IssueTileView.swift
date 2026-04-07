//
//  IssueTileView.swift
//  Kouch
//
//  Created by Ranjith Menon on 07/04/2026.
//


import SwiftUI

struct IssueTileView: View {
    let issue: Issue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image(systemName: issue.state == "open" ? "circle.circle" : "checkmark.circle.fill")
                    .foregroundColor(issue.state == "open" ? .green : .purple)
                    .font(.subheadline)
                
                Text(issue.repository?.full_name ?? "Unknown Repo")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Spacer()
                
                Text("#\(issue.number ?? 0)")
                    .font(.caption)
                    .monospacedDigit()
                    .foregroundStyle(.tertiary)
            }
            Text(issue.title ?? "No Title")
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            if let labels = issue.labels, !labels.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(labels, id: \.id) { label in
                            CapsuleLabel(label: label)
                        }
                    }
                }
            }
            
            HStack(spacing: 12) {
                // Author
                Label(issue.user?.login ?? "", systemImage: "person.circle")
                
                // Comments
                if let commentCount = issue.comments, commentCount > 0 {
                    Label("\(commentCount)", systemImage: "bubble.right")
                }
                
                Spacer()
                
                // Assignees Stack
                if let assignees = issue.assignees, !assignees.isEmpty {
                    AssigneeStack(assignees: assignees)
                }
                
                Text(formatDate(issue.created_at))
            }
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    private func formatDate(_ dateStr: String?) -> String {
        // 1. Ensure the string exists
        guard let dateStr = dateStr else { return "" }
        
        // 2. Parse the ISO8601 String into a Date object
        let strategy = Date.ISO8601FormatStyle()
        guard let date = try? Date(dateStr, strategy: strategy) else {
            return ""
        }
        
        // 3. Format the Date into a relative string (e.g., "2 days ago")
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated // Use .full for "2 days ago", .abbreviated for "2d ago"
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}


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

struct AssigneeStack: View {
    let assignees: [User]
    let limit = 3 // Max images to show before adding a "+N" count
    
    var body: some View {
        HStack(spacing: -8) { // Negative spacing creates the overlap
            ForEach(assignees.prefix(limit), id: \.id) { user in
                AsyncImage(url: URL(string: user.avatar_url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))
            }
            
            if assignees.count > limit {
                Text("+\(assignees.count - limit)")
                    .font(.system(size: 8, weight: .bold))
                    .frame(width: 20, height: 20)
                    .background(Color(.secondarySystemFill))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1.5))
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (128, 128, 128)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
    }
}

#Preview {
    DashboardView()
}

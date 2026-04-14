//
//  IssueCommentsTile.swift
//  Kouch
//
//  Created by Ranjith Menon on 14/04/2026.
//


import SwiftUI

struct IssueCommentsTile: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Avatar + Username + Timestamp
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: comment.user?.avatar_url ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.2))
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(comment.user?.login ?? "Anonymous")
                        .font(.system(size: 14, weight: .semibold))
                    
                    if let dateString = comment.created_at {
                        Text(formatDate(dateString))
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            // Body Text
            Text(comment.body ?? "")
                .font(.system(size: 15))
                .lineSpacing(4)
                .foregroundColor(.primary.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
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

#Preview {
    IssueCommentsTile(comment: Comment(id: 1, body: "bdasdgyuagdtsayfdtsyfd"))
}

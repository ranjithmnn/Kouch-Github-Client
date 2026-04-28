//
//  Date+Formatting.swift
//  Kouch
//
//  Created by Ranjith Menon on 28/04/2026.
//

import Foundation

extension Date {
    /// Returns a relative time string like "2d ago" or "3 min. ago".
    var relativeFormatted: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    /// Returns an abbreviated date string like "Apr 28, 2026".
    var shortFormatted: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
}

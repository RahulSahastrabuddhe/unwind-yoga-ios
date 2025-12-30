import SwiftUI

// MARK: - Date Extensions
extension Date {
    // Get all dates for the current month
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    // Format date to string
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: - DateValue Model
struct DateValue: Identifiable, Hashable {
    let id = UUID()
    var day: Int
    let date: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

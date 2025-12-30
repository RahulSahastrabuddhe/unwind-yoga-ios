import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPushEnabled = true
    @State private var isEmailEnabled = true
    @State private var dailyReminder = true
    @State private var reminderTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notification Preferences")) {
                    Toggle("Push Notifications", isOn: $isPushEnabled)
                    Toggle("Email Notifications", isOn: $isEmailEnabled)
                }
                
                Section(header: Text("Daily Reminder")) {
                    Toggle("Enable Daily Reminder", isOn: $dailyReminder)
                    
                    if dailyReminder {
                        DatePicker("Reminder Time", 
                                selection: $reminderTime, 
                                displayedComponents: .hourAndMinute)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
                
                Section(header: Text("Notification Types")) {
                    Toggle("New Content", isOn: .constant(true))
                    Toggle("Session Reminders", isOn: .constant(true))
                    Toggle("Progress Updates", isOn: .constant(true))
                    Toggle("Special Offers", isOn: .constant(false))
                }
                
                Section(footer: Text("We'll send you notifications about your yoga practice, reminders, and updates.")) {
                    Button("Test Notification") {
                        // In a real app, this would schedule a local notification
                        print("Test notification would be triggered here")
                    }
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

import SwiftUI

struct SettingsRow: View {
    let icon: String
    let title: String
    let isDestructive: Bool
    
    init(icon: String, title: String, isDestructive: Bool = false) {
        self.icon = icon
        self.title = title
        self.isDestructive = isDestructive
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isDestructive ? .red : Theme.Colors.primary)
                .frame(width: 24)
            
            Text(title)
                .font(Theme.Typography.body)
                .foregroundColor(isDestructive ? .red : Theme.Colors.textPrimary)
            
            Spacer()
            
            if !isDestructive {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
        }
        .padding(.vertical, Theme.Spacing.md)
        .padding(.horizontal, Theme.Spacing.lg)
        .contentShape(Rectangle()) // Make the entire row tappable
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(icon: "person.circle", title: "Account Settings")
            .previewLayout(.sizeThatFits)
    }
}

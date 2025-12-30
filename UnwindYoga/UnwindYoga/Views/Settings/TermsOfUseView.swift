import SwiftUI

struct TermsOfUseView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                Text("Terms of Use")
                    .font(Theme.Typography.title1)
                    .padding(.bottom, Theme.Spacing.md)
                
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    Text("Last Updated: December 30, 2025")
                        .font(Theme.Typography.subheadline)
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    Text("""
                    Welcome to Unwind Yoga. By accessing or using our app, you agree to be bound by these Terms of Use.
                    
                    **1. Acceptance of Terms**
                    By using Unwind Yoga, you agree to these terms. If you do not agree, please do not use our app.
                    
                    **2. Use License**
                    Permission is granted to use Unwind Yoga for personal, non-commercial use only. You may not:
                    - Modify or copy the materials
                    - Use the materials for any commercial purpose
                    - Attempt to reverse engineer any software
                    - Remove any copyright or proprietary notations
                    
                    **3. Disclaimer**
                    The materials in Unwind Yoga are provided on an 'as is' basis. Unwind Yoga makes no warranties, expressed or implied.
                    
                    **4. Limitations**
                    In no event shall Unwind Yoga be liable for any damages arising out of the use or inability to use the materials.
                    
                    **5. Revisions**
                    Unwind Yoga may revise these terms at any time without notice. By using this app, you are agreeing to be bound by the current version of these terms.
                    
                    **6. Governing Law**
                    These terms are governed by the laws of the United States and you irrevocably submit to the exclusive jurisdiction of the courts in that location.
                    """)
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineSpacing(4)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(Theme.CornerRadius.medium)
                .shadow(radius: 2, y: 1)
                
                Spacer()
            }
            .padding(Theme.Spacing.lg)
        }
        .background(Theme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Theme.Colors.textPrimary)
                }
            }
        }
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TermsOfUseView()
        }
    }
}

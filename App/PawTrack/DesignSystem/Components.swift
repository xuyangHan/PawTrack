import SwiftUI

struct CardView<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(AppSpacing.cardPadding)
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.cornerRadius, style: .continuous))
            .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
    }
}

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBody.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
        .background(AppTheme.primary)
        .foregroundStyle(.white)
        .clipShape(Capsule())
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBody)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
        .overlay(
            Capsule().stroke(AppTheme.divider, lineWidth: 1)
        )
    }
}

struct TagChip: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.appCaption)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? AppTheme.secondary.opacity(0.18) : AppTheme.divider.opacity(0.2))
            .clipShape(Capsule())
    }
}

struct AppTextField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.appCaption)
                .foregroundStyle(AppTheme.textSecondary)
            TextField(title, text: $text)
                .textFieldStyle(.plain)
                .padding(12)
                .background(AppTheme.background)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(AppTheme.divider, lineWidth: 1)
                )
        }
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.appHeadline)
                .foregroundStyle(AppTheme.textPrimary)
            if let subtitle {
                Text(subtitle)
                    .font(.appBody)
                    .foregroundStyle(AppTheme.textSecondary)
            }
        }
    }
}

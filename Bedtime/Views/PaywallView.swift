//
//  PaywallView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedPlan: SubscriptionPlan? = .annual

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.1, blue: 0.25)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                            .padding(.top, 60)

                        Text("Unlock Magical Stories")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Text("Start your free trial today")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal, 40)

                    // Features
                    VStack(spacing: 20) {
                        FeatureRow(icon: "book.fill", title: "Enjoy access to all stories", color: .blue)
                        FeatureRow(icon: "lightbulb.fill", title: "Pick from valuable lessons", color: .yellow)
                        FeatureRow(icon: "wand.and.stars", title: "Create your own personalized story", color: .purple)
                    }
                    .padding(.horizontal, 40)

                    // Subscription plans
                    VStack(spacing: 16) {
                        // Annual plan
                        SubscriptionPlanCard(
                            plan: .annual,
                            isSelected: selectedPlan == .annual,
                            onSelect: { selectedPlan = .annual }
                        )

                        // Monthly plan
                        SubscriptionPlanCard(
                            plan: .monthly,
                            isSelected: selectedPlan == .monthly,
                            onSelect: { selectedPlan = .monthly }
                        )
                    }
                    .padding(.horizontal, 40)

                    // Subscribe button
                    Button(action: {
                        // In a real app, this would trigger the purchase flow
                        appState.hasSubscription = true
                        appState.navigateTo(.main)
                    }) {
                        VStack(spacing: 8) {
                            Text("Start Free Trial")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)

                            Text("Then \(selectedPlan?.priceText ?? "") after trial")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 66)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                        .shadow(color: .purple.opacity(0.5), radius: 15, y: 8)
                    }
                    .padding(.horizontal, 40)

                    // Terms and restore
                    VStack(spacing: 12) {
                        Button(action: {
                            // Restore purchases action
                        }) {
                            Text("Restore Purchases")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Text("By subscribing, you agree to our Terms of Service and Privacy Policy. Cancel anytime.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.2))
                .cornerRadius(10)

            Text(title)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

enum SubscriptionPlan {
    case monthly
    case annual

    var title: String {
        switch self {
        case .monthly: return "Monthly"
        case .annual: return "Annual"
        }
    }

    var price: String {
        switch self {
        case .monthly: return "$9.99"
        case .annual: return "$39.99"
        }
    }

    var priceText: String {
        switch self {
        case .monthly: return "$9.99/month"
        case .annual: return "$39.99/year"
        }
    }

    var period: String {
        switch self {
        case .monthly: return "per month"
        case .annual: return "per year"
        }
    }

    var savings: String? {
        switch self {
        case .monthly: return nil
        case .annual: return "Save 67%"
        }
    }

    var monthlyEquivalent: String? {
        switch self {
        case .monthly: return nil
        case .annual: return "$3.33/month"
        }
    }
}

struct SubscriptionPlanCard: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(plan.title)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        if let savings = plan.savings {
                            Text(savings)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                    }

                    HStack(spacing: 4) {
                        Text(plan.price)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        Text(plan.period)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                    }

                    if let equivalent = plan.monthlyEquivalent {
                        Text(equivalent)
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }

                Spacer()

                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 28, height: 28)

                    if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(20)
            .background(
                isSelected
                    ? LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .leading, endPoint: .trailing)
                    : LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.15), Color.white.opacity(0.15)]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
            )
        }
    }
}

#Preview {
    PaywallView()
        .environmentObject(AppState())
}

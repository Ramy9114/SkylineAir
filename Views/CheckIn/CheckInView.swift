//
//  CheckInView.swift
//  testProject
//
//  Created by Rami on 16/03/2026.
//

import SwiftUI

struct CheckInView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                heroCard
                progressSection
                travelerCard
                baggageCard
                boardingPassCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 30)
        }
        .background(backgroundGradient)
        .navigationTitle("Check In")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.95, green: 0.97, blue: 1.0),
                Color(red: 0.89, green: 0.94, blue: 0.99),
                Color.white
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Tokyo Flight Check-In")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            Text("Complete your travel details, confirm baggage, and collect your boarding pass before heading to the airport.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.34, green: 0.42, blue: 0.52))

            HStack(spacing: 16) {
                flightPoint(code: "SFO", label: "Depart", detail: "Tue, 8:45 AM")

                Spacer()

                Image(systemName: "airplane")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 0.12, green: 0.4, blue: 0.82))

                Spacer()

                flightPoint(code: "HND", label: "Arrive", detail: "Wed, 1:20 PM")
            }
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [Color.white, Color(red: 0.9, green: 0.95, blue: 1.0)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 18, x: 0, y: 10)
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Ready To Board")
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            HStack(spacing: 12) {
                progressStep(number: "1", title: "Traveler", isComplete: true)
                progressStep(number: "2", title: "Bags", isComplete: true)
                progressStep(number: "3", title: "Seat", isComplete: true)
                progressStep(number: "4", title: "Pass", isComplete: false)
            }
        }
    }

    private var travelerCard: some View {
        infoCard(title: "Traveler") {
            detailRow(label: "Passenger", value: "Rami Hassan")
            detailRow(label: "Confirmation", value: "SKY248")
            detailRow(label: "Cabin", value: "Business")
            detailRow(label: "Seat", value: "4A")
        }
    }

    private var baggageCard: some View {
        infoCard(title: "Baggage") {
            detailRow(label: "Carry-on", value: "1 item included")
            detailRow(label: "Checked bags", value: "2 bags confirmed")
            detailRow(label: "Priority tag", value: "Enabled")
        }
    }

    private var boardingPassCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mobile Boarding Pass")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Available 24 hours before departure.")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.78))
                }

                Spacer()

                Image(systemName: "qrcode")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(.white)
            }

            HStack {
                tag(title: "Gate", value: "A12")
                Spacer()
                tag(title: "Zone", value: "1")
                Spacer()
                tag(title: "Boarding", value: "8:05 AM")
            }

            Button {
            } label: {
                Text("Add To Wallet")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.white)
                    .foregroundStyle(Color(red: 0.08, green: 0.22, blue: 0.42))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(22)
        .background(
            LinearGradient(
                colors: [Color(red: 0.09, green: 0.26, blue: 0.49), Color(red: 0.18, green: 0.52, blue: 0.77)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private func infoCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            content()
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 16, x: 0, y: 8)
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.39, green: 0.46, blue: 0.58))

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))
        }
    }

    private func progressStep(number: String, title: String, isComplete: Bool) -> some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(isComplete ? Color(red: 0.1, green: 0.45, blue: 0.84) : Color.white)
                    .frame(width: 46, height: 46)

                if isComplete {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                } else {
                    Text(number)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.1, green: 0.45, blue: 0.84))
                }
            }

            Text(title)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.12, green: 0.2, blue: 0.32))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func flightPoint(code: String, label: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(code)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            Text(label)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.43, green: 0.5, blue: 0.6))

            Text(detail)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.12, green: 0.4, blue: 0.82))
        }
    }

    private func tag(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(0.72))
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationStack {
        CheckInView()
    }
}

//
//  TicketsView.swift
//  testProject
//
//  Created by Rami on 16/03/2026.
//

import SwiftUI

struct TicketsView: View {
    let onRouteSelected: (AppRoute) -> Void

    private let offers = TicketOffer.sampleOffers

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                heroCard
                searchPanel
                offersSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 30)
        }
        .background(backgroundGradient)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.05, green: 0.09, blue: 0.18),
                Color(red: 0.09, green: 0.17, blue: 0.31),
                Color(red: 0.13, green: 0.25, blue: 0.42)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Book Your Next Flight")
                .font(.system(size: 31, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text("Compare fares, pick a cabin, and lock in a route in a few taps.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.78))

            HStack(spacing: 14) {
                summaryChip(title: "Round Trip", value: "3 travelers")
                summaryChip(title: "Class", value: "Business")
            }
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [Color(red: 0.09, green: 0.24, blue: 0.47), Color(red: 0.18, green: 0.52, blue: 0.78)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private var searchPanel: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Search")
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            VStack(spacing: 14) {
                routeRow(origin: "San Francisco", destination: "Singapore")
                infoRow(label: "Departure", value: "Apr 24")
                infoRow(label: "Return", value: "May 02")
                infoRow(label: "Passengers", value: "3 adults")
            }

            Button {
                onRouteSelected(.tripDetails(routeName: "San Francisco to Singapore"))
            } label: {
                Text("Search Flights")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundStyle(.white)
                    .background(Color(red: 0.1, green: 0.39, blue: 0.73))
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 10)
    }

    private var offersSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Popular Deals")
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

                Spacer()

                Button {
                    onRouteSelected(.allTrips)
                } label: {
                    Text("See all")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.1, green: 0.39, blue: 0.73))
                }
                .buttonStyle(.plain)
            }

            ForEach(offers) { offer in
                Button {
                    onRouteSelected(.tripDetails(routeName: offer.route))
                } label: {
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(offer.gradient)
                            .frame(width: 80, height: 80)
                            .overlay {
                                Image(systemName: offer.icon)
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundStyle(.white)
                            }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(offer.route)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

                            Text(offer.schedule)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(Color(red: 0.39, green: 0.46, blue: 0.58))

                            Text(offer.price)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.1, green: 0.39, blue: 0.73))
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color(red: 0.44, green: 0.52, blue: 0.62))
                    }
                    .padding(16)
                    .background(.white.opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func summaryChip(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(0.72))
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.white.opacity(0.14))
        .clipShape(Capsule())
    }

    private func routeRow(origin: String, destination: String) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("From")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.41, green: 0.49, blue: 0.6))
                Text(origin)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))
            }

            Spacer()

            Image(systemName: "airplane")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color(red: 0.1, green: 0.39, blue: 0.73))

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("To")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.41, green: 0.49, blue: 0.6))
                Text(destination)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))
            }
        }
        .padding(18)
        .background(Color(red: 0.94, green: 0.97, blue: 1.0))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.41, green: 0.49, blue: 0.6))

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))
        }
        .padding(.horizontal, 4)
    }
}

private struct TicketOffer: Identifiable {
    let id = UUID()
    let route: String
    let schedule: String
    let price: String
    let icon: String
    let gradient: LinearGradient

    static let sampleOffers: [TicketOffer] = [
        TicketOffer(
            route: "San Francisco to London",
            schedule: "Night departure · 9h 50m",
            price: "From $710",
            icon: "building.columns.fill",
            gradient: LinearGradient(
                colors: [Color(red: 0.14, green: 0.47, blue: 0.83), Color(red: 0.08, green: 0.21, blue: 0.47)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        TicketOffer(
            route: "Los Angeles to Sydney",
            schedule: "Direct flight · 15h 05m",
            price: "From $980",
            icon: "sun.horizon.fill",
            gradient: LinearGradient(
                colors: [Color(red: 0.96, green: 0.58, blue: 0.31), Color(red: 0.77, green: 0.29, blue: 0.24)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        TicketOffer(
            route: "Chicago to Dubai",
            schedule: "1 stop · Premium saver",
            price: "From $890",
            icon: "sparkles",
            gradient: LinearGradient(
                colors: [Color(red: 0.22, green: 0.67, blue: 0.62), Color(red: 0.07, green: 0.33, blue: 0.34)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    ]
}

#Preview {
    NavigationStack {
        TicketsView(onRouteSelected: { _ in })
            .navigationTitle("Book Tickets")
    }
}

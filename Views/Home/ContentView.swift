//
//  ContentView.swift
//  testProject
//
//  Created by Rami on 16/03/2026.
//

import SwiftUI

struct ContentView: View {
    let onRouteSelected: (AppRoute) -> Void

    private let upcomingTrips = Trip.sampleTrips
    private let shortcuts = TravelShortcut.sampleShortcuts

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.16, blue: 0.33),
                    Color(red: 0.11, green: 0.33, blue: 0.51),
                    Color(red: 0.95, green: 0.97, blue: 0.99)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    bookingCard
                    shortcutsSection
                    tripsSection
                    statusCard
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 28)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Skyline Air")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.72))

                    Text("Where to next?")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                Spacer()

                Button {
                    onRouteSelected(.profile)
                } label: {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.18))
                            .frame(width: 48, height: 48)

                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
            }

            Text("Boarding passes, premium seats, and fast booking in one place.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.78))
        }
    }

    private var bookingCard: some View {
        Button {
            onRouteSelected(.upcomingFlight)
        } label: {
            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Upcoming Flight")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 0.19, green: 0.28, blue: 0.44))

                        Text("San Francisco to Tokyo")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))
                    }

                    Spacer()

                    Text("Gate A12")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.91, green: 0.95, blue: 1.0))
                        .clipShape(Capsule())
                }

                HStack(spacing: 18) {
                    flightEndpoint(code: "SFO", city: "San Francisco", time: "08:45")

                    VStack(spacing: 8) {
                        Image(systemName: "airplane")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color(red: 0.12, green: 0.32, blue: 0.58))

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.clear, Color(red: 0.12, green: 0.32, blue: 0.58), .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 2)
                    }
                    .frame(maxWidth: .infinity)

                    flightEndpoint(code: "HND", city: "Tokyo", time: "13:20")
                }

                HStack {
                    Label("Nonstop", systemImage: "clock")
                    Spacer()
                    Label("11h 35m", systemImage: "sparkles")
                    Spacer()
                    Label("Business", systemImage: "seat.passenger")
                }
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.24, green: 0.34, blue: 0.47))
            }
            .padding(22)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 12)
        }
        .buttonStyle(.plain)
    }

    private var shortcutsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Quick Actions")

            HStack(spacing: 14) {
                ForEach(shortcuts) { shortcut in
                    Button {
                        onRouteSelected(shortcut.route)
                    } label: {
                        VStack(alignment: .leading, spacing: 14) {
                            Image(systemName: shortcut.icon)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(shortcut.tint)

                            Text(shortcut.title)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.1, green: 0.16, blue: 0.26))

                            Text(shortcut.subtitle)
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(Color(red: 0.39, green: 0.46, blue: 0.58))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .background(.white.opacity(0.92))
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var tripsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                sectionTitle("Popular Routes")
                Spacer()

                Button {
                    onRouteSelected(.allTrips)
                } label: {
                    Text("View all")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.82))
                }
                .buttonStyle(.plain)
            }

            ForEach(upcomingTrips) { trip in
                Button {
                    onRouteSelected(.tripDetails(routeName: trip.route))
                } label: {
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(trip.gradient)
                            .frame(width: 76, height: 76)
                            .overlay(
                                Image(systemName: trip.icon)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            )

                        VStack(alignment: .leading, spacing: 6) {
                            Text(trip.route)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)

                            Text(trip.schedule)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white.opacity(0.76))

                            Text(trip.price)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.98, green: 0.84, blue: 0.46))
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white.opacity(0.65))
                    }
                    .padding(16)
                    .background(.white.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var statusCard: some View {
        Button {
            onRouteSelected(.loungeAccess)
        } label: {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Lounge Access")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.19, green: 0.28, blue: 0.44))

                    Text("Gold tier unlocked")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.1, green: 0.16, blue: 0.26))

                    Text("Use your points for upgrades, meals, and partner hotels.")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.39, green: 0.46, blue: 0.58))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color(red: 1.0, green: 0.96, blue: 0.82))
                        .frame(width: 66, height: 66)

                    Image(systemName: "crown.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color(red: 0.74, green: 0.54, blue: 0.13))
                }
            }
            .padding(20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
    }

    private func flightEndpoint(code: String, city: String, time: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(code)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.09, green: 0.15, blue: 0.26))

            Text(city)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.39, green: 0.46, blue: 0.58))

            Text(time)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.12, green: 0.32, blue: 0.58))
        }
    }

}

private struct Trip: Identifiable {
    let id = UUID()
    let route: String
    let schedule: String
    let price: String
    let icon: String
    let gradient: LinearGradient

    static let sampleTrips: [Trip] = [
        Trip(
            route: "New York to Paris",
            schedule: "Daily departures · 7:30 PM",
            price: "From $640",
            icon: "building.2.crop.circle",
            gradient: LinearGradient(
                colors: [Color(red: 0.15, green: 0.43, blue: 0.67), Color(red: 0.08, green: 0.18, blue: 0.37)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        Trip(
            route: "Los Angeles to Seoul",
            schedule: "Mon, Wed, Fri · 10:10 AM",
            price: "From $780",
            icon: "mountain.2.fill",
            gradient: LinearGradient(
                colors: [Color(red: 0.97, green: 0.57, blue: 0.34), Color(red: 0.79, green: 0.28, blue: 0.27)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ),
        Trip(
            route: "Miami to Rio",
            schedule: "Weekend specials · 9:40 AM",
            price: "From $520",
            icon: "sun.max.fill",
            gradient: LinearGradient(
                colors: [Color(red: 0.19, green: 0.62, blue: 0.56), Color(red: 0.06, green: 0.34, blue: 0.34)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    ]
}

private struct TravelShortcut: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let tint: Color
    let route: AppRoute

    static let sampleShortcuts: [TravelShortcut] = [
        TravelShortcut(
            title: "Check In",
            subtitle: "Add bags and boarding pass",
            icon: "checkmark.circle.fill",
            tint: Color(red: 0.11, green: 0.48, blue: 0.86),
            route: .checkIn
        ),
        TravelShortcut(
            title: "Hotels",
            subtitle: "Curated stays near your gate",
            icon: "bed.double.fill",
            tint: Color(red: 0.98, green: 0.56, blue: 0.2),
            route: .hotels
        ),
        TravelShortcut(
            title: "Rewards",
            subtitle: "12,480 miles available",
            icon: "star.fill",
            tint: Color(red: 0.12, green: 0.64, blue: 0.51),
            route: .rewards
        )
    ]
}

#Preview {
    ContentView(onRouteSelected: { _ in })
}

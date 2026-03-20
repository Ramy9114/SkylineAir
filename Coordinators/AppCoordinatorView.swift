//
//  AppCoordinatorView.swift
//  testProject
//
//  Created by Rami on 16/03/2026.
//

import SwiftUI

enum AppRoute: Hashable {
    case home
    case ticketBooking
    case checkIn
    case hotels
    case rewards
    case allTrips
    case tripDetails(routeName: String)
    case wallet
    case profile
    case loungeAccess
    case upcomingFlight
}

private enum AppTab: Hashable {
    case home
    case tickets
}

struct AppCoordinatorView: View {
    @State private var selectedTab: AppTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var ticketsPath: [AppRoute] = []

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homePath) {
                ContentView(onRouteSelected: handleHomeRouteSelection)
                    .navigationBarHidden(true)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route, routeHandler: handleHomeRouteSelection)
                    }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(AppTab.home)

            NavigationStack(path: $ticketsPath) {
                TicketsView(onRouteSelected: handleTicketsRouteSelection)
                    .navigationTitle("Book Tickets")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route, routeHandler: handleTicketsRouteSelection)
                    }
            }
            .tabItem {
                Label("Tickets", systemImage: "ticket.fill")
            }
            .tag(AppTab.tickets)
        }
    }

    private func handleHomeRouteSelection(_ route: AppRoute) {
        guard route != .home else {
            homePath.removeAll()
            selectedTab = .home
            return
        }

        homePath.append(route)
    }

    private func handleTicketsRouteSelection(_ route: AppRoute) {
        switch route {
        case .home:
            ticketsPath.removeAll()
            selectedTab = .home
        case .ticketBooking:
            ticketsPath.removeAll()
            selectedTab = .tickets
        default:
            ticketsPath.append(route)
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute, routeHandler: @escaping (AppRoute) -> Void) -> some View {
        switch route {
        case .checkIn:
            CheckInView()
        case .tripDetails(let routeName):
            PlaceholderDetailView(
                title: routeName,
                subtitle: "Route details will live here once you implement that flow."
            )
        case .home:
            ContentView(onRouteSelected: routeHandler)
        case .ticketBooking:
            TicketsView(onRouteSelected: routeHandler)
        case .hotels:
            placeholderScreen(title: "Hotels", subtitle: "Hotel booking flow coming next.")
        case .rewards:
            placeholderScreen(title: "Rewards", subtitle: "Rewards details will be implemented here.")
        case .allTrips:
            placeholderScreen(title: "Trips", subtitle: "This will become the full trips browser.")
        case .wallet:
            placeholderScreen(title: "Wallet", subtitle: "Payment methods and credits can live here.")
        case .profile:
            placeholderScreen(title: "Profile", subtitle: "Traveler profile settings will go here.")
        case .loungeAccess:
            placeholderScreen(title: "Lounge Access", subtitle: "Membership and lounge perks screen placeholder.")
        case .upcomingFlight:
            placeholderScreen(title: "Upcoming Flight", subtitle: "Flight management details will live here.")
        }
    }

    private func placeholderScreen(title: String, subtitle: String) -> some View {
        PlaceholderDetailView(title: title, subtitle: subtitle)
    }
}

private struct PlaceholderDetailView: View {
    let title: String
    let subtitle: String

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.11, blue: 0.22),
                    Color(red: 0.08, green: 0.24, blue: 0.41),
                    Color(red: 0.84, green: 0.91, blue: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                Text(title)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.78))

                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.white.opacity(0.14))
                    .frame(height: 220)
                    .overlay {
                        VStack(spacing: 12) {
                            Image(systemName: "hammer.fill")
                                .font(.system(size: 34))
                            Text("Placeholder")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("The coordinator is ready for this destination.")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                        }
                        .foregroundStyle(.white)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(24)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AppCoordinatorView()
}

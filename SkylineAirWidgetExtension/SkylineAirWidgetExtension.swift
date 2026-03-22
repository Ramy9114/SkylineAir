//
//  SkylineAirWidgetExtension.swift
//  SkylineAirWidgetExtension
//
//  Created by Rami on 22/03/2026.
//

import WidgetKit
import SwiftUI

private typealias Font = AppConstants.FontSize
private typealias Spacing = AppConstants.Spacing
private typealias Pad = AppConstants.Padding
private typealias Opacity = AppConstants.Opacity
private typealias WColor = AppConstants.AppColor

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlightEntry {
        FlightEntry.sample
    }

    func getSnapshot(in context: Context, completion: @escaping (FlightEntry) -> Void) {
        completion(FlightEntry.sample)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<FlightEntry>) -> Void) {
        let entry = FlightEntry.sample
        let timeline = Timeline(entries: [entry], policy: .after(Calendar.current.date(byAdding: .hour, value: 1, to: Date())!))
        completion(timeline)
    }
}

struct FlightEntry: TimelineEntry {
    let date: Date
    let departureCode: String
    let arrivalCode: String
    let departureCity: String
    let arrivalCity: String
    let departureTime: String
    let arrivalTime: String
    let gate: String
    let flightClass: String
    let duration: String

    static let sample = FlightEntry(
        date: Date(),
        departureCode: "SFO",
        arrivalCode: "HND",
        departureCity: "San Francisco",
        arrivalCity: "Tokyo",
        departureTime: "08:45",
        arrivalTime: "13:20",
        gate: "A12",
        flightClass: "Business",
        duration: "11h 35m"
    )
}

struct SkylineAirWidgetExtensionEntryView: View {
    var entry: FlightEntry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
        default:
            mediumWidget
        }
    }

    private var smallWidget: some View {
        VStack(alignment: .leading, spacing: Spacing.medium) {
            HStack {
                Image(systemName: "airplane.departure")
                    .font(.system(size: Font.subheadline, weight: .bold))
                    .foregroundStyle(WColor.gradientEnd.opacity(Opacity.tertiary))
                Spacer()
                Text("Gate \(entry.gate)")
                    .font(.system(size: Font.caption, weight: .bold, design: .rounded))
                    .padding(.horizontal, Pad.badgeHorizontal)
                    .padding(.vertical, Pad.badgeVertical)
                    .background(WColor.gradientEnd.opacity(Opacity.subtle))
                    .clipShape(Capsule())
                    .foregroundStyle(WColor.gradientEnd)
            }

            Spacer()

            HStack(spacing: Spacing.xSmall) {
                Text(entry.departureCode)
                    .font(.system(size: Font.title2, weight: .bold, design: .rounded))
                    .foregroundStyle(WColor.gradientStart)

                Image(systemName: "arrow.right")
                    .font(.system(size: Font.subheadline, weight: .bold))
                    .foregroundStyle(WColor.gradientEnd.opacity(Opacity.muted))

                Text(entry.arrivalCode)
                    .font(.system(size: Font.title2, weight: .bold, design: .rounded))
                    .foregroundStyle(WColor.gradientStart)
            }

            Text("\(entry.departureTime) · \(entry.flightClass)")
                .font(.system(size: Font.footnote, weight: .semibold, design: .rounded))
                .foregroundStyle(WColor.gradientEnd.opacity(Opacity.tertiary))
        }
        .padding(Pad.content)
        .containerBackground(for: .widget) {
            Color.white
        }
    }

    private var mediumWidget: some View {
        HStack(spacing: Spacing.large) {
            VStack(alignment: .leading, spacing: Spacing.small) {
                HStack {
                    Image(systemName: "airplane.departure")
                        .font(.system(size: Font.subheadline, weight: .bold))
                        .foregroundStyle(WColor.gradientEnd.opacity(Opacity.tertiary))
                    Text("Upcoming Flight")
                        .font(.system(size: Font.subheadline, weight: .semibold, design: .rounded))
                        .foregroundStyle(WColor.gradientEnd.opacity(Opacity.tertiary))
                }

                HStack(spacing: Spacing.small) {
                    Text(entry.departureCode)
                        .font(.system(size: Font.title1, weight: .bold, design: .rounded))
                        .foregroundStyle(WColor.gradientStart)

                    Image(systemName: "arrow.right")
                        .font(.system(size: Font.callout, weight: .bold))
                        .foregroundStyle(WColor.gradientEnd.opacity(Opacity.muted))

                    Text(entry.arrivalCode)
                        .font(.system(size: Font.title1, weight: .bold, design: .rounded))
                        .foregroundStyle(WColor.gradientStart)
                }

                Text("\(entry.departureCity) to \(entry.arrivalCity)")
                    .font(.system(size: Font.subheadline, weight: .medium, design: .rounded))
                    .foregroundStyle(WColor.gradientEnd.opacity(Opacity.secondary))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: Spacing.medium) {
                Text("Gate \(entry.gate)")
                    .font(.system(size: Font.footnote, weight: .bold, design: .rounded))
                    .padding(.horizontal, Pad.badgeHorizontalMedium)
                    .padding(.vertical, Pad.badgeVerticalMedium)
                    .background(WColor.gradientEnd.opacity(Opacity.subtle))
                    .clipShape(Capsule())
                    .foregroundStyle(WColor.gradientEnd)

                VStack(alignment: .trailing, spacing: Spacing.xxSmall) {
                    Text(entry.departureTime)
                        .font(.system(size: Font.body, weight: .bold, design: .rounded))
                        .foregroundStyle(WColor.gradientStart)
                    Text(entry.duration)
                        .font(.system(size: Font.footnote, weight: .medium, design: .rounded))
                        .foregroundStyle(WColor.gradientEnd.opacity(Opacity.secondary))
                }

                Text(entry.flightClass)
                    .font(.system(size: Font.footnote, weight: .semibold, design: .rounded))
                    .foregroundStyle(WColor.gold)
            }
        }
        .padding(Pad.content)
        .containerBackground(for: .widget) {
            Color.white
        }
    }
}

struct SkylineAirWidgetExtension: Widget {
    let kind: String = "SkylineAirWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SkylineAirWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Upcoming Flight")
        .description("See your next flight at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    SkylineAirWidgetExtension()
} timeline: {
    FlightEntry.sample
}

#Preview(as: .systemMedium) {
    SkylineAirWidgetExtension()
} timeline: {
    FlightEntry.sample
}

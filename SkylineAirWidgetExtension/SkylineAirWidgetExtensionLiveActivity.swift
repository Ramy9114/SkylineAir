//
//  SkylineAirWidgetExtensionLiveActivity.swift
//  SkylineAirWidgetExtension
//
//  Created by Rami on 22/03/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SkylineAirWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SkylineAirWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SkylineAirWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SkylineAirWidgetExtensionAttributes {
    fileprivate static var preview: SkylineAirWidgetExtensionAttributes {
        SkylineAirWidgetExtensionAttributes(name: "World")
    }
}

extension SkylineAirWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: SkylineAirWidgetExtensionAttributes.ContentState {
        SkylineAirWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SkylineAirWidgetExtensionAttributes.ContentState {
         SkylineAirWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SkylineAirWidgetExtensionAttributes.preview) {
   SkylineAirWidgetExtensionLiveActivity()
} contentStates: {
    SkylineAirWidgetExtensionAttributes.ContentState.smiley
    SkylineAirWidgetExtensionAttributes.ContentState.starEyes
}

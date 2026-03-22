//
//  SkylineAirWidgetExtensionBundle.swift
//  SkylineAirWidgetExtension
//
//  Created by Rami on 22/03/2026.
//

import WidgetKit
import SwiftUI

@main
struct SkylineAirWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        SkylineAirWidgetExtension()
        SkylineAirWidgetExtensionControl()
        SkylineAirWidgetExtensionLiveActivity()
    }
}

//
//  AudioRecorderViewModel.swift
//  DeciMeter
//
//  Created by Raphaël Payet on 23/07/2023.
//

import Foundation
import SwiftUI
import AVFoundation

class AudioRecorderViewModel: ObservableObject {
    // Calculate opacity based on decibels (for background color)
    func getOpacity(for decibels: Double) -> Double {
        let maxOpacity: Double = 0.8
        let minDb: Double = -60.0
        let maxDb: Double = 0.0

        let normalizedValue = (decibels - minDb) / (maxDb - minDb)
        let opacity = max(0, min(normalizedValue, 1)) * maxOpacity
        return opacity
    }

    // Calculate amplitude based on decibels (for circle animation)
    func getAmplitude(for decibels: Double) -> Double {
        let maxAmplitude: Double = 50.0
        let minDb: Double = -120.0
        let maxDb: Double = 0.0

        let normalizedValue = (decibels - minDb) / (maxDb - minDb)
        return maxAmplitude * max(0, min(normalizedValue, 1))
    }
}

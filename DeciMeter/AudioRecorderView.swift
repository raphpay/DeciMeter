//
//  AudioRecorderView.swift
//  DeciMeter
//
//  Created by Raphaël Payet on 23/07/2023.
//

import SwiftUI

struct AudioRecorderView: View {
    @StateObject private var noiseRecorder = NoiseRecorder()

    var body: some View {
        ZStack {
            // Background color based on sound level
            Color(red: 0.5, green: 0.8, blue: 0.9)
                .opacity(getOpacity())
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("\(String(format: "%.1f", noiseRecorder.decibels)) dB")
                    .font(.system(size: 80, weight: .bold, design: .default))
                    .padding()

                // Circle moving with the sound wave animation
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .offset(x: 0, y: CGFloat(getAmplitude()))
                    .animation(.easeInOut(duration: 0.1))

                Spacer()

                Button(action: {
                    if noiseRecorder.isRecording {
                        noiseRecorder.stopRecording()
                    } else {
                        noiseRecorder.startRecording()
                    }
                }, label: {
                    Text(noiseRecorder.isRecording ? "Stop Recording" : "Start Recording")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
            }
        }
    }

    // Calculate opacity based on decibels (for background color)
    private func getOpacity() -> Double {
        let maxOpacity: Double = 0.8
        let minDb: Double = -60.0
        let maxDb: Double = 0.0

        let normalizedValue = (noiseRecorder.decibels - minDb) / (maxDb - minDb)
        let opacity = max(0, min(normalizedValue, 1)) * maxOpacity
        return opacity
    }

    // Calculate amplitude based on decibels (for circle animation)
    private func getAmplitude() -> Double {
        let maxAmplitude: Double = 50.0
        let minDb: Double = -120.0
        let maxDb: Double = 0.0

        let normalizedValue = (noiseRecorder.decibels - minDb) / (maxDb - minDb)
        return maxAmplitude * max(0, min(normalizedValue, 1))
    }
}

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}



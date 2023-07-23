//
//  AudioRecorderView.swift
//  DeciMeter
//
//  Created by Raphaël Payet on 23/07/2023.
//

import SwiftUI

struct AudioRecorderView: View {
    @StateObject private var viewModel = AudioRecorderViewModel()
    @StateObject private var noiseRecorder = NoiseRecorder()

    var body: some View {
        ZStack {
            // Background color based on sound level
            Color(red: 0.5, green: 0.8, blue: 0.9)
                .opacity(viewModel.getOpacity(for: noiseRecorder.decibels))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("\(String(format: "%.1f", noiseRecorder.decibels)) dB")
                    .font(.system(size: 80, weight: .bold, design: .default))
                    .padding()

                // Circle moving with the sound wave animation
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .offset(x: 0, y: CGFloat(viewModel.getAmplitude(for: noiseRecorder.decibels)))

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
}

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}



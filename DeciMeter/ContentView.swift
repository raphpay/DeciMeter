//
//  ContentView.swift
//  DeciMeter
//
//  Created by Raphaël Payet on 23/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var noiseRecorder = NoiseRecorder()
    
    var body: some View {
        VStack {
            Button {
                noiseRecorder.startRecording()
            } label: {
                Text("Start recording")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

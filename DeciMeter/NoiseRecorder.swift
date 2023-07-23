//
//  NoiseRecorder.swift
//  DeciMeter
//
//  Created by Raphaël Payet on 23/07/2023.
//

import Foundation
import AVFoundation

class NoiseRecorder: NSObject, ObservableObject {
    @Published var isRecording = false
    @Published var decibels: Double = 0.0
    private var audioEngine: AVAudioEngine!
    private var audioFormat: AVAudioFormat!
    private var bufferObserver: NSObjectProtocol!

    func startRecording() {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.record, mode: .measurement, options: .mixWithOthers)
            try session.setActive(true)

            audioEngine = AVAudioEngine()
            let inputNode = audioEngine.inputNode
            audioFormat = inputNode.outputFormat(forBus: 0)

            bufferObserver = NotificationCenter.default.addObserver(forName: .AVAudioEngineConfigurationChange, object: nil, queue: nil) { [weak self] _ in
                guard let audioEngine = self?.audioEngine else {
                    print("No Audio Engine")
                    return
                }
                audioEngine.disconnectNodeInput(inputNode)
                
                guard let mainMixerNode = self?.audioEngine.mainMixerNode else {
                    print("No main mixer node")
                    return
                }
                
                audioEngine.connect(inputNode, to: mainMixerNode, format: self?.audioFormat)
            }

            inputNode.installTap(onBus: 0, bufferSize: 1024, format: audioFormat) { (buffer, time) in
                DispatchQueue.main.async {
                    self.decibels = self.calculateDecibels(from: buffer)
                }
                print("Decibels: \(self.decibels)")
            }

            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true
        } catch {
            print("Error setting up recording: \(error.localizedDescription)")
            isRecording = false
        }
    }

    func stopRecording() {
        if let observer = bufferObserver {
            NotificationCenter.default.removeObserver(observer)
            bufferObserver = nil
        }
        audioEngine.stop()
        isRecording = false
    }

    private func calculateDecibels(from buffer: AVAudioPCMBuffer) -> Double {
        guard let channelData = buffer.floatChannelData?[0] else { return -120.0 }

        let frameLength = AVAudioFrameCount(buffer.frameLength)
        let stride = buffer.stride

        var rms: Float = 0.0
        for i in 0..<Int(frameLength) {
            let sample = channelData[i * stride]
            rms += sample * sample
        }

        rms /= Float(frameLength)
        let rootMeanSquare = sqrt(rms)
        let decibels = 20 * log10(rootMeanSquare)
        let absoluteDecibels = abs(decibels) // Calculate the absolute value

        return absoluteDecibels.isFinite ? Double(absoluteDecibels) : 0.0
    }

}


extension NoiseRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Handle recording finish if needed
    }
}

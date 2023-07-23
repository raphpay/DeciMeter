# DeciMeter App
## Description

The Sound Level Meter App is a simple iOS application that allows users to measure the surrounding sound level in decibels (dB). The app provides a real-time sound level measurement using the device's built-in microphone and displays the sound level as a positive number. The background color changes dynamically based on the sound level, and a circle animates with the sound wave to visualize the sound intensity.

## Features

- Real-time sound level measurement using the device's microphone.
- Display of the sound level as a positive number (in dB).
- Dynamic background color that changes based on the sound level.
- An animated circle that moves with the sound wave to visualize the sound intensity.
- Start and stop recording functionality to control sound level measurement.

## Requirements

- Xcode 14 or later
- iOS 16.0 or later
- An iOS device with a microphone (Simulator does not support microphone access)

## Getting Started

1. Clone the repository to your local machine.

2. Open the `DeciMeter.xcodeproj` file in Xcode.

3. Select your target device (e.g., iPhone or iPad) in the Xcode toolbar.

4. Build and run the app on your device by clicking the "Run" button in Xcode.

5. The app will prompt you to grant microphone permissions. Allow access to the microphone to enable sound level measurement.

6. On the app's main screen, you will see the current sound level displayed in decibels. The background color will change dynamically based on the sound level, and a small circle will animate with the sound wave.

7. Tap the "Start Recording" button to start measuring the sound level. The sound level will update in real-time as you make noise or change the ambient sound.

8. Tap the "Stop Recording" button to stop the sound level measurement.

## Note

- The app measures sound levels relative to the device's microphone sensitivity and does not provide calibrated absolute sound pressure level (SPL) measurements.

- The app calculates the decibel levels in real-time using the device's microphone input. Keep in mind that this is a simple sound level meter for general use and may not provide professional-grade accuracy or calibration.

- The app requires access to the device's microphone. Make sure to grant microphone permissions when prompted.

## Acknowledgments

This app is a sample project created for learning and demonstration purposes. It utilizes the AVFoundation framework for audio recording and processing. The dynamic background color and sound wave animation are implemented using SwiftUI.

## License

No license.

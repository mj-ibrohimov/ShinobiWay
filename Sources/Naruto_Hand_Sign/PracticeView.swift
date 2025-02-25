import SwiftUI
import AVFoundation

struct PracticeView: View {
    @StateObject private var handSignRecognizer = HandSignRecognizer()
    @State private var captureSession = AVCaptureSession()
    @State private var currentCameraPosition: AVCaptureDevice.Position = .front
    private let videoOutput = AVCaptureVideoDataOutput()
    
    var body: some View {
        ZStack {
            CameraView(session: captureSession)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: flipCamera) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
                Spacer()
                
                Text("Recognized Sign: \(handSignRecognizer.recognizedSign)")
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .onAppear {
            setupCamera()
        }
    }
    
    private func setupCamera() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        
        captureSession.inputs.forEach { input in
            captureSession.removeInput(input)
        }
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentCameraPosition) else {
            print("No camera available for position \(currentCameraPosition)")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            videoOutput.setSampleBufferDelegate(handSignRecognizer, queue: DispatchQueue(label: "videoQueue"))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            
            captureSession.commitConfiguration()
            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    private func flipCamera() {
        currentCameraPosition = (currentCameraPosition == .front) ? .back : .front
        
        captureSession.stopRunning()
        setupCamera()
    }
}


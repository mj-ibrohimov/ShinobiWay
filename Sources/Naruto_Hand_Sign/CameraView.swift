import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = VideoPreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let connection = view.videoPreviewLayer.connection,
           connection.isVideoOrientationSupported {
            connection.videoOrientation = videoOrientation(for: windowScene.interfaceOrientation)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let previewView = uiView as? VideoPreviewView,
              let connection = previewView.videoPreviewLayer.connection,
              connection.isVideoOrientationSupported else { return }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            connection.videoOrientation = videoOrientation(for: windowScene.interfaceOrientation)
        }
    }
    
    private func videoOrientation(for interfaceOrientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch interfaceOrientation {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        default:
            return .portrait
        }
    }
}

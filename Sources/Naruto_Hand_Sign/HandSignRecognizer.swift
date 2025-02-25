import Foundation
import AVFoundation
import Vision
import CoreML


extension HandSignDetection: @unchecked Sendable {}
extension MLMultiArray: @unchecked Sendable {}
extension HandSignRecognizer: @unchecked Sendable {}

class HandSignRecognizer: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, ObservableObject {
    @Published var recognizedSign: String = ""
    
    private let sequenceHandler = VNSequenceRequestHandler()
    private var model: HandSignDetection?

    override init() {
        super.init()
        do {
            let config = MLModelConfiguration()
            model = try HandSignDetection(configuration: config)
        } catch {
            print("Could not create model: \(error)")
        }
    }
    
    func processFrame(sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let handPoseRequest = VNDetectHumanHandPoseRequest { [weak self] request, error in
            guard let observations = request.results as? [VNHumanHandPoseObservation],
                  let handPose = observations.first else {
                return
            }

            var landmarksArray: [Float32] = []
            
            let jointNames: [VNHumanHandPoseObservation.JointName] = [
                .thumbTip, .thumbIP, .thumbMP, .thumbCMC,
                .indexTip, .indexDIP, .indexPIP, .indexMCP,
                .middleTip, .middleDIP, .middlePIP, .middleMCP,
                .ringTip, .ringDIP, .ringPIP, .ringMCP,
                .littleTip, .littleDIP, .littlePIP, .littleMCP,
                .wrist
            ]

            for joint in jointNames {
                if let point = try? handPose.recognizedPoint(joint) {
                    landmarksArray.append(Float32(point.location.x))  // X coordinate
                    landmarksArray.append(Float32(point.location.y))  // Y coordinate
                    landmarksArray.append(Float32(point.confidence))  // Confidence score
                }
            }

            if let mlArray = self?.convertToMLMultiArray(from: landmarksArray) {
                self?.classifyHandPose(with: mlArray)
            }
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([handPoseRequest])
    }
    
    func convertToMLMultiArray(from landmarks: [Float32]) -> MLMultiArray? {
        guard let mlArray = try? MLMultiArray(shape: [1, 3, 21] as [NSNumber], dataType: .float32) else {
            return nil
        }

        for (index, value) in landmarks.enumerated() {
            mlArray[index] = NSNumber(value: value)
        }
        
        return mlArray
    }

    func classifyHandPose(with input: MLMultiArray) {
        guard let model = model else { return }
        
        let localModel = model
        let localInput = input
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let prediction = try localModel.prediction(poses: localInput)
                DispatchQueue.main.async {
                    self?.recognizedSign = prediction.label
                    print("Prediction Probabilities: \(prediction.labelProbabilities)")
                }
            } catch {
                print("Error in classification: \(error)")
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        processFrame(sampleBuffer: sampleBuffer)
    }
}

//
//  MobileNetModel.swift
//  uppgift-4
//
//  Created by Hendrik on 2023-10-16.
//

import Vision
import Foundation
import UIKit

class MobileNetModel {
    
    func predictImage(image_name: String) -> String {
        let defaultConfig = MLModelConfiguration()

        // Create an instance of the image classifier's wrapper class.
        let imageClassifierWrapper = try? MobileNet(configuration: defaultConfig)
        
        // Model size rgb: 224, 224, 3
        // dog1, dog2, bob
        let theimage = UIImage(named: image_name)
        if theimage != nil {
            let theimageBuffer = buffer(from: theimage!)!
            do {
                let output = try imageClassifierWrapper!.prediction(image: theimageBuffer)
                return(output.classLabel + "\n"
                       + "Probablity: "
                       + String(format: "%.1f", 100 * output.classLabelProbs[output.classLabel]!)) + "%"
            } catch {
                print("Exception imageClassifierWrapper")
            }
        }
        return("Image not found: " + image_name)
    }
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
}

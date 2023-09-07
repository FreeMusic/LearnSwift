//
//  AnalysisImageModelVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/8/6.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit
import Vision
import VideoToolbox

@available(iOS 11.0, *)
class AnalysisImageModelVC: BaseViewController {

    var imageView:UIImageView!//图片素材
    var analyzeResultLabel:UILabel!//分析结果
    let model = MobileNet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //图片素材
        let image = UIImage.init(named: "CoreMLAI_AnimalCat")
        
        imageView = UIImageView.init(image: image)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(kNavBarHeight)
            make.height.equalTo(200)
        }
        //分析结果
        analyzeResultLabel = UILabel.init()
        analyzeResultLabel.textColor = red
        analyzeResultLabel.numberOfLines = 0
        self.view.addSubview(analyzeResultLabel)
        analyzeResultLabel.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-15)
            make.top.equalTo(imageView.snp_bottom).offset(15)
        }
        
        predictUsingCoreML(image: image!)
    }

    /*
     This uses the Core ML-generated MobileNet class directly.
     Downside of this method is that we need to convert the UIImage to a
     CVPixelBuffer object ourselves. Core ML does not resize the image for
     you, so it needs to be 224x224 because that's what the model expects.
     */
    func predictUsingCoreML(image: UIImage) {
      if let pixelBuffer = image.pixelBuffer(width: 224, height: 224),
         let prediction = try? model.prediction(data: pixelBuffer) {
        let top5 = top(5, prediction.prob)
        show(results: top5)

        // This is just to test that the CVPixelBuffer conversion works OK.
        // It should have resized the image to a square 224x224 pixels.
        var imoog: CGImage?
          VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &imoog)
        imageView.image = UIImage(cgImage: imoog!)
      }
    }

    /*
     This uses the Vision framework to drive Core ML.
     Note that this actually gives a slightly different prediction. This must
     be related to how the UIImage gets converted.
     */
    func predictUsingVision(image: UIImage) {
      guard let visionModel = try? VNCoreMLModel(for: model.model) else {
        fatalError("Someone did a baddie")
      }

      let request = VNCoreMLRequest(model: visionModel) { request, error in
        if let observations = request.results as? [VNClassificationObservation] {

          // The observations appear to be sorted by confidence already, so we
          // take the top 5 and map them to an array of (String, Double) tuples.
          let top5 = observations.prefix(through: 4)
                                 .map { ($0.identifier, Double($0.confidence)) }
          self.show(results: top5)
        }
      }

      request.imageCropAndScaleOption = .centerCrop

      let handler = VNImageRequestHandler(cgImage: image.cgImage!)
      try? handler.perform([request])
    }

    // MARK: - UI stuff

    typealias Prediction = (String, Double)

    func show(results: [Prediction]) {
      var s: [String] = []
      for (i, pred) in results.enumerated() {
        s.append(String(format: "%d: %@ (%3.2f%%)", i + 1, pred.0, pred.1 * 100))
      }
      analyzeResultLabel.text = s.joined(separator: "\n\n")
    }

    func top(_ k: Int, _ prob: [String: Double]) -> [Prediction] {
      precondition(k <= prob.count)

      return Array(prob.map { x in (x.key, x.value) }
                       .sorted(by: { a, b -> Bool in a.1 > b.1 })
                       .prefix(through: k - 1))
    }
}

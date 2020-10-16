//
//  GraphicDiscernModelVC.swift
//  LearnSwift
//
//  Created by 乐逍遥 on 2020/10/15.
//  Copyright © 2020 橘子. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class GraphicDiscernModelVC: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imageView:UIImageView!
    var discernResultLabel:UILabel!
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel.init(for: GraphicDiscern().model)
            let request = VNCoreMLRequest.init(model: model) { [weak self] request, error in
                //获取分析结果
                self?.processClassifications(for: request, error: error)
            }
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("模型加载失败：\(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButtonItem = UIBarButtonItem.init(title: "获取图像", style: UIBarButtonItemStyle.plain, target: self, action: #selector(getDiscernGraphic))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        imageView = UIImageView.init(frame: self.view.bounds)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(imageView)
        
        discernResultLabel = UILabel.init()
        discernResultLabel.numberOfLines = 0
        discernResultLabel.text = "图像识别结果"
        discernResultLabel.layer.cornerRadius = 4;
        discernResultLabel.textColor = red
        discernResultLabel.layer.masksToBounds = true
        discernResultLabel.backgroundColor = UIColor.yellow.withAlphaComponent(0.8)
        
        self.view.addSubview(discernResultLabel)
        discernResultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-KSafeBarHeight-20)
        }
    }
    
    
    /// 获取图像'
    @objc func getDiscernGraphic(){
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "拍照", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        
        let choosePhoto = UIAlertAction(title: "相册", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true, completion: nil)
    }
    
    func presentPhotoPicker(sourceType:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    /// UIImagePickerControllerDelegate 图片选择代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        self.updateClassifications(for: image)
    }
}


//*******识别图像的相关处理*******//
extension GraphicDiscernModelVC {
    
    
    /// 获取分析结果
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.discernResultLabel.text = "无法识别图像：\n\(error!.localizedDescription)"
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            if classifications.isEmpty {
                self.discernResultLabel.text = "没有识别到任何内容"
            }else{
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { (classification)  in
                    return String(format: "(%.2f)%@", classification.confidence, classification.identifier)
                }
                self.discernResultLabel.text = "识别图像结果：\n" + descriptions.joined(separator: "\n")
            }
        }
    }
    
    func updateClassifications(for image:UIImage) {
        self.discernResultLabel.text = "正在识别中"
        
        let orientation = CGImagePropertyOrientation.init(image.imageOrientation)
        guard let ciImage = CIImage.init(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler.init(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
}

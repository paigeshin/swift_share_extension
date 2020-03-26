//
//  ViewController.swift
//  share_functionality_example
//
//  Created by shin seunghyun on 2020/03/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var txtViewContent: UITextView!
    var sharedIdentifier = "group.com.superdemopaige"
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        fetchData()
        setupUI()
    }
    
    func setupUI(){
        txtViewContent.needsUpdateConstraints()
        contentHeight.constant = txtViewContent.contentSize.height
    }
    
    func fetchData(){
        if let prefs = UserDefaults(suiteName: sharedIdentifier) {
            if let imageData = prefs.object(forKey: "Image") as? NSData {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData as Data)
                }
            }
            if let nameText = prefs.object(forKey: "Name") {
                self.txtViewContent.text = nameText as? String
            }
        }
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func shareText(_ sender: UIButton) {
        
        //보내줄 텍스트
        let text: String = "This is some text I wanna share"
        
        //어레이로 보내줌
        let textToShare: [String] = [ text ]
        
        //ActivityViewController initialization
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        //현재의 view 위데 올려줌
        activityViewController.popoverPresentationController?.sourceView = view
        
        //share하지 않을 방법들을 명시
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareImage(_ sender: UIButton) {
        
        //보낼 이미지
        let image: UIImage? = UIImage(named: "paris")
        
        //어레이에 담아줌
        let imageToShare: [UIImage] = [image!]
        
        //ActivityViewController initialization
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        
        //현재의 view 위에다 올려줌
        activityViewController.popoverPresentationController?.sourceView = view
        
        //exclude 할 플랫폼 지정
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
    
}


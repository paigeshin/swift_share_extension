//
//  ShareViewController.swift
//  ShareAction
//
//  Created by shin seunghyun on 2020/03/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    var sharedIdentifier = "group.com.superdemopaige"
    var selectedImage: UIImage!
    var maxCharacterCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholder = "Write Content Here"
    }
    
    override func isContentValid() -> Bool {
        
        if let currentMessage = contentText {
            let currentMessageLength = currentMessage.count
            charactersRemaining = (maxCharacterCount - currentMessageLength) as NSNumber
    
            if Int(charactersRemaining) < 0 {
                showMessage(title: "Sorry", message: "Enter only 100 characters", VC: self)
                return false
            }
            
        }
        
        return true
    }

    override func didSelectPost() {
       
        dataAttachment()
    }
    
    func dataAttachment(){
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                attachment.loadItem(forTypeIdentifier: contentType, options: nil) { (data, error) in
                    if error == nil {
                        let url = data as! NSURL
                        if let imageData = NSData(contentsOf: url as URL){
                            self.saveDataToUserDefault(suiteName: self.sharedIdentifier, dataKey: "Image", dataValue: imageData)
                        }
                    } else {
                        self.showMessage(title: "Sorry", message: "Coud not load the image", VC: self)
                    }
                }
            }
            saveDataToUserDefault(suiteName: self.sharedIdentifier, dataKey: "Name", dataValue: contentText as AnyObject)
        }
        
    }
    

    //해석이 안됨..
    lazy var UserConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "What's on your mind?"
        return item!
    }()
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [UserConfigurationItem]
    }
    
    func saveDataToUserDefault(suiteName: String, dataKey: String, dataValue: AnyObject) {
        if let prefs = UserDefaults(suiteName: suiteName) {
            prefs.removeObject(forKey: dataKey)
            prefs.set(dataValue, forKey: dataKey)
        }
    }
    
    func showMessage(title: String, message: String!, VC: UIViewController){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        VC.present(alert, animated: true, completion: nil)
    }

}

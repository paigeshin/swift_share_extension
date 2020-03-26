//
//  ActionViewController.swift
//  MyActionSheet
//
//  Created by shin seunghyun on 2020/03/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    var convertedString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //받은 텍스트 가져옴
        let textItem = self.extensionContext?.inputItems[0] as! NSExtensionItem
        
        //attachments? 아마도 meta data 같은 것 같음
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        //Identifier을 제공하는 동시에 실제로 값을 가져와서 세팅하는 부분.
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil) { (result, error) in
                
                self.convertedString = result as? String
                
                if self.convertedString != nil {
                    self.convertedString = self.convertedString!.uppercased()
                    
                    DispatchQueue.main.async {
                        self.myTextView.text = self.convertedString!
                    }
                }
                
            }
        }
        
    }

    //This method essentially reverses the process of unpacking the input items.
    @IBAction func done(_ sender: UIBarButtonItem) {
        let returnProvider = NSItemProvider(item: convertedString as NSSecureCoding?, typeIdentifier: kUTTypeText as String)
        let returnItem = NSExtensionItem()
        returnItem.attachments = [returnProvider]
        extensionContext?.completeRequest(returningItems: [returnItem], completionHandler: nil)
    }
    
}

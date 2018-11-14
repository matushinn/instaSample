//
//  EditUserInfoViewController.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class EditUserInfoViewController: UIViewController,UITextFieldDelegate ,UITextViewDelegate{
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    
    @IBOutlet weak var introductionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate=self
        userNameTextField.delegate=self
        introductionTextView.delegate=self
        
        let userId = NCMBUser.current()?.userName
        userIdTextField.text=userId
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    @IBAction func closeEditViewController(_ sender: Any) {
        //1ぺージ前に戻す
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

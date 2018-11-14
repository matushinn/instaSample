//
//  SignInViewController.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate=self
        userIdTextField.delegate=self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func signIn(_ sender: Any) {
        if (userIdTextField.text?.characters.count)!  > 0 && (passwordTextField.text?.characters.count)!>0{
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil{
                    print(error)
                }else{
                    //登録成功]
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    //画面の切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    //ログインの保持
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            }
        }
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
    }
    

    

}

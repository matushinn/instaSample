//
//  UserPageViewController.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB

class UserPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMenu(_ sender: Any) {
        let alertController=UIAlertController(title: "メニュー", message: "メニューから選択してください。", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "SiginIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    //画面の切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            })
        }
        
        let deleteAction=UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil{
                    print(error)
                    
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "SiginIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    //画面の切り替え
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            })
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(signOutAction)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
}

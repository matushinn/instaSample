//
//  EditUserInfoViewController.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/14.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit


class EditUserInfoViewController: UIViewController,UITextFieldDelegate ,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    
    @IBOutlet weak var introductionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView丸くなる
        userImageView.layer.cornerRadius = userImageView.bounds.width/2.0
        userImageView.layer.masksToBounds = true
        

        userIdTextField.delegate=self
        userNameTextField.delegate=self
        introductionTextView.delegate=self
        
        let userId = NCMBUser.current()?.userName
        userIdTextField.text=userId
        
        //名前表示 UserPageViewのパクリ
        if let user = NCMBUser.current(){
            userNameTextField.text = user.object(forKey: "displayName") as? String
            introductionTextView.text = user.object(forKey: "introduction") as? String
            userIdTextField.text = user.userName
            
            
            //画像表示
            let file = NCMBFile.file(withName: user.objectId , data: nil) as! NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil{
                    print(error)
                }else{
                    if data != nil{
                        let image = UIImage(data: data!)
                        self.userImageView.image = image
                    }
                    
                }
            }
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    //画像選ばれた時
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as!  UIImage
        let realizedImage = selectedImage.scale(byFactor: 0.4)
        
        picker.dismiss(animated: true, completion: nil)
        
        //upload
        let data = realizedImage!.pngData()
        let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
        
    }
    
    @IBAction func selectImage(_ sender: Any) {
        
        let actionController = UIAlertController(title: "画像の選択", message: "選択して下さい", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate=self
                self.present(picker,animated: true,completion: nil)
            }else{
                print("この機種ではカメラが使用できません。")
            }
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker,animated: true,completion: nil)
            }else{
                print("この機種ではフォトライブラリが使えません。")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated:true,completion:nil)
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        //自分の画面に表示
        self.present(actionController,animated: true,completion: nil)
    }
    
    @IBAction func closeEditViewController(_ sender: Any) {
        //1ぺージ前に戻す
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveUserInfo(){
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIdTextField.text, forKey: "userName")
        user?.setObject(introductionTextView.text, forKey: "introduction")
        user?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    

}

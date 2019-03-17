//
//  mailDescViewController.swift
//  HelloWorld
//
//  Created by Apple on 2018/11/6.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class mailDescViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var mailForEdit: mail?
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var mailText: UITextField!
    
    @IBOutlet weak var avatar: UIImageView!

    
    @IBAction func tapPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
   
//    @IBAction func exitEntry (_ seque : UIStoryboardSegue){print("exit")}
//    @IBAction func goback(_ sender: Any) {
//        self.dismiss(animated: false,completion: nil)
//    }
    
//    @IBAction func back(_ sender: Any) {
//        self.dismiss(animated: false,completion: nil)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = mailForEdit?.name
        nameText.text = mailForEdit?.name
        mailText.text = mailForEdit?.mail
        avatar.image = mailForEdit?.avatar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[String:Any]){
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.avatar.image = selectedImage
        dismiss(animated: true, completion: nil)//dismiss the picker
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Save"{
            print("Save")
            if(self.avatar.image == nil){
                mailForEdit=mail(inputName:self.nameText.text!,inputMail:self.mailText.text!,inputAvatar:nil)
            }
            else{
                mailForEdit=mail(inputName:self.nameText.text!,inputMail:self.mailText.text!,inputAvatar:self.avatar.image!)}
                    }
        if(segue.identifier == "Cancel"){
            print("Cancel")
        }
    }
    

}

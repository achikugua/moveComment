//
//  movieDescViewController.swift
//  movieComment
//
//  Created by Apple on 2018/12/18.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class movieDescViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    
    var movieForEdit: movie?
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var author: UILabel!
    
    
    @IBOutlet weak var movieComment: UILabel!
    @IBOutlet weak var goodNum: UILabel!
    
    
    @IBOutlet weak var zan: UIButton!
    
    @IBAction func goodAction(_ sender: Any) {
        zan.setImage(#imageLiteral(resourceName: "zan.png"), for: UIControlState.normal)
        var num = movieForEdit?.goodNum
        num = num! + 1
        movieForEdit?.goodNum = num
        //goodNum.text = String(stringInterpolationSegment:num)
        goodNum.text = num?.description
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    
    
    @IBAction func savePicture(_ sender: Any) {
        let image = self.movieImage.image!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    
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
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bac1.jpeg")!)
//        let imgback=UIImage(named:"bac2.jpeg")
//        
//        let imgbackV=UIImageView(image: imgback)
//        
//        self.view.backgroundView=imgbackV
        //创建一个用于显示背景图片的imageView
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bac1.jpeg")
        backgroundImage.contentMode = .scaleAspectFill //等比缩放填充（图片可能有部分显示不全）
        
        //将背景图片imageView插入到当前视图中
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        navigationItem.title = movieForEdit?.movieName
        movieName.text = movieForEdit?.movieName
        author.text = movieForEdit?.author
        movieImage.image = movieForEdit?.movieImage
        movieComment.text = movieForEdit?.movieComment
        let num = movieForEdit?.goodNum
        
        goodNum.text = num?.description
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[String:Any]){
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.movieImage.image = selectedImage
        dismiss(animated: true, completion: nil)//dismiss the picker
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Save"{
            print("Save")
            if(self.movieImage.image == nil){
                movieForEdit=movie(inputmovieName:self.movieName.text!,inputauthor:self.author.text!,inputmovieImage:nil,inputmovieComment:self.movieComment.text!,inputgoodNum:Int(self.goodNum.text!))
            }
            else{
                movieForEdit=movie(inputmovieName:self.movieName.text!,inputauthor:self.author.text!,inputmovieImage:self.movieImage.image!,inputmovieComment:self.movieComment.text!,inputgoodNum:Int(self.goodNum.text!))}
        }
        if(segue.identifier == "Cancel"){
            print("Cancel")
        }
    }
    
    
}

//
//  myMovieDescViewController.swift
//  movieComment
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class myMovieDescViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    var movieForEdit: movie?
    
//    @IBAction func goodAction(_ sender: Any) {
//        var num = movieForEdit?.goodNum
//        num = num! + 1
//        goodNum.text = String(stringInterpolationSegment:num)
//    }
    
    @IBOutlet weak var movieName: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var goodNum: UILabel!
    
    var updatemovieList:[movie] = [movie]()
//    @IBOutlet weak var movieComment: UITextView!
    
    @IBAction func goodAction(_ sender: Any) {
        var num = movieForEdit?.goodNum
        if(movieForEdit?.goodNum == nil){
            num = 0
        }
        num = num! + 1
        movieForEdit?.goodNum = num
        //goodNum.text = String(stringInterpolationSegment:num)
        goodNum.text = num?.description
        
    }
    
    func initupdatemovieList(){
        //let image as! UIImage
        updatemovieList.append(movie(inputmovieName:"天空之城",inputauthor:"zs",inputmovieImage:#imageLiteral(resourceName: "q1.jpeg"),inputmovieComment:"精彩绝伦",inputgoodNum:Int(1)))
    }


    @IBAction func commitMovie(_ sender: Any) {
        
        if let defaultmovieList = loadupdatemovieFile(){
            updatemovieList = defaultmovieList
        }
        else{
            initupdatemovieList()
        }
        updatemovieList.append(movie(inputmovieName:self.movieName.text!,inputauthor:self.author.text!,inputmovieImage:self.movieImage.image!,inputmovieComment:self.movieComment.text!,inputgoodNum:Int(self.goodNum.text!)))
        saveupdatemovieFile()
        
    }

    
    func saveupdatemovieFile(){
        let success = NSKeyedArchiver.archiveRootObject(updatemovieList, toFile: movie.ArchiveURL.path)
//        print("updatemovieList")
//        print(updatemovieList)
        if !success{
            print("Failed...")
        }
        else{
            print("public success!")
        }
    }
    func loadupdatemovieFile()->[movie]?{
        return (NSKeyedUnarchiver.unarchiveObject(withFile:movie.ArchiveURL.path)as?[movie])
    }

    
    @IBOutlet weak var movieComment: UITextField!
    
    @IBAction func selectPhoto(_ sender: Any) {
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
        var num = movieForEdit?.goodNum

        if(movieForEdit?.goodNum == nil){
            num = 0
            movieForEdit?.goodNum = num
        }
        //        goodNum.text = String(stringInterpolationSegment:num)
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

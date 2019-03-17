//
//  myMovieTableViewController.swift
//  movieComment
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class myMovieTableViewController: UITableViewController {
    
    var movieList:[movie] = [movie]()
    
//    let image = UIImage(named: "q1")
//    UIImageWriteToSavedPhotosAlbum(image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
//    //Swift实现:
//    func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
//        
//        if error != nil {
//            SVProgressHUD.showErrorWithStatus("保存失败")
//            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
//        } else {
//            SVProgressHUD.showSuccessWithStatus("保存成功")
//            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
//        }
//    }
//
//    func initImages(){
//
//    }
    
    
    func initmovieList(){
        //let image as! UIImage
        movieList.append(movie(inputmovieName:"龙猫",inputauthor:"xv",inputmovieImage:#imageLiteral(resourceName: "q2.jpeg"),inputmovieComment:"很童真",inputgoodNum:Int(0)))
        

    }
    
    func savemovieFile(){
        let success = NSKeyedArchiver.archiveRootObject(movieList, toFile: movie.myArchiveURL.path)
        if !success{
            print("Failed...")
        }
    }
    func loadmovieFile()->[movie]?{
        return (NSKeyedUnarchiver.unarchiveObject(withFile:movie.myArchiveURL.path)as?[movie])
    }
    
    @IBAction func exitEntry (_ seque : UIStoryboardSegue){print("exit")}
    
    @IBAction func saveToList(_ segue: UIStoryboardSegue){
        if let saveVC = segue.source as?
            myMovieDescViewController{
            if let movieEditResult = saveVC.movieForEdit{
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    movieList[(selectedIndexPath as NSIndexPath).row] = movieEditResult
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else {
                    movieList.append(movieEditResult)
                    let newIndexPath = IndexPath(row: movieList.count-1, section: 0)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        savemovieFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgback=UIImage(named:"bac2.jpeg")
        
        let imgbackV=UIImageView(image: imgback)
        
        self.tableView.backgroundView=imgbackV
        //initmovieList()
        if let defaultmovieList = loadmovieFile(){
            movieList = defaultmovieList
        }else{
            initmovieList()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMovieDetail", for: indexPath) as! myMovieTableViewCell
        //change
        let imgback=UIImage(named:"bac1.jpeg")
        
        let imgbackV=UIImageView(image: imgback)
        
        cell.backgroundView=imgbackV
        // Configure the cell...
        //cell.textLabel?.text = String(indexPath.row)
        cell.movieName?.text = movieList[indexPath.row].movieName
        cell.author?.text = movieList[indexPath.row].author
        cell.movieImage?.image = movieList[indexPath.row].movieImage
        cell.goodNum?.text = movieList[indexPath.row].goodNum?.description
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            movieList.remove(at: indexPath.row)
            savemovieFile()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMyMovieDetail"{
            let descriptionVC = segue.destination as! myMovieDescViewController
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedmovie = movieList[(indexPath as NSIndexPath).row]
                descriptionVC.movieForEdit = selectedmovie
            }
        }
    }
}

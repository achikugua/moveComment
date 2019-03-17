//
//  mailListTableViewController.swift
//  HelloWorld
//
//  Created by Apple on 2018/11/6.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class mailListTableViewController: UITableViewController {

    var mailList:[mail] = [mail]()
    
    func initMailList(){
        mailList.append(mail(inputName:"zs",inputMail:"zs@scut.edu.cn",inputAvatar:nil))
        mailList.append(mail(inputName:"ls",inputMail:"ls@scut.cn",inputAvatar:nil))
        mailList.append(mail(inputName: "xv", inputMail: "xv@scut.cn",inputAvatar:nil))
    }
    
    func saveMailFile(){
        let success = NSKeyedArchiver.archiveRootObject(mailList, toFile: mail.ArchiveURL.path)
        if !success{
            print("Failed...")
        }
    }
    func loadMailFile()->[mail]?{
        return (NSKeyedUnarchiver.unarchiveObject(withFile:mail.ArchiveURL.path)as?[mail])
    }
    
    @IBAction func exitEntry (_ seque : UIStoryboardSegue){print("exit")}
    
    @IBAction func saveToList(_ segue: UIStoryboardSegue){
        if let saveVC = segue.source as?
            mailDescViewController{
            if let mailEditResult = saveVC.mailForEdit{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                mailList[(selectedIndexPath as NSIndexPath).row] = mailEditResult
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            else {
                mailList.append(mailEditResult)
                let newIndexPath = IndexPath(row: mailList.count-1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        saveMailFile()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //initMailList()
        if let defaultMailList = loadMailFile(){
            mailList = defaultMailList
        }else{
            initMailList()
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
        return mailList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetail", for: indexPath) as! MovieTableViewCell
        //change

        // Configure the cell...
        //cell.textLabel?.text = String(indexPath.row)
        cell.movieName?.text = mailList[indexPath.row].name
        cell.author?.text = mailList[indexPath.row].mail
        cell.movieImage?.image = mailList[indexPath.row].avatar

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
            mailList.remove(at: indexPath.row)
            saveMailFile()
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
        if segue.identifier == "showMovieDetail"{
        let descriptionVC = segue.destination as! mailDescViewController
        if let selectedCell = sender as? UITableViewCell{
            let indexPath = tableView.indexPath(for: selectedCell)!
            let selectedMail = mailList[(indexPath as NSIndexPath).row]
            descriptionVC.mailForEdit = selectedMail
        }
        }
    }
    

}

//
//  MovieListTableViewController.swift
//  movieComment
//
//  Created by Apple on 2018/12/18.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit
import CoreData

class MovieListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating{
    //所有组件
    var movieList:[movie] = [movie]()
    //搜索匹配的结果
    var movieresult:[movie] = [movie]()
    
//    @IBOutlet var tableView: UITableView!
//    @IBOutlet weak var searchbar: UISearchBar!
//    var searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0,y:0,width:350,height:20))
    
//    @IBOutlet weak var searchBar: UISearchBar!
    
    var result = [String]()
    var array = [String]()
    
    var searchController: UISearchController!
    
    func initmovieList(){
        //let image as! UIImage
    
        movieList.append(movie(inputmovieName:"Shutter Island",inputauthor:"as",inputmovieImage:#imageLiteral(resourceName: "jin.jpg"),inputmovieComment:"烧脑啊",inputgoodNum:Int(1)))
        movieList.append(movie(inputmovieName:"Sky City",inputauthor:"zs",inputmovieImage:#imageLiteral(resourceName: "q1.jpeg"),inputmovieComment:"精彩绝伦",inputgoodNum:Int(1)))
        
        movieList.append(movie(inputmovieName:"金鱼姬",inputauthor:"ai",inputmovieImage:#imageLiteral(resourceName: "q2.jpeg"),inputmovieComment:"很有童趣",inputgoodNum:Int(1)))
        movieList.append(movie(inputmovieName:"Totoro",inputauthor:"ss",inputmovieImage:#imageLiteral(resourceName: "q3"),inputmovieComment:"很快乐",inputgoodNum:Int(1)))
        movieList.append(movie(inputmovieName:"Hal's Castle",inputauthor:"as",inputmovieImage:#imageLiteral(resourceName: "q4.jpeg"),inputmovieComment:"很玄幻，魅力十足",inputgoodNum:Int(1)))

                    }
    
    func savemovieFile(){
        let success = NSKeyedArchiver.archiveRootObject(movieList, toFile: movie.ArchiveURL.path)
        if !success{
            print("Failed...")
        }
    }
    func loadmovieFile()->[movie]?{
        return (NSKeyedUnarchiver.unarchiveObject(withFile:movie.ArchiveURL.path)as?[movie])
    }
    
    @IBAction func exitEntry (_ seque : UIStoryboardSegue){print("exit")}
    
    @IBAction func saveToList(_ segue: UIStoryboardSegue){
        if let saveVC = segue.source as?
            movieDescViewController{
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
        
        for arr in movieList{
            array.append(arr.movieName!)
        }
        //searchBar.placeholder = "搜索"
//        let leftnavbarbutton = UIBarButtonItem(customView: searchBar)
//        self.navigationItem.leftBarButtonItem = leftnavbarbutton
        
        self.result = self.array
        //self.movieresult = self.movieList
        //初始化
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
//        print("movieList")
//        print(movieList)
//        print("movieresult")
//        print(movieresult)
//        self.searchBar.delegate = self as? UISearchBarDelegate
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        print("[ViewController searchBar] searchText: \(searchText)")
//        
//        // 没有搜索内容时显示全部内容
//        if searchText == "" {
//            self.result = self.array
//            self.movieresult = self.movieList
//        } else {
//            
//            // 匹配用户输入的前缀，不区分大小写
//            self.result = []
//            self.movieresult = []
//            
//            for arr in self.movieList {
//                
//                if (arr.movieName?.lowercased().hasPrefix(searchText.lowercased()))! {
//                    print("result:")
//                    print(arr.movieName!)
//                    self.result.append(arr.movieName!)
//                    self.movieresult.append(arr)
//                }
//            }
//        }
//        
//        // 刷新tableView 数据显示
//        tableView.reloadData()
//    }
//    
//    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        searchBar.resignFirstResponder()
//    }
//    
//    // 书签按钮触发事件
//    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        
//        print("搜索历史")
//    }
//    
//    // 取消按钮触发事件
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // 搜索内容置空
//        searchBar.text = ""
//        self.result = self.array
//        self.movieresult = movieList
//        tableView.reloadData()
//    }
//
//    func searchBarSearchButtonClicked() {
//        print("7 searchBarSearchButtonClicked")
//        
//        searchBar.endEditing(true)
//    }
    //添加筛选方法,filter是数组的一个方法，它遍历数组的每一项进行闭包中的操作，根据结果判断是否删除对应项，最后得到一个筛选的数组。localizedCaseInsensitiveContains方法用来判断name中是否包含searchText（忽略大小写）
    func filterContent(for searchText: String) {
        movieresult = movieList.filter({
            (mov) -> Bool in
            
            if let name = mov.movieName {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    //实现UISearchResultsUpdating协议：中的updateSearchResults(for:)方法，这个方法在搜索条被选则和输入搜索字时调用：
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
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
    //更新tableView(_:numberOfRowsInSection:)。UISearchController有一个isActive属性用来判断搜索控制器当前活跃状态。
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return movieresult.count
        } else {
            return movieList.count
        }
    }
    
    //更新tableView(_:cellForRowAt:)。根据UISearchController的状态判断是从restaurants中获取数据还是searchResults。
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String = "movieDetail"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! MovieTableViewCell
//        cell.accessoryType = .disclosureIndicator
        //change
        let imgback=UIImage(named:"bac1.jpeg")
        
        let imgbackV=UIImageView(image: imgback)
        
        cell.backgroundView=imgbackV
        
        let mov = (searchController.isActive) ? movieresult[indexPath.row] : movieList[indexPath.row]
        
        // Configure the cell...
        //cell.textLabel?.text = String(indexPath.row)
        cell.movieName?.text = mov.movieName
        cell.author?.text = mov.author
        cell.movieImage?.image = mov.movieImage
        cell.goodNum?.text = mov.goodNum?.description
        
        return cell
    }
    
    //实现一个新的方法，让table在搜索状态下不可以滑动编辑
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
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
//            movieresult.remove(at: indexPath.row)
//            savemovieFile()
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
            let descriptionVC = segue.destination as! movieDescViewController
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedmovie = searchController.isActive ? movieresult[indexPath.row] : movieList[indexPath.row]
                descriptionVC.movieForEdit = selectedmovie
            }
        }
    }
}

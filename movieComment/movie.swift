//
//  movie.swift
//  movieComment
//
//  Created by Apple on 2018/12/18.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit
import UIKit

class movie: NSObject,NSCoding{
    var movieName:String?
    var author:String?
    var movieImage:UIImage?
    var movieComment:String?
    var goodNum:Int?
    
    static let DocumentsDirectory = FileManager().urls(for:.documentDirectory,in:.userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("movieList")
    static let myArchiveURL = DocumentsDirectory.appendingPathComponent("mymovieList")

    
    init(inputmovieName:String?,inputauthor:String?,inputmovieImage:UIImage?,inputmovieComment:String?,inputgoodNum:Int?) {
        self.movieName=inputmovieName
        self.author=inputauthor
        self.movieImage=inputmovieImage
        self.movieComment=inputmovieComment
        self.goodNum=inputgoodNum
    }
    
    func encode(with aCoder:NSCoder){
        aCoder.encode(movieName,forKey:"movieNameKey")
        aCoder.encode(author,forKey:"authorKey")
        aCoder.encode(movieImage,forKey:"movieImageKey")
        aCoder.encode(movieComment,forKey:"movieCommentKey")
        aCoder.encode(goodNum,forKey:"goodNumKey")

    }
    required init?(coder aDecoder:NSCoder) {
        movieName = aDecoder.decodeObject(forKey:"movieNameKey")as?String
        author = aDecoder.decodeObject(forKey:"authorKey")as?String
        movieImage = aDecoder.decodeObject(forKey:"movieImageKey")as?UIImage
        movieComment = aDecoder.decodeObject(forKey:"movieCommentKey")as?String
        goodNum = aDecoder.decodeObject(forKey:"goodNumKey")as?Int
        
    }
}

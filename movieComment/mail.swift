//
//  mail.swift
//  HelloWorld
//
//  Created by Apple on 2018/11/6.
//  Copyright © 2018年 xvting. All rights reserved.
//

import Foundation
import UIKit

class mail:NSObject,NSCoding{
    var name:String?
    var mail:String?
    var avatar:UIImage?
    
    static let DocumentsDirectory = FileManager().urls(for:.documentDirectory,in:.userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("mailList")
    
    init(inputName:String?,inputMail:String?,inputAvatar:UIImage?) {
        self.name=inputName
        self.mail=inputMail
        self.avatar=inputAvatar
    }
    
    func encode(with aCoder:NSCoder){
        aCoder.encode(name,forKey:"nameKey")
        aCoder.encode(mail,forKey:"mailKey")
        aCoder.encode(avatar,forKey:"avatarKey")
    }
    required init?(coder aDecoder:NSCoder) {
        name = aDecoder.decodeObject(forKey:"nameKey")as?String
        mail = aDecoder.decodeObject(forKey:"mailKey")as?String
        avatar = aDecoder.decodeObject(forKey:"avatarKey")as?UIImage
    }
}

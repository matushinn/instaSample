//
//  User.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/15.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class User: NSObject {
    var objectId: String
    var userName: String
    var displayName: String?//optional型
    var introduction: String?//optional型
    
    init(objectId: String, userName: String) {
        self.objectId = objectId
        self.userName = userName
    }

}

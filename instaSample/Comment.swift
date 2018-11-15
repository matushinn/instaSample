//
//  Comment.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/15.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class Comment {
    var postId: String
    var user: User
    var text: String
    var createDate: Date
    
    init(postId: String, user: User, text: String, createDate: Date) {
        self.postId = postId
        self.user = user
        self.text = text
        self.createDate = createDate
    }
}

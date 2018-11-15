//
//  Post.swift
//  instaSample
//
//  Created by 大江祥太郎 on 2018/11/15.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit

class Post {
    var objectId: String
    var user: User
    var imageUrl: String
    var text: String
    var createDate: Date
    var isLiked: Bool?
    var comments: [Comment]?
    var likeCount: Int = 0
    //初期化
    init(objectId: String, user: User, imageUrl: String, text: String, createDate: Date) {
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl
        self.text = text
        self.createDate = createDate
    }

}

//
// Created by Takuto Sato on 15/08/29.
// Copyright (c) 2015 Fringe81 co, Ltd. All rights reserved.
//

import Foundation

struct Contents {
    private var num = 10971
    mutating func getNextURL() -> String {
        num++
        return "http://s3-ap-northeast-1.amazonaws.com/topicks/article_thumb/\(num)_original.jpg"
    }
}

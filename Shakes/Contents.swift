// Copyright (c) 2015 Takuto Sato All rights reserved.

import Foundation

struct Contents {
    private var num = 10971
    mutating func getNextURL() -> String {
        num++
        return "http://s3-ap-northeast-1.amazonaws.com/topicks/article_thumb/\(num)_original.jpg"
    }
}

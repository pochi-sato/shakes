//
// Created by Takuto Sato on 15/08/29.
// Copyright (c) 2015 Fringe81 co, Ltd. All rights reserved.
//

import UIKit

class ShakeCountLabel:UILabel {
    private let radius: CGFloat = 30.0
    init(count: Int) {
        super.init(frame: CGRectZero)
        self.frame = CGRectMake(0,0,radius * 2,radius * 2)
        self.backgroundColor = UIColor.hexStr("2E44B2", alpha: 1.0)
        self.contentMode = UIViewContentMode.Center
        self.text = count.description
        self.layer.masksToBounds = true // 枠を丸くする.
        self.layer.cornerRadius = radius // コーナーの半径.
        self.textColor = UIColor.hexStr("FFD75B", alpha: 1.0) // 文字の色を白にする.
        self.shadowColor = UIColor.grayColor() // 文字の影の色をグレーにする.
        self.textAlignment = NSTextAlignment.Center // Textを中央寄せにする.
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

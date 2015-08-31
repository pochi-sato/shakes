//
// Created by Takuto Sato on 15/08/29.
// Copyright (c) 2015 Fringe81 co, Ltd. All rights reserved.
//

import UIKit

class ShakeCountLabel:UILabel {
    private let radius: CGFloat = 30.0
    private let rightMargin: CGFloat = 10.0
    private let bottomMargin: CGFloat = 10.0
    init(count: Int) {
        super.init(frame: CGRectZero)
        self.frame = CGRectMake(Utils.sharedInstance.getVerticalWidth() - (radius * 2) - rightMargin, Utils.sharedInstance.getVerticalHeight() - (radius * 2) - bottomMargin, radius * 2, radius * 2)
        self.backgroundColor = UIColor.hexStr("2E44B2", alpha: 0.6)
//        self.contentMode = UIViewContentMode.Top
        self.text = count.description
//        self.font = UIFont(name: "MarkerFelt-Wide", size: 38)
//        self.font = UIFont(name: "Optima-ExtraBlack", size: 28)
        self.font = UIFont(name: "Superclarendon-BlackItalic", size: 24)
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

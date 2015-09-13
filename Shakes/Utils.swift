// Copyright (c) 2015 Takuto Sato All rights reserved.

import UIKit

class Utils {
    static let sharedInstance = Utils() // シングルトン化
    func getVerticalScreenRect() -> CGRect {
        let screenRect = UIScreen.mainScreen().bounds
        let isVertical = screenRect.size.width < screenRect.size.height
        let verticalWidth = isVertical ? screenRect.size.width : screenRect.size.height
        let verticalHeight = isVertical ? screenRect.size.height : screenRect.size.width
        return CGRectMake(0, 0, verticalWidth, verticalHeight)
    }
    func getVerticalWidth() -> CGFloat {
        return self.getVerticalScreenRect().size.width
    }
    func getVerticalHeight() -> CGFloat {
        return self.getVerticalScreenRect().size.height
    }
}

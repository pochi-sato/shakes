// Copyright (c) 2015 Takuto Sato All rights reserved.

import UIKit

extension UIView {

    enum AnimateType {
        case Spring, Reversal, Spin, Expansion, Move
    }

    func changedValue(animateType: AnimateType, parentView: UIView) {

        self.center = parentView.center

        // 各アニメーションの処理.
        switch (animateType) {

                /*
                バネのような動きをするアニメーション.
                */
        case AnimateType.Spring:
            // アニメーションの時間を2秒に設定.
            UIView.animateWithDuration(2.0,

                    // 遅延時間.
                    delay: 0.0,

                    // バネの弾性力. 小さいほど弾性力は大きくなる.
                    usingSpringWithDamping: 0.2,

                    // 初速度.
                    initialSpringVelocity: 1.5,

                    // 一定の速度.
                    options: UIViewAnimationOptions.CurveLinear,

                    animations: {
                        () -> Void in

                        self.layer.position = CGPointMake(parentView.frame.width - 50, 100)

                        // アニメーション完了時の処理
                    }) {
                (Bool) -> Void in
                self.center = parentView.center
            }

                /*
                X, Y方向にそれぞれ反転するアニメーション.
                */
        case AnimateType.Reversal:
            // アニメーションの時間を3秒に設定
            UIView.animateWithDuration(3.0,

                    // アニメーション中の処理
                    animations: {
                        () -> Void in

                        // X方向に反転用のアフィン行列作成
                        self.transform = CGAffineTransformScale(self.transform, -1.0, 1.0)

                        // 連続したアニメーション処理.
                    }) {
                (Bool) -> Void in
                UIView.animateWithDuration(3.0,

                        // アニメーション中の処理
                        animations: {
                            () -> Void in

                            // Y方向に反転用のアフィン行列作成
                            self.transform = CGAffineTransformScale(self.transform, 1.0, -1.0)

                            // アニメーション完了時の処理
                        }) {
                    (Bool) -> Void in
                }
            }

                /*
                回転アニメーション.
                */
        case AnimateType.Spin:
            // 初期化.
            self.transform = CGAffineTransformMakeRotation(0)

            // radianで回転角度を指定(90度).
            let angle: CGFloat = CGFloat(M_PI_2)

            // アニメーションの秒数を設定(3秒).
            UIView.animateWithDuration(3.0,

                    animations: {
                        () -> Void in

                        // 回転用のアフィン行列を生成.
                        self.transform = CGAffineTransformMakeRotation(angle)
                    },
                    completion: {
                        (Bool) -> Void in
                    })

                /*
                拡縮アニメーション.
                */
        case AnimateType.Expansion:
            self.transform = CGAffineTransformMakeScale(1, 1)

            // アニメーションの時間を3秒に設定.
            UIView.animateWithDuration(3.0,

                    animations: {
                        () -> Void in
                        // 縮小用アフィン行列を作成.
                        self.transform = CGAffineTransformMakeScale(1.5, 1.5)
                    }) // 連続したアニメーション処理.
            {
                (Bool) -> Void in
                UIView.animateWithDuration(3.0,
                        // アニメーション中の処理.
                        animations: {
                            () -> Void in
                            // 拡大用アフィン行列を作成.
                            self.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        }) // アニメーション完了時の処理.
                {
                    (Bool) -> Void in
                    // 大きさを元に戻す.
                    self.transform = CGAffineTransformMakeScale(1, 1)
                }
            }

                /*
                移動するアニメーション.
                */
        case AnimateType.Move:
            self.layer.position = CGPointMake(-30, -30)

            // アニメーション処理
            UIView.animateWithDuration(NSTimeInterval(CGFloat(3.0)),
                    animations: {
                        () -> Void in

                        // 移動先の座標を指定する.
                        self.center = CGPoint(x: parentView.frame.width / 2, y: parentView.frame.height / 2);

                    }, completion: {
                (Bool) -> Void in
            })

        default:
            println("error!")
        }
    }
}

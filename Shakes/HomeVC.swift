//
//  HomeVC.swift
//  Shakes
//
//  Created by Takuto Sato on 2015/08/23.
//  Copyright (c) 2015年 Fringe81 co, Ltd. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIWebViewDelegate, ShakeDelegate {

    private var firstReserveShakeVC: ShakeVC!
    private var secondReserveShakeVC: ShakeVC!
    private var thirdReserveShakeVC: ShakeVC!
    private var contents: Contents! = Contents()

    private var count: Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()


        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //make URL of google feed api
            var urlString = "http://localhost:3000/contents"
            var url = NSURL(string: urlString)

            //download by NSSession
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
                [unowned self]
                (data, response, error) -> Void in
                //convert json data to dictionary
                // force downcast
                var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                dict = dict as Dictionary

                println(dict)
                self.firstReserveShakeVC = self.renderShakeVC(dict)
            })
            task.resume()
        })

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //make URL of google feed api
            var urlString = "http://localhost:3000/contents"
            var url = NSURL(string: urlString)

            //download by NSSession
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
                [unowned self]
                (data, response, error) -> Void in
                //convert json data to dictionary
                // force downcast
                var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary

                println(dict)
                dict = dict as Dictionary
                self.secondReserveShakeVC = self.renderShakeVC(dict)
            })
            task.resume()
        })

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //make URL of google feed api
            var urlString = "http://localhost:3000/contents"
            var url = NSURL(string: urlString)

            //download by NSSession
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
//                var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{data, response, error in
                [unowned self]
                (data, response, error) -> Void in
                //convert json data to dictionary
                // force downcast
                var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary

                println(dict)
                dict = dict as Dictionary
                self.thirdReserveShakeVC = self.renderShakeVC(dict)
            })
            task.resume()
        })



//        firstReserveShakeVC = createShakeVC(contents.getNextURL())
//        secondReserveShakeVC = createShakeVC(contents.getNextURL())
//        thirdReserveShakeVC = createShakeVC(contents.getNextURL())
//        firstReserveShakeVC = createShakeVC("http://www.apple.com")
//        secondReserveShakeVC = createShakeVC("https://www.google.com")
//        thirdReserveShakeVC = createShakeVC("https://flipboard.com/")
    }

//    func createShakeVC(urlStr:String) -> ShakeVC {
//        let shakeVC = ShakeVC()
//
//        // delegate設定
//        shakeVC.delegate = self
//
//        // webView読み込み
//        shakeVC.loadShakeMainView(urlStr)
//
//        // アニメーションを設定する.
//        shakeVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
//
//        return shakeVC
//    }

    func renderShakeVC(json:NSDictionary) -> ShakeVC {
        let shakeVC = ShakeVC()

        // delegate設定
        shakeVC.delegate = self

        let type:String = json["type"] as! String
        let url:String = json["url"] as! String

        // View読み込み
        shakeVC.loadShakeMainView(type, urlStr:url)

        // アニメーションを設定する.
        shakeVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl

        return shakeVC
    }

    /*
    Pageがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        println("webViewDidFinishLoad")
    }

    /*
    Pageがloadされ始めた時、呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        println("webViewDidStartLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    シェイクジェスチャー検知
    */
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    /*
    シェイク開始
    */
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
//            println("shake start!!!")
            // 開始時の処理
            self.onShake(self)
        }
    }

    /*
    シェイク終了
    */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
            // 終了時の処理
//            println("shake end!!!")
        }
    }

    func onShake(presentVC:UIViewController) {
//        println("onshake")

        let countView = ShakeCountLabel(count: count)
        firstReserveShakeVC.view.addSubview(countView)

        // >>>>>ボヨンver
        self.view.addSubview(firstReserveShakeVC.view)
        self.changedValue(AnimateType.PoyoPoyo as AnimateType, parentView: self.view as UIView, targetView: self.firstReserveShakeVC.myImageView! as UIView)
        self.changedValue(AnimateType.PoyoPoyo as AnimateType, parentView: self.firstReserveShakeVC.view! as UIView, targetView: countView as UIView)

        // =====ぺろりんver
        // Viewの移動する.
//        presentVC.presentViewController(firstReserveShakeVC, animated: false, completion: {
//            println("おわったで")
//            self.changedValue(AnimateType.Spring as AnimateType, parentView: self.firstReserveShakeVC.view! as UIView, targetView: countView as UIView)
//        })
        firstReserveShakeVC = secondReserveShakeVC
        secondReserveShakeVC = thirdReserveShakeVC


        // TODO:共通化 ++++++++++++++++++++++++++++++++++++++++
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //make URL of google feed api
            var urlString = "http://localhost:3000/contents"
            var url = NSURL(string: urlString)

            //download by NSSession
            var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
                [unowned self]
                (data, response, error) -> Void in
                //convert json data to dictionary
                // force downcast
                var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                dict = dict as Dictionary

                println(dict)
                self.thirdReserveShakeVC = self.renderShakeVC(dict)
            })
            task.resume()
        })
        // ここまで ++++++++++++++++++++++++++++++++++++++++

        count!++

        println("count:\(count) ")
    }








    // TODO:UIViewのexに移す
    enum AnimateType {
        case PoyoPoyo, Spring, Reversal, Spin, Expansion, Move
    }

    func changedValue(animateType: AnimateType, parentView: UIView, targetView: UIView) {

        let initialFrame = targetView.frame
//        targetView.center = parentView.center

        // 各アニメーションの処理.
        switch (animateType) {

                /*
    ぽよぽよ
    */
        case AnimateType.PoyoPoyo:


//            targetView.layer.position = CGPointMake(-30, -30)

            // アニメーション処理
            UIView.animateWithDuration(NSTimeInterval(CGFloat(0.1)),
                    animations: {
                        () -> Void in

                        // 移動先の座標を指定する.
                        targetView.frame.origin.y = initialFrame.origin.y + 200

                    }, completion: {
                (Bool) -> Void in

                // アニメーションの時間を2秒に設定.
                UIView.animateWithDuration(0.6,

                        // 遅延時間.
                        delay: 0.0,

                        // バネの弾性力. 小さいほど弾性力は大きくなる.
                        usingSpringWithDamping: 0.35,

                        // 初速度.
                        initialSpringVelocity: 7.0,

                        // 一定の速度.
                        options: UIViewAnimationOptions.CurveLinear,

                        animations: {
                            () -> Void in

//                        targetView.layer.position = CGPointMake(parentView.frame.width-50, 100)
                            targetView.frame.origin.y = initialFrame.origin.y

                            // アニメーション完了時の処理
                        }) {
                    (Bool) -> Void in
//                targetView.frame = initialFrame
//                targetView.center = parentView.center
                }

            })

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

//                        targetView.layer.position = CGPointMake(parentView.frame.width-50, 100)
                        targetView.frame.origin.x = 100

                        // アニメーション完了時の処理
                    }) {
                (Bool) -> Void in
//                targetView.frame = initialFrame
//                targetView.center = parentView.center
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
                        targetView.transform = CGAffineTransformScale(targetView.transform, -1.0, 1.0)

                        // 連続したアニメーション処理.
                    }) {
                (Bool) -> Void in
                UIView.animateWithDuration(3.0,

                        // アニメーション中の処理
                        animations: {
                            () -> Void in

                            // Y方向に反転用のアフィン行列作成
                            targetView.transform = CGAffineTransformScale(targetView.transform, 1.0, -1.0)

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
            targetView.transform = CGAffineTransformMakeRotation(0)

            // radianで回転角度を指定(90度).
            let angle: CGFloat = CGFloat(M_PI_2)

            // アニメーションの秒数を設定(3秒).
            UIView.animateWithDuration(3.0,

                    animations: {
                        () -> Void in

                        // 回転用のアフィン行列を生成.
                        targetView.transform = CGAffineTransformMakeRotation(angle)
                    },
                    completion: {
                        (Bool) -> Void in
                    })

                /*
                拡縮アニメーション.
                */
        case AnimateType.Expansion:
            targetView.transform = CGAffineTransformMakeScale(1, 1)

            // アニメーションの時間を3秒に設定.
            UIView.animateWithDuration(3.0,

                    animations: {
                        () -> Void in
                        // 縮小用アフィン行列を作成.
                        targetView.transform = CGAffineTransformMakeScale(1.5, 1.5)
                    }) // 連続したアニメーション処理.
            {
                (Bool) -> Void in
                UIView.animateWithDuration(3.0,
                        // アニメーション中の処理.
                        animations: {
                            () -> Void in
                            // 拡大用アフィン行列を作成.
                            targetView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        }) // アニメーション完了時の処理.
                {
                    (Bool) -> Void in
                    // 大きさを元に戻す.
                    targetView.transform = CGAffineTransformMakeScale(1, 1)
                }
            }

                /*
                移動するアニメーション.
                */
        case AnimateType.Move:
            targetView.layer.position = CGPointMake(-30, -30)

            // アニメーション処理
            UIView.animateWithDuration(NSTimeInterval(CGFloat(3.0)),
                    animations: {
                        () -> Void in

                        // 移動先の座標を指定する.
                        targetView.center = CGPoint(x: parentView.frame.width / 2, y: parentView.frame.height / 2);

                    }, completion: {
                (Bool) -> Void in
            })

        default:
            println("error!")
        }
    }

}


// Copyright (c) 2015 Takuto Sato All rights reserved.

import UIKit

class HomeVC: UIViewController, UIWebViewDelegate, ShakeDelegate {

    private var firstReserveShakeVC: ShakeVC!
    private var secondReserveShakeVC: ShakeVC!
    private var thirdReserveShakeVC: ShakeVC!
//    private var contents: Contents! = Contents()

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
                var dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                dict = dict as Dictionary

                print(dict)
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
                var dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary

                print(dict)
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
                var dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary

                print(dict)
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
        print("webViewDidFinishLoad")
    }

    /*
    Pageがloadされ始めた時、呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        print("webViewDidStartLoad")
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
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event!.type == UIEventType.Motion && event!.subtype == UIEventSubtype.MotionShake {
//            print("shake start!!!")
            // 開始時の処理
            self.onShake(self)
        }
    }

    /*
    シェイク終了
    */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event!.type == UIEventType.Motion && event!.subtype == UIEventSubtype.MotionShake {
            // 終了時の処理
//            print("shake end!!!")
        }
    }

    func onShake(presentVC:UIViewController) {
//        print("onshake")

        let countView = ShakeCountLabel(count: count)
        firstReserveShakeVC.view.addSubview(countView)

        // >>>>>ボヨンver
        self.view.addSubview(firstReserveShakeVC.view)
        ViewAnimation.apply(ViewAnimation.AnimateType.PoyoPoyo as ViewAnimation.AnimateType, parentView: self.view as UIView, targetView: self.firstReserveShakeVC.myImageView! as UIView)
        ViewAnimation.apply(ViewAnimation.AnimateType.PoyoPoyo as ViewAnimation.AnimateType, parentView: self.firstReserveShakeVC.view! as UIView, targetView: countView as UIView)

        // =====ぺろりんver
        // Viewの移動する.
//        presentVC.presentViewController(firstReserveShakeVC, animated: false, completion: {
//            print("おわったで")
//            self.changedValue(AnimateType.Spring as AnimateType, parentView: self.firstReserveShakeVC.view! as UIView, targetView: countView as UIView)
//        })
        firstReserveShakeVC = secondReserveShakeVC
        secondReserveShakeVC = thirdReserveShakeVC


        // TODO:contentsFetcherに共通化 ++++++++++++++++++++++++++++++++++++++++
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
                var dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                dict = dict as Dictionary

                print(dict)
                self.thirdReserveShakeVC = self.renderShakeVC(dict)
            })
            task.resume()
        })
        // ここまで ++++++++++++++++++++++++++++++++++++++++

        count!++

        print("count:\(count) ")
    }
}


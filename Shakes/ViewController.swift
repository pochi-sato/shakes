//
//  ViewController.swift
//  Shakes
//
//  Created by Takuto Sato on 2015/08/23.
//  Copyright (c) 2015年 Fringe81 co, Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, ShakeDelegate {

    private var firstReserveShakeVC: ShakeViewController!
    private var secondReserveShakeVC: ShakeViewController!
    private var thirdReserveShakeVC: ShakeViewController!

    private var num: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("unko");

        num = 10972

        firstReserveShakeVC = createShakeVC("http://www.apple.com")
        secondReserveShakeVC = createShakeVC("https://www.google.com")
        thirdReserveShakeVC = createShakeVC("https://flipboard.com/")
    }

    func createShakeVC(urlStr:String) -> ShakeViewController {
        let shakeVC = ShakeViewController()

        // delegate設定
        shakeVC.delegate = self

        // webView読み込み
        shakeVC.createWebView(urlStr)

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
            println("shake start!!!")
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
            println("shake end!!!")
        }
    }

    func onShake(presentVC:UIViewController) {
        println("onshake")

        // Viewの移動する.
        presentVC.presentViewController(firstReserveShakeVC, animated: true, completion: nil)
        firstReserveShakeVC = secondReserveShakeVC
        secondReserveShakeVC = thirdReserveShakeVC
        thirdReserveShakeVC = createShakeVC("http://s3-ap-northeast-1.amazonaws.com/topicks/article_thumb/\(num)_original.jpg")
        num!++

        println("num:\(num) ")
    }

}


// Copyright (c) 2015 Takuto Sato All rights reserved.

import UIKit

class ShakeVC: UIViewController, UIWebViewDelegate {
    var delegate: ShakeDelegate!
    private var myWebView: UIWebView!
    private var myImage: UIImage!
    var myImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loadShakeMainView(type: String, urlStr: String) {


        // TODO: ここがうまくいかない。loadwebViewがうまくうごかない、、
        if type == "imgae" {
            self.loadImageView(urlStr)
        } else if type == "html" {
////            self.loadImageView(urlStr)
            self.loadWebView(urlStr)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    シェイク開始
    */
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
//            println("shake start in shakevc!!!")
            // 開始時の処理
            delegate.onShake(self);
        }
    }

    /*
    シェイク終了
    */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.type == UIEventType.Motion && event.subtype == UIEventSubtype.MotionShake {
//            println("shake end in shakevc!!!")
            // 終了時の処理
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.backgroundColor = UIColor.hexStr("F9F8FF", alpha: 0.9)
//        self.view.backgroundColor = UIColor.blackColor()
        self.myImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        self.myImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.myImageView.image = self.myImage
        self.view.addSubview(self.myImageView)
    }
}

// webViewで表示する場合 ++++++++++++++++++++++++++++++++++++++++

extension ShakeVC {

    func loadWebView(urlStr: String) {
        // WebViewを生成.
        dispatch_sync(dispatch_get_main_queue(), {
            self.myWebView = UIWebView()

        // Delegateを設定する.
        self.myWebView.delegate = self

        // WebViewのサイズを設定する.
        self.myWebView.frame = self.view.bounds

        // Viewに追加する.
        self.view.addSubview(self.myWebView)

        })
        // URLを設定する.
        let url: NSURL = NSURL(string: urlStr)!

        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: url)

        // リクエストを実行する.
        myWebView.loadRequest(request)

    }

    /*
    Pageがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
//        println("webViewDidFinishLoad")
    }

    /*
    Pageがloadされ始めた時、呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
//        println("webViewDidStartLoad")
    }

}

// imageViewで表示する場合 ++++++++++++++++++++++++++++++++++++++++

extension ShakeVC {

    func loadImageView(urlStr: String) {
        // 通信先のURLを生成.
        let myUrl: NSURL = NSURL(string: urlStr)!
        // セッションの生成.
        let mySession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        // 通信のタスクを生成.
        let myTask = mySession.dataTaskWithURL(myUrl, completionHandler: {
            (data, response, err) in
            self.myImage = UIImage(data: data)
        })
        // タスクの実行.
        myTask.resume()
    }
}


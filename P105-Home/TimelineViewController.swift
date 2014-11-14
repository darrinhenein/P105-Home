//
//  TimelineViewController.swift
//  P105-Home
//
//  Created by Darrin Henein on 2014-11-13.
//  Copyright (c) 2014 Darrin Henein. All rights reserved.
//

import UIKit
import WebKit

class TimelineViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

    @IBOutlet var containerView: UIView! = nil
    
    var webView: WKWebView?
    
    
    @IBAction func refreshWasPressed(sender: AnyObject) {
        self.webView!.evaluateJavaScript("refreshFeed()", completionHandler: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        var config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(self, name: "bridge")
        
        self.webView = WKWebView(frame: self.view.frame, configuration: config)
        self.webView?.navigationDelegate = self
        self.view = self.webView!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fullURL:NSURL! = NSURL(string: "https://people.mozilla.org/~dhenein/labs/mobile-feed")
        let req:NSURLRequest! = NSURLRequest(URL: fullURL)
        
        self.webView!.loadRequest(req)

    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        let sentData = message.body as NSDictionary
        let status : String! = sentData["status"] as String
        if status == "loaded" {
            
            var syncUser: Credentials!
            syncUser = Login().getKeychainUser(Login().getUsername())
            
            self.webView!.evaluateJavaScript("login('\(syncUser.username!)', '\(syncUser.password!)')", completionHandler: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

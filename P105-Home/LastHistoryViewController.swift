//
//  LastHistoryViewController.swift
//  P105-Home
//
//  Created by Darrin Henein on 2014-10-28.
//  Copyright (c) 2014 Darrin Henein. All rights reserved.
//

import UIKit
import Alamofire

struct HistoryListItem {
    var title:NSString?
    var uri:NSString?
    var date:NSDate?
    var imageURL:String?
}

class LastHistoryViewController: UIViewController {
    
    var history: [HistoryListItem]!
    var parserKey = "7416869342e10f63e6d2704433d0e7fc90c8266a"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        history = [HistoryListItem]()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        var dateFormat: NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "EEEE MMM d"
        let h:HistoryListItem = self.history[0]
        titleLabel.text = h.title
        urlLabel?.text = h.uri
        timeLabel.text = dateFormat.stringFromDate(h.date!)
        imageView.image = nil
        if let imageURL = h.imageURL? {
            if let url = NSURL(string: imageURL) {
                var imageData:NSData? = NSData(contentsOfURL:url)
                if let data = imageData? {
                    self.imageView.image = UIImage(data: data)
                }
            }

        }
        
    }
    
    func getHistory() {
        let syncHistory = "https://syncapi-dev.sateh.com/1.0/history/recent"
        
        var syncUser: Credentials!
        syncUser = Login().getKeychainUser(Login().getUsername())
        
        Alamofire.request(.GET, syncHistory, parameters: nil)
            .authenticate(user: syncUser.username!, password: syncUser.password!)
            .responseJSON { (res, req, data, error) in
                
                self.history = []
                let history = data as NSArray
                for item in history {
                    let visits = item.valueForKey("visits") as? NSArray
                    let seconds = visits![0].valueForKey("date") as Double
                    let interval = (seconds/1000000.0) as NSTimeInterval
                    var d = NSDate(timeIntervalSince1970: interval)
                    var h:HistoryListItem = HistoryListItem(
                        title: item.valueForKey("title") as? NSString,
                        uri: item.valueForKey("histUri") as? NSString,
                        date: d,
                        imageURL: nil
                    )
                    self.history.append(h)
                    
                }
                
                
                var urlString = self.history[0].uri
                let urlParts = urlString?.componentsSeparatedByString("?")
                let domain = urlParts![0] as? String
                let readabilityAPI = "https://readability.com/api/content/v1/parser?url=\(domain!)&token=\(self.parserKey)"
                Alamofire.request(.GET, readabilityAPI, parameters: nil)
                    .responseJSON { (res, req, data, error) in
                        if let imageURL = data?.valueForKey("lead_image_url") as? String {
                            self.history[0].imageURL = imageURL
                        }
                        self.reloadData()
                }
                
                self.reloadData()
                
        }
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

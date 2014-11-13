//
//  HomeViewController.swift
//  P105-Home
//
//  Created by Darrin Henein on 2014-10-24.
//  Copyright (c) 2014 Darrin Henein. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, canFetchData, RefreshableUIViewController {

    var tableController: HomeTableViewController?
    var lastController: LastHistoryViewController?
    
    @IBOutlet weak var latestContainer: UIView!
    
    func fetchData() {
        self.tableController?.getTabs()
        self.lastController?.getHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueName: NSString? = segue.identifier
        
        if segueName == "HomeTableSegue" {
            self.tableController = segue.destinationViewController as? HomeTableViewController
            self.tableController?.parent = self
        }
        
        if segueName == "HomeRecentSegue" {
            self.lastController = segue.destinationViewController as? LastHistoryViewController
        }
        
    }
    
    func refresh() {
        self.lastController?.getHistory()
    }

    override func viewDidAppear(animated: Bool) {
        if Login().isLoggedIn() == true {
            fetchData()
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

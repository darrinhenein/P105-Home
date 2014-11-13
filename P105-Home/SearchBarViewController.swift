//
//  SearchBarViewController.swift
//  P105-Home
//
//  Created by Darrin Henein on 2014-10-28.
//  Copyright (c) 2014 Darrin Henein. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.background = UIImage(named: "search-bar")?.resizableImageWithCapInsets(UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10))
        
        // Do any additional setup after loading the view.
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

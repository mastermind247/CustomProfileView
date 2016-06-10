//
//  APIViewController.swift
//  IBdesignDemo
//
//  Created by Parth on 10/06/16.
//  Copyright © 2016 Solution Analysts. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class APIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LODAED VIEW")
        
        Alamofire.request(.GET, "https://itunes.apple.com/us/rss/toptvepisodes/limit=200/json", parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
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

//
//  KolodaViewController.swift
//  IBdesignDemo
//
//  Created by Parth on 09/06/16.
//  Copyright © 2016 Solution Analysts. All rights reserved.
//

import UIKit
import Koloda

class KolodaViewController: UIViewController {

    @IBOutlet weak var IBviewKoloda: KolodaView!
    let images = [UIImage(named: "addressbook-find-friends.png"),UIImage(named: "digits-logo-icon-mid.png"),UIImage(named: "digits-logo-icon.png"),UIImage(named: "addressbook-find-friends.png"),UIImage(named: "digits-logo-icon-mid.png"),UIImage(named: "digits-logo-icon.png"),UIImage(named: "addressbook-find-friends.png"),UIImage(named: "digits-logo-icon-mid.png"),UIImage(named: "digits-logo-icon.png"),UIImage(named: "addressbook-find-friends.png"),UIImage(named: "digits-logo-icon-mid.png"),UIImage(named: "digits-logo-icon.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IBviewKoloda.dataSource = self
        IBviewKoloda.delegate = self
        
        
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

extension KolodaViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
//        dataSource.reset()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

extension KolodaViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(images.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: images[Int(index)])
    }
    
//    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
//        return NSBundle.mainBundle().loadNibNamed("OverlayView",
//                                                  owner: self, options: nil)[0] as? OverlayView
//    }
}
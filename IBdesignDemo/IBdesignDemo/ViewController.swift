//
//  ViewController.swift
//  IBdesignDemo
//
//  Created by Parth on 01/06/16.
//  Copyright © 2016 Solution Analysts. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomProfileViewDelegate {

	@IBOutlet var myDemoView: CustomProfileView!
	
	@IBOutlet var IBtblView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
	let imageView = CustomProfileView(true, nameInitials: "PA", fontSize: 30, imageUrl: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAMFAAAAJDJhMzIwZmNhLWI3MmYtNDBjOS05MmUzLTgyZWRjNjJmOWMzOQ.jpg")
	imageView.frame = CGRectMake(130, 180, 100, 100)
    imageView.delegate = self
	imageView.backgroundColor = UIColor.clearColor()
	self.view.addSubview(imageView)
	}
	
	override func viewDidAppear(animated: Bool) {
		myDemoView.setValueForProfile(true, nameInitials: "KK", fontSize: 50, imageUrl: "http://www.hindustantimes.com/rf/image_size_800x600/HT/p2/2016/01/30/Pictures/htmetro_921e4af0-c706-11e5-a1d8-82aab0d3e6eb.JPG")
        myDemoView.delegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1000
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = IBtblView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? CustomCell
		cell?.IBimageView.setValueForProfile(true, nameInitials: "KK", fontSize: 50, imageUrl: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAMFAAAAJDJhMzIwZmNhLWI3MmYtNDBjOS05MmUzLTgyZWRjNjJmOWMzOQ.jpg")
        cell?.IBimageView.delegate = self
		return cell!
	}
    
    func imageViewDidTapped(sender: UIImageView) {
        print("DELEGATE CALLED ==== \(sender)")
    }
}


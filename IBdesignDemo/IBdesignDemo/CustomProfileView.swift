//
//  CustomProfileView.swift
//  IBdesignDemo
//
//  Created by Parth on 01/06/16.
//  Copyright © 2016 Solution Analysts. All rights reserved.
//

import UIKit
import Kingfisher

protocol CustomProfileViewDelegate {
    func imageViewDidTapped(sender: UIImageView)
}

class CustomProfileView: UIView {
	
	required internal init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	var isAnimated: Bool = true
	var myNameInitials: String = "SA" {
		didSet {
			self.setNeedsDisplay()
		}
	}
    var delegate: CustomProfileViewDelegate?
	var myFontSize: CGFloat = 50
	var imageUrl: String?
	var imageView: UIImageView? {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	func setValueForProfile(animation: Bool, nameInitials: String, fontSize: CGFloat, imageUrl: String) {
		isAnimated = animation
		myNameInitials = nameInitials
		myFontSize = fontSize
		self.imageUrl = imageUrl
	}
	
	convenience init(_ roundView: Bool, nameInitials: String, fontSize: CGFloat, imageUrl: String) {
		self.init()
		setValueForProfile(roundView, nameInitials: nameInitials, fontSize: fontSize, imageUrl: imageUrl)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	override func drawRect(rect: CGRect) {
			drawOvalWithText(placeHolderText: "\(myNameInitials)", rect: rect, fontSize: myFontSize, shouldAnimated: isAnimated )
	}
	

    func drawOvalWithText(placeHolderText placeHolderText: String = "SA", rect: CGRect, fontSize: CGFloat = 50, shouldAnimated: Bool = true) {
		
		let context = UIGraphicsGetCurrentContext()

		//// Color Declarations
		let color = UIColor.randomNonNearWhiteColor()
		
		//// Oval Drawing
		let ovalRect = rect
		let ovalPath = UIBezierPath(ovalInRect: ovalRect)
		color.setFill()
		ovalPath.fill()
		let ovalStyle = NSMutableParagraphStyle()
		ovalStyle.alignment = .Center
		
		let ovalFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: fontSize)!, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: ovalStyle]
		
		let ovalTextHeight: CGFloat = NSString(string: placeHolderText).boundingRectWithSize(CGSize(width: ovalRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: ovalFontAttributes, context: nil).size.height
		CGContextSaveGState(context)
		CGContextClipToRect(context, ovalRect)
		NSString(string: placeHolderText).drawInRect(CGRect(x: ovalRect.minX, y: ovalRect.minY + (ovalRect.height - ovalTextHeight) / 2, width: ovalRect.width, height: ovalTextHeight), withAttributes: ovalFontAttributes)
		CGContextRestoreGState(context)
		
		if imageUrl != nil && imageUrl?.characters.count != 0 {
			imageView = UIImageView(frame: rect)
			imageView?.layer.cornerRadius = rect.width/2
			imageView?.layer.masksToBounds = true
			imageView?.contentMode = .ScaleAspectFill
            let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
            imageTapGesture.numberOfTapsRequired = 1
            imageTapGesture.numberOfTouchesRequired = 1
            imageView?.userInteractionEnabled = true
            imageView?.addGestureRecognizer(imageTapGesture)
			self.addSubview(imageView!)
			
			// For caching Image if you dont want to cache image then use donwloadImage Method. For caching used Kingfisher library.
            let cacheResult = ImageCache.defaultCache.isImageCachedForKey(imageUrl!)
            
            if cacheResult.cached {
                print("IMAGE IS CACHED")                
                imageView!.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil, optionsInfo: shouldAnimated ? ([.Transition(ImageTransition.Fade(1)), .ForceTransition]) : [], progressBlock: nil, completionHandler: nil)
            }   else {
                print("IMAGE IS TO BE DOWNLOADED")
                imageView!.kf_setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: nil, optionsInfo: shouldAnimated ? ([.Transition(ImageTransition.FlipFromTop(1)), .ForceTransition]) : [], progressBlock: nil, completionHandler: nil)
            }
//			downloadImage(NSURL(string: imageUrl!)!)
		}
	}
	
	func downloadImage(url: NSURL){
		print("Download Started")
		getDataFromUrl(url) { (data, response, error)  in
			dispatch_async(dispatch_get_main_queue()) { () -> Void in
				guard let data = data where error == nil else { return }
				print(response?.suggestedFilename ?? "")
				print("Download Finished")
				self.imageView?.image = UIImage(data: data)
			}
		}
	}
	
	func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
		NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
			completion(data: data, response: response, error: error)
			}.resume()
	}
    
    func imageViewTapped(sender: UIImageView) {
        print("ImageViewTapped")
        delegate?.imageViewDidTapped(sender)
    }
}

extension UIColor {
    static func randomNonNearWhiteColor() -> UIColor {
        //upper bounds is set to 215 to prevent color that is "near" white which result in no differences between initial and bg color
        let red = CGFloat(arc4random_uniform(215)) / 255
        let green = CGFloat(arc4random_uniform(215)) / 255
        let blue = CGFloat(arc4random_uniform(215)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

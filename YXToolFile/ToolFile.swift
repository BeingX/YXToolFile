
//
//  Toolclass.swift
//  XY微博
//
//  Created by paul-y on 16/1/3.
//  Copyright © 2016年 YX. All rights reserved.
//
//MARK:--此文件的方法只依赖系统框架，不依赖自定义的类--
//MARK:
import Foundation
import UIKit
//MARK:--返回RGB颜色--
//传入一张normalImage 和一张 HighlightedImage 背景图片返回一个button
func colorWithRGB(R:CGFloat,G:CGFloat,B:CGFloat)->UIColor{
    
    return   UIColor.init(red: R/CGFloat(255.0), green: G/CGFloat(255.0), blue: B/CGFloat(255.0), alpha: 1.0)
}

//MARK:--根据背景图片返回一个button--
//传入一张normalImage 和一张 HighlightedImage 背景图片返回一个button 
func buttonWith(normalImage image:String?,HighlightedImage: String?)->UIButton{
    let butonItem = UIButton()
    let normalImage = UIImage(named: image!)
    let highImage = UIImage(named: HighlightedImage!)
    
    butonItem.setBackgroundImage(normalImage?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
    butonItem.setBackgroundImage(highImage?.imageWithRenderingMode(.AlwaysOriginal), forState:.Highlighted)
    
    butonItem.width = normalImage!.size.width
    butonItem.height = normalImage!.size.height
    return butonItem
}
//MARK:--创建一个imageView在右边的自定义按钮，并且它的长度和宽度随内容而定--
//创建一个imageView在右边的自定义按钮，并且它的长度和宽度随内容而定
func buttonForTitleView(atitle myTitle : String?,normalImage : String?,selectedImage: String,backgroundImage: String?) ->UIButton?{
    let titleBtn = UIButton(type: .Custom)
    
    let normalImage = UIImage(named:normalImage! )
    let selectedImage = UIImage(named:selectedImage)
    let backgroundImage = UIImage(named:backgroundImage! )
    
    titleBtn.setTitleShadowColor(UIColor.clearColor(), forState: .Selected)
    
    
    titleBtn.setBackgroundImage(backgroundImage, forState: .Highlighted)
    
    titleBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
    titleBtn.setTitle(myTitle, forState: .Normal)
    
    titleBtn.setImage(normalImage!.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
    titleBtn.setImage(selectedImage!.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
    //        titleBtn.imageView?.contentMode = .Center
    let msize =  myTitle!.sizeWithFont(font: (titleBtn.titleLabel?.font)!, maxSize: CGSize.init(width:CGFloat(MAXFLOAT), height:  CGFloat(40)))
    titleBtn.width = msize.width + (normalImage?.size.width)! + 20
    titleBtn.height = msize.height + 10
    
    titleBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: (msize.width + (normalImage?.size.width)! + 8), bottom: 0, right: 0)
    titleBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (normalImage?.size.width)! + 5)
    
    return titleBtn
    
}


//MARK:--重写打印方法--
/**
只在DEBUG模式下打印
*/
    func debugLog(items: Any...){
        #if DEBUG
            if items.count == 1{
                print(items.first!)
            }else{
               print(items) 
            }
            
        #endif
    }

//MARK:--返回一个随机颜色--
 func colorByRandom() ->UIColor?{
    return UIColor(red: CGFloat((Double(arc4random()) % 256) / 255.0), green: CGFloat((Double(arc4random()) % 256) / 255.0), blue: CGFloat((Double(arc4random()) % 256) / 255.0), alpha: 1.0)
  
}
//MARK:--弹出警告信息--
func alertShow(messae:String?,vc:UIViewController){
    let alertVc = UIAlertController(title:nil, message: messae, preferredStyle: .Alert)
    
    vc.presentViewController(alertVc, animated: true) { () -> Void in
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(UInt64(0.7 ) * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            alertVc.dismissViewControllerAnimated(true, completion: nil)
        })
    }

}

    
    
    

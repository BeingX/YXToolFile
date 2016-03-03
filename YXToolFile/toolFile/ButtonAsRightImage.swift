//
//  ButtonAsRightImage.swift
//  XY微博
//
//  Created by paul-y on 16/1/9.
//  Copyright © 2016年 YX. All rights reserved.
//
/*
用法
titleViewButton = ButtonAsRightImage(type: .Custom)

titleViewButton!.setImages("navigationbar_arrow_down", selectedImage: "navigationbar_arrow_up", backgroundImage: "navigationbar_button_middle_background_pushed")
titleViewButton!.addTarget(self, action:"titleBtnClick:", forControlEvents: .TouchUpInside)
self.navigationItem.titleView = titleViewButton
*/
import Foundation
import UIKit
class ButtonAsRightImage: UIButton {
  private   var normalImage:UIImage?
  private  var msize:CGSize{
         get{
            let mysize:CGSize
            if self.title == nil{
                mysize = CGSize(width: 0, height: 0)
            }else{
                mysize   =  self.title!.sizeWithFont(font: (self.titleLabel?.font)!, maxSize: CGSize.init(width:CGFloat(MAXFLOAT), height:  CGFloat(40)))
            }
            return mysize
            
        }
    }
    var title:String?{

        didSet{

            self.setTitle(title!, forState: .Normal)
            self.layoutSubviews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleShadowColor(UIColor.clearColor(), forState: .Selected)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setImages(normalImage : String?,selectedImage: String,backgroundImage: String?) {
        self.normalImage = UIImage(named:normalImage! )
        let selectedImage = UIImage(named:selectedImage)
        let backgroundImage = UIImage(named:backgroundImage!)
        self.setBackgroundImage(backgroundImage, forState: .Highlighted)
        self.setImage(self.normalImage!.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        self.setImage(selectedImage!.imageWithRenderingMode(.AlwaysOriginal), forState: .Selected)
        
    }
    override func layoutSubviews() {
        if self.normalImage != nil{
            self.width = self.msize.width + (self.normalImage?.size.width)! + 20
            self.height = msize.height + 10
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (msize.width + (self.normalImage?.size.width)! + 8), bottom: 0, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (self.normalImage?.size.width)! + 5)
        }else{
            self.width = self.msize.width + 20
            self.height = msize.height + 10
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (msize.width  + 8), bottom: 0, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)

        }
        self.center.x = UIScreen.mainScreen().bounds.width * 0.5
        super.layoutSubviews()
      
       
    }
   
}
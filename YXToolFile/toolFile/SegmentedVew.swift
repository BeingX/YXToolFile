//
//  SegmentedVew.swift
//  XY微博
//
//  Created by paul-y on 16/1/8.
//  Copyright © 2016年 YX. All rights reserved.
//
/*
用法
let titleView = SegmentedVew()
titleView.delegate = self
titleView.gapX = 20
titleView.segmentedViewWith(["明星","热门"], theHeight: 44)
self.navigationItem.titleView = titleView

*/
import Foundation
import UIKit

@objc protocol SegmentedVewDelegate : NSObjectProtocol{
    func segmentedVewDidSelectIndex(segmentedVew:SegmentedVew,index : Int)
}
class SegmentedVew: UIView {
    override init(frame: CGRect) {
       super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var btnArray : NSMutableArray? = NSMutableArray()
    var bottomLine:UIView?
    weak var delegate :SegmentedVewDelegate?
    var theWidth:CGFloat = 0
  
    /// 设置按钮之间的间隙,默认是10
    var gapX :CGFloat = 10
    ///设置按钮和父控件顶部的距离,默认是15
    var gapY :CGFloat = 15
    ///设置按钮字体大小,默认是17
    var titleFont :CGFloat = 17
    ///设置按钮到父控件左右边的距离，也影响到底部红色指示线的宽度,默认是7
    var gap :CGFloat = 7
    ///设置按钮切换时，底部指示条的移动速度,默认是0.4
    var duration:NSTimeInterval = 0.4
    
    func segmentedViewWith(titles :[String],theHeight:CGFloat){

       //添加按钮
        for var i = 0;i < titles.count;++i{
            let btn = UIButton(type: .Custom)
            //设置按钮字体大小
            btn.titleLabel?.font = UIFont.systemFontOfSize(titleFont)
            //获得字符串的尺寸
             let msize =  titles[i].sizeWithFont(font: (btn.titleLabel?.font)!, maxSize: CGSize.init(width:CGFloat(MAXFLOAT), height:  theHeight))
            //根据字符串的尺寸设置按钮的尺寸
            btn.frame.size.width = msize.width
            btn.frame.size.height = msize.height
            if i == 0{
                btn.frame.origin.x = msize.width * CGFloat(i) + gap
            }else{
              btn.frame.origin.x =  btnArray![i - 1].frame.origin.x + msize.width + gapX
            }
            
            btn.frame.origin.y = gapY
            //按钮的父控件宽度加上按钮的宽度，父控件的宽度，根据按钮的宽度而变化
            theWidth += btn.frame.size.width
            //设置按钮的状态
            btn.setTitle(titles[i], forState: .Normal)
            btn.setTitleColor(colorWithRGB(100, G: 100, B: 100), forState: .Normal)
            btn.setTitleColor(colorWithRGB(0, G: 0, B: 0), forState: .Selected)
            
            btn.tag = i
            //按钮点击执行的方法
            btn.addTarget(self, action: "btnClicked:", forControlEvents: .TouchUpInside)
            btnArray?.addObject(btn)
            self.addSubview(btn)
            if i == 0{
                self.btnClicked(btn)
            }
        }
     
        
        //按钮加载完，再设置自己的总宽度
        self.frame.size.width = theWidth + CGFloat(titles.count - 1) * gapX + 2 * gap
        self.frame.size.height = theHeight
        //添加底部的红线
        bottomLine = UIView(frame: CGRect(x: 0, y: (theHeight - 1), width:self.frame.size.width / CGFloat(titles.count), height: 1))
        bottomLine!.backgroundColor = UIColor.orangeColor()
        self.addSubview(bottomLine!)
//        return self
    }
    
    @objc func btnClicked(sender:UIButton){
        sender.selected = true
        for ibtn in btnArray!{
            if ibtn.tag != sender.tag{
                (ibtn as! UIButton).selected = false
            }
        }
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomLine?.frame.origin.x = CGFloat(sender.tag) * (self.bottomLine?.frame.size.width)!
        }
        if ((delegate?.respondsToSelector("segmentedVewDidSelectIndex::")) != nil){
            self.delegate?.segmentedVewDidSelectIndex(self, index: sender.tag)
        }
        
    }
}
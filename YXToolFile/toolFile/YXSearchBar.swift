//
//  YXSearchBar.swift
//  XY微博
//
//  Created by paul-y on 16/1/6.
//  Copyright © 2016年 YX. All rights reserved.
//--创建一个搜索框API--

//MARK:
//MARK:--使用指导--
/*

let searchItem = YXSearchBar()// 创建
searchItem.placeholder = "大家都在搜："//设置placeholder，如果有的话
searchItem.leftImage = UIImage(named: "searchbar_second_textfield_search_icon")//设置搜索框左边的图片，如果有的话
//调用方法，传入合适的参数，返回合适的搜索框
self.navigationItem.titleView = searchItem.searchBarWith(width: (UIScreen.mainScreen().bounds.size.width - 20), height: 32, bgImageNormal: "search_navigationbar_textfield_background", bgImageHighlighted: nil)

*/
//MARK:
import Foundation
import UIKit
class YXSearchBar: UITextField {
    var leftImage : UIImage?
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.leftViewMode = .Always
        self.font = UIFont.systemFontOfSize(15)
 }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
   

 }
func searchBarWith(width awidth:CGFloat,height:CGFloat?,bgImageNormal:String?,bgImageHighlighted:String?)->UITextField{
    
        let bgImageNor = UIImage(named: bgImageNormal!)
//        let bgImageHigh = UIImage(named: bgImageHighlighted!)
        self.background = bgImageNor
        self.width = awidth
        self.height = height!
    if leftImage !== nil {
        let imageview = UIImageView(image: leftImage)
        imageview.width = height!
        imageview.height = height!
        imageview.x = 10
        imageview.contentMode = .Center
        self.leftView = imageview
       
        }
    return self
        
        
    }
    
}
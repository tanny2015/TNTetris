//
//  TNChildLLeftShapeView.h
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

 

@interface TNChildLLeftShapeView : TNMovingView

@property(nonatomic,strong)NSMutableArray *zeroPILeftLPixelViewArray;//最初

@property(nonatomic,strong)NSMutableArray *onePILeftLPixelViewArray;//顺时针翻转90度

@property(nonatomic,strong)NSMutableArray *twoPILeftLPixelViewArray;//顺时针翻转2*90度

@property(nonatomic,strong)NSMutableArray *threePILeftLPixelViewArray;//顺时针翻转3*90度



 @end

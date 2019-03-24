//
//  TNChildLRightShapeView.h
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNMovingView.h"

@interface TNChildLRightShapeView : TNMovingView

@property(nonatomic,strong)NSMutableArray *zeroPIRightLPixelViewArray;//最初

@property(nonatomic,strong)NSMutableArray *onePIRightLPixelViewArray;//顺时针翻转90度

@property(nonatomic,strong)NSMutableArray *twoPIRightLPixelViewArray;//顺时针翻转2*90度

@property(nonatomic,strong)NSMutableArray *threePIRightLPixelViewArray;//顺时针翻转3*90度


 @end

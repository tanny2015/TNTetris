//
//  TNChildTShapeView.h
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNMovingView.h"

@interface TNChildTShapeView : TNMovingView

@property(nonatomic,strong)NSMutableArray *zeroPITPixelViewArray;//最初

@property(nonatomic,strong)NSMutableArray *onePITPixelViewArray;//顺时针翻转90度

@property(nonatomic,strong)NSMutableArray *twoPITPixelViewArray;//顺时针翻转2*90度

@property(nonatomic,strong)NSMutableArray *threePITPixelViewArray;//顺时针翻转3*90度




 
@end

//
//  TNChildRectShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildRectShapeView.h"

@implementation TNChildRectShapeView


-(void)getRandomInitialViewArray
{
    [self getRectArrayWithXStepCount:0 AndYStepCount:0 ];
}

-(NSMutableArray *)getRectArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
    
    if (_rectPixelViewArray == nil)
    {
        self.hasXGridCount = 2;
        self.hasYGridCount = 2;
        //size
        [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
        
        
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
        
        
        [self getDoubleLocationXYWithXStepCount:XStepCount  AndYStepCount:YStepCount];
        
       
        //00
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
        
        //10
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
        
        //01
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
        
        //11
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
        
        
    }
    
         return _rectPixelViewArray;
}



@end

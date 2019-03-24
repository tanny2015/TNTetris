//
//  TNChildSLeftShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildSLeftShapeView.h"

@implementation TNChildSLeftShapeView

 -(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double *)XStepCount YStepCount:(double *)YStepCount
{
    switch (arrayType)
    {
        case zeroPILeftS:
        {
            [self getOnePILeftSArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.zeroPILeftSPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = onePILeftS;
            *XStepCount = 0;
            *YStepCount = 0;

            break;
        }
            
        case onePILeftS:
        {
            [self getZeroPILeftSArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.onePILeftSPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = zeroPILeftS;
            *XStepCount = 0;
            *YStepCount = 0;

            break;

        }
            
            
        default:
            break;
    }
    
}



-(void)getRandomInitialViewArray
{
    self.arrayType = [self getRandomNumber:zeroPILeftS to:onePILeftS];
    switch (self.arrayType)
    {
        case zeroPILeftS:
        {
            [self getZeroPILeftSArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case onePILeftS:
        {
            [self getOnePILeftSArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        default:
            break;
    }
    
}


-(void)createZeroPILeftSMovingView
{
    
    self.hasXGridCount = 2;
    self.hasYGridCount = 3;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //00
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //12
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:2];

}


-(NSMutableArray *)getZeroPILeftSArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
 {
    
    if (_zeroPILeftSPixelViewArray == nil)
    {
        
        
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildSLeftShapeView * testMovingView = [TNChildSLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createZeroPILeftSMovingView];
            
            
            
            
            if(![testMovingView canSwitch:testMovingView])
            {
                self.canSwitchShape = NO;
                return nil;
            }
            else
            {
                self.canSwitchShape = YES;
                
                ////////////这里结束改动了

            
            
            self.startGridIndexX =   self.currentGridIndexX;
            self.startGridIndexY =   self.currentGridIndexY - 1 ;
            
            self.currentGridIndexX = self.startGridIndexX;
            self.currentGridIndexY = self.startGridIndexY;
            [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];
            [self removeAllChildViewFromMovingView:self];
          }

        }
        
         else
        {
            self.hasYGridCount = 3;
 
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }
 
        [self createZeroPILeftSMovingView];
        _zeroPILeftSPixelViewArray = [NSMutableArray array];
 
    }
    
    return _zeroPILeftSPixelViewArray;
}


-(void)createOnePILeftSMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 3;
    self.hasYGridCount = 2;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    //20
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];


}

-(NSMutableArray *)getOnePILeftSArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch

{
    
    if (_onePILeftSPixelViewArray == nil)
    {
 
        
         if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildSLeftShapeView * testMovingView = [TNChildSLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createOnePILeftSMovingView];
            
            
            
            
            if(![testMovingView canSwitch:testMovingView])
            {
                self.canSwitchShape = NO;
                return nil;
            }
            else
            {
                self.canSwitchShape = YES;
                
                ////////////这里结束改动了

            
            
            
            self.startGridIndexX =   self.currentGridIndexX;
            self.startGridIndexY =   self.currentGridIndexY + 1 ;
            
            self.currentGridIndexX = self.startGridIndexX;
            self.currentGridIndexY = self.startGridIndexY;
            [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];
            [self removeAllChildViewFromMovingView:self];
           }

        }
        
         else
        {
            self.hasYGridCount = 2;
            //设置起始位置
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }

        [self createOnePILeftSMovingView];
        _onePILeftSPixelViewArray = [NSMutableArray array];
 
    }
    
    return _onePILeftSPixelViewArray;
}



@end

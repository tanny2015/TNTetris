//
//  TNChildSRightShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildSRightShapeView.h"

@implementation TNChildSRightShapeView


-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double *)XStepCount YStepCount:(double *)YStepCount
{
    switch (arrayType)
    {
        case zeroPIRightS:
        {
            [self getOnePIRightSArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if (!self.canSwitchShape)return;
            
            self.zeroPIRightSPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = onePIRightS;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
        case onePIRightS:
        {
            [self getZeroPIRightSArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if (!self.canSwitchShape)return;
            
            self.onePIRightSPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = zeroPIRightS;
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
    self.arrayType =  [self getRandomNumber:zeroPIRightS to:onePIRightS];
    switch (self.arrayType)
    {
        case zeroPIRightS:
        {
            [self getZeroPIRightSArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case onePIRightS:
        {
            [self getOnePIRightSArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        default:
            break;
    }
    
}

-(void)createZeroPIRightSMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 2;
    self.hasYGridCount = 3;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //02
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];
    
}


-(NSMutableArray *)getZeroPIRightSArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_zeroPIRightSPixelViewArray == nil)
    {
  
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildSRightShapeView * testMovingView = [TNChildSRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createZeroPIRightSMovingView];
            
            
            
            
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
            //设置起始位置
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
 
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }
 
        [self createZeroPIRightSMovingView];
        _zeroPIRightSPixelViewArray = [NSMutableArray array];
        
     }
    
    return _zeroPIRightSPixelViewArray;
}


-(void)createOnePIRightSMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 3;
    self.hasYGridCount = 2;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];

    //00
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //21
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:1];

}
-(NSMutableArray *)getOnePIRightSArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_onePIRightSPixelViewArray == nil)
    {
        
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildSRightShapeView * testMovingView = [TNChildSRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createOnePIRightSMovingView];
            
            
            
            
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
        

        [self createOnePIRightSMovingView];
        _onePIRightSPixelViewArray = [NSMutableArray array];
    
      }
    
    return _onePIRightSPixelViewArray;
}

@end

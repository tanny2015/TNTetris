//
//  TNChildLLeftShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildLLeftShapeView.h"

@implementation TNChildLLeftShapeView


 -(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double *)XStepCount YStepCount:(double *)YStepCount
{
    switch (arrayType)
    {
        case zeroPILeftL:
        {
            [self getOnePILeftLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount  isInSwitchingState:YES];
            if (!self.canSwitchShape)return;
            
            self.zeroPILeftLPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = onePILeftL;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
            
        }
            
        case onePILeftL:
        {
           [self getTwoPILeftLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount  isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.onePILeftLPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = twoPILeftL;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
            
            case twoPILeftL:
        {
            [self getThreePILeftLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount  isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.twoPILeftLPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = threePILeftL;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
            
            case threePILeftL:
        {
            [self getZeroPILeftLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount  isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.threePILeftLPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = zeroPILeftL;
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
    self.arrayType = [self getRandomNumber:zeroPILeftL to:threePILeftL];
    switch (self.arrayType)
    {
        case zeroPILeftL:
        {
            [self getZeroPILeftLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case onePILeftL:
        {
            [self getOnePILeftLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
        case twoPILeftL:
        {
            [self getTwoPILeftLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case threePILeftL:
        {
            [self getThreePILeftLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        default:
            break;
    }
    
}

-(void)createZeroPILeftLMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 2;
    self.hasYGridCount = 3;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    
            //10
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
            //11
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
            //02
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];
            //12
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:2];


}


-(NSMutableArray *)getZeroPILeftLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_zeroPILeftLPixelViewArray == nil)
    {
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLLeftShapeView * testMovingView = [TNChildLLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createZeroPILeftLMovingView];
            
            
            
            
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
            //设置起始位置
            self.hasYGridCount = 3;
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
 
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }

        [self createZeroPILeftLMovingView];
        _zeroPILeftLPixelViewArray = [NSMutableArray array];
        
 
    }
    
    return _zeroPILeftLPixelViewArray;
}


-(void)createOnePILeftLMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 3;
    self.hasYGridCount = 2;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    
    
             //00
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
            //01
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
            //11
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
            //21
            [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:1];

    
}

-(NSMutableArray *)getOnePILeftLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_onePILeftLPixelViewArray == nil)
    {
        
        if (isSwitch == YES)
        {
             [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLLeftShapeView * testMovingView = [TNChildLLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createOnePILeftLMovingView];
            
            
            
            
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
            //设置起始位置
            self.hasYGridCount = 2;
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }

        [self createOnePILeftLMovingView];
        _onePILeftLPixelViewArray = [NSMutableArray array];
 
    }
    
    return _onePILeftLPixelViewArray;
}

-(void)createTwoPILeftLMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 2;
    self.hasYGridCount = 3;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //00
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //02
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];

    
}


-(NSMutableArray *)getTwoPILeftLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
 {
    
    if (_twoPILeftLPixelViewArray == nil)
    {
        
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLLeftShapeView * testMovingView = [TNChildLLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createTwoPILeftLMovingView];
            
            
            
            
            if(![testMovingView canSwitch:testMovingView])
            {
                self.canSwitchShape = NO;
                return nil;
            }
            else
            {
                self.canSwitchShape = YES;
 
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

        [self createTwoPILeftLMovingView];
        _twoPILeftLPixelViewArray = [NSMutableArray array];
 
    }
    
    return _twoPILeftLPixelViewArray;
}

-(void)createThreePILeftLMovingView
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
    //20
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:0];
    //21
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:1];

}

-(NSMutableArray *)getThreePILeftLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_threePILeftLPixelViewArray == nil)
    {
  
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLLeftShapeView * testMovingView = [TNChildLLeftShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createThreePILeftLMovingView];
            
            
            
            
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
        
        [self createThreePILeftLMovingView];
        _threePILeftLPixelViewArray = [NSMutableArray array];

 
    }
    
    return _threePILeftLPixelViewArray;
}


@end

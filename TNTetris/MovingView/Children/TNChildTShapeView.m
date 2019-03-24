//
//  TNChildTShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildTShapeView.h"

@interface TNChildTShapeView()

@end

@implementation TNChildTShapeView




-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double *)XStepCount YStepCount:(double *)YStepCount
{
    
    switch (arrayType)
    {
        case zeroPIT:
        {
            [self getOnePITArrayWithXStepCount:*XStepCount  AndYStepCount:*YStepCount isInSwitchingState:YES];
             if(!self.canSwitchShape)return;
             
            self.zeroPITPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = onePIT;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
            
        case onePIT:
        {
            [self getTwoPITArrayWithXStepCount:*XStepCount  AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.onePITPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = twoPIT;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
            
        case twoPIT:
        {
            [self getThreePITArrayWithXStepCount:*XStepCount  AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.twoPITPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = threePIT;
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
        
        case threePIT:
        {
            [self getZeroPITArrayWithXStepCount:*XStepCount  AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;

            self.threePITPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = zeroPIT;
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
    self.arrayType = [self getRandomNumber:zeroPIT to:threePIT];
    switch (self.arrayType)
    {
        case zeroPIT:
        {
            [self getZeroPITArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case onePIT:
        {
            [self getOnePITArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
        case twoPIT:
        {
            [self getTwoPITArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case threePIT:
        {
            [self getThreePITArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        default:
            break;
    }
    
}



-(void)createZeroPITMovingView
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
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];

    
}


-(NSMutableArray *)getZeroPITArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_zeroPITPixelViewArray == nil)
    {
  
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildTShapeView * testMovingView = [TNChildTShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createZeroPITMovingView];
            
            
            
            
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

        [self createZeroPITMovingView];
        _zeroPITPixelViewArray = [NSMutableArray array];
 
    }
    
    return _zeroPITPixelViewArray;
}



-(void)createOnePITMovingView
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
    //12
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:2];

}


-(NSMutableArray *)getOnePITArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_onePITPixelViewArray == nil)
    {
        
        
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildTShapeView * testMovingView = [TNChildTShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createOnePITMovingView];
            
            
            
            
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
        
        [self createOnePITMovingView];
        _onePITPixelViewArray = [NSMutableArray array];
 
 
    }
    
    return _onePITPixelViewArray;
}


-(void)createTwoPITMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 3;
    self.hasYGridCount = 2;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //21
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:1];
}



-(NSMutableArray *)getTwoPITArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_twoPITPixelViewArray == nil)
    {
         if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildTShapeView * testMovingView = [TNChildTShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createTwoPITMovingView];
            
            
            
            
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
        
        [self createTwoPITMovingView];
        _twoPITPixelViewArray = [NSMutableArray array];
 
 
    }
    
    return _twoPITPixelViewArray;
}

-(void)createThreePITMovingView
{
    //设置起始位置
    
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
    //02
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];

}

-(NSMutableArray *)getThreePITArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_threePITPixelViewArray == nil)
    {
         if (isSwitch == YES)
        {
             [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildTShapeView * testMovingView = [TNChildTShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createThreePITMovingView];
            
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
        
        
        [self createThreePITMovingView];
        _threePITPixelViewArray = [NSMutableArray array];
        
     }
    
    return _threePITPixelViewArray;
}
@end

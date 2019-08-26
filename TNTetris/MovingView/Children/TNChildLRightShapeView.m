//
//  TNChildLRightShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildLRightShapeView.h"

@implementation TNChildLRightShapeView



//传入的是当前的arrayType
-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double *)XStepCount YStepCount:(double *)YStepCount
{
    switch (arrayType)
    {
        case zeroPIRightL:
        {
            [self getOnePIRightLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            
            self.zeroPIRightLPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = onePIRightL;
            *XStepCount = 0;
            *YStepCount = 0;
            
            
            break;
        }
        case onePIRightL:
        {
            [self getTwoPIRightLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            
            self.onePIRightLPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = twoPIRightL;
            *XStepCount = 0;
            *YStepCount = 0;

            
            
             break;
             
        }
        case twoPIRightL:
        {
            [self getThreePIRightLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape) return;
            
            self.twoPIRightLPixelViewArray = nil;
            [self removeFromSuperview];
            
            self.arrayType = threePIRightL;
            *XStepCount = 0;
            *YStepCount = 0;

            break;
        }
            
        case threePIRightL:
        {
            [self getZeroPIRightLArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape)return;
            self.threePIRightLPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = zeroPIRightL;
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
    self.arrayType = [self getRandomNumber:zeroPIRightL to:threePIRightL];
    switch (self.arrayType)
    {
        case zeroPIRightL:
        {
            [self getZeroPIRightLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
            
        case onePIRightL:
        {
            [self getOnePIRightLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
        case twoPIRightL:
        {
            [self getTwoPIRightLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }

        case threePIRightL:
        {
            [self getThreePIRightLArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }

        default:
            break;
    }
    
}




-(NSMutableArray *)getZeroPIRightLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch 
{
    
    if (_zeroPIRightLPixelViewArray == nil)
    {
          if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLRightShapeView * testMovingView = [TNChildLRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createZeroPIRightLMovingView];
            
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

        [self createZeroPIRightLMovingView];
        
        _zeroPIRightLPixelViewArray = [NSMutableArray array];
    }
    
    return _zeroPIRightLPixelViewArray;
}

//zero
-(void)createZeroPIRightLMovingView
{
    
    self.hasXGridCount = 2;
    self.hasYGridCount = 3;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
      //00
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
        //01
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
        //02
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];
        //12
        [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:2];
}


-(void)createOnePIRightLMovingView
{
    
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
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];

    
}

-(NSMutableArray *)getOnePIRightLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_onePIRightLPixelViewArray == nil)
    {
        
        if (isSwitch == YES)
        {
 
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLRightShapeView * testMovingView = [TNChildLRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createOnePIRightLMovingView];
            
            
            
            
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

 
        
        [self createOnePIRightLMovingView];
        _onePIRightLPixelViewArray = [NSMutableArray array];
    }
    
    return _onePIRightLPixelViewArray;
}


-(NSMutableArray *)getTwoPIRightLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_twoPIRightLPixelViewArray == nil)
    {
     
        
        if (isSwitch == YES)
        {
            
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLRightShapeView * testMovingView = [TNChildLRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY - 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createTwoPIRightLMovingView];
            
            
            
            
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

 
        
        [self  createTwoPIRightLMovingView];
        _twoPIRightLPixelViewArray = [NSMutableArray array];
    }
    
    return _twoPIRightLPixelViewArray;
}


-(void)createTwoPIRightLMovingView
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
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //12
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:2];

    
}


-(void)createThreePIRightLMovingView
{
    //设置起始位置
    
    self.hasXGridCount = 3;
    self.hasYGridCount = 2;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];

    
    //20
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:0];
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    //11
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:1];
    //21
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:1];

    
}


-(NSMutableArray *)getThreePIRightLArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_threePIRightLPixelViewArray == nil)
    {
  
        if (isSwitch == YES)
        {
             [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            /////////这里开始改动了
            
            TNChildLRightShapeView * testMovingView = [TNChildLRightShapeView new];
            
            testMovingView.startGridIndexX =   self.currentGridIndexX;
            testMovingView.startGridIndexY =   self.currentGridIndexY + 1 ;
            [testMovingView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testMovingView createThreePIRightLMovingView];
            
            
            
            
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
 
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
             [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

        }

        
        [self createThreePIRightLMovingView];
        _threePIRightLPixelViewArray = [NSMutableArray array];
 
 
    }
    
    return _threePIRightLPixelViewArray;
}



@end

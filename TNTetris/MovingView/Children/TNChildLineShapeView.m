//
//  TNChildLineShapeView.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNChildLineShapeView.h"

@interface TNChildLineShapeView()

//@property(nonatomic,strong)NSMutableArray *horizPixelViewArray;//水平条
//@property(nonatomic,strong)NSMutableArray *vertiPixelViewArray;//垂直条
//
@end

@implementation TNChildLineShapeView

-(void)getRandomInitialViewArray
{
    self.arrayType = [self getRandomNumber:lineHoriz to:lineVerti];
//    self.arrayType = lineHoriz;
    switch (self.arrayType)
    {
        case lineHoriz:
        {
            [self getHorizArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
          
        case lineVerti:
        {
            [self getVertiArrayWithXStepCount:0 AndYStepCount:0 isInSwitchingState:NO];
            break;
        }
        default:
            break;
    }
    
}



//预备改变形状 -- 传入的是当前的arrayType
-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double*)XStepCount YStepCount:(double*)YStepCount
{
    
    switch (arrayType)
    {
        case lineHoriz:
        {
 
            [self getVertiArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape) return;
            
 
            self.horizPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = lineVerti;
            
            *XStepCount = 0;
            *YStepCount = 0;
           break;
        }
           
        case lineVerti:
        {
            [self getHorizArrayWithXStepCount:*XStepCount AndYStepCount:*YStepCount isInSwitchingState:YES];
            if(!self.canSwitchShape) return;
 
            self.vertiPixelViewArray = nil;
            [self removeFromSuperview];
            
            
            self.arrayType = lineHoriz;
            
            *XStepCount = 0;
            *YStepCount = 0;
            break;
        }
            
        default:
            break;
    }
    
}

//产生和改变形状 -- 这边数组没有什么用处，可完善
-(NSMutableArray *)getHorizArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    
    if (_horizPixelViewArray == nil)
    {
        if (isSwitch == YES)
        {
            
            /////////这里开始改动了
            
            TNChildLineShapeView * testLineShapeView = [TNChildLineShapeView new];
            
            testLineShapeView.startGridIndexX =   self.currentGridIndexX;
            testLineShapeView.startGridIndexY =   self.currentGridIndexY + 3 ;
            [testLineShapeView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            [testLineShapeView createHorizLineMovingView];
            if(![testLineShapeView canSwitch:testLineShapeView])
            {
                self.canSwitchShape = NO;
                return nil;
            }
            else
            {
                self.canSwitchShape = YES;
            
            ////////////这里结束改动了

            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            self.startGridIndexX =   self.currentGridIndexX;
            self.startGridIndexY =   self.currentGridIndexY +3 ;
            self.currentGridIndexX = self.startGridIndexX;
            self.currentGridIndexY = self.startGridIndexY;
            [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];
            [self removeAllChildViewFromMovingView:self];
            
            }

        }
 
        else
        {
            
            self.hasXGridCount = 4;
            self.hasYGridCount = 1;
            
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
            
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
        }
        
 
        [self createHorizLineMovingView];
        _horizPixelViewArray = [NSMutableArray array];
    }
    
     return _horizPixelViewArray;
}


//或者是横转向纵向
-(NSMutableArray *)getVertiArrayWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount isInSwitchingState:(BOOL)isSwitch
{
    if (_vertiPixelViewArray == nil)
    {
         if (isSwitch == YES)
        {
            [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
           /////////这里开始改动了
            
            TNChildLineShapeView * testLineShapeView = [TNChildLineShapeView new];
            
            testLineShapeView.startGridIndexX =   self.currentGridIndexX;
            testLineShapeView.startGridIndexY =   self.currentGridIndexY - 3 ;
            [testLineShapeView getDoubleLocationXYWithXStepCount:0 AndYStepCount:0];
            
            [testLineShapeView createVertiLineMovingView];
 
            if(![testLineShapeView canSwitch:testLineShapeView])
            {
                self.canSwitchShape = NO;
                return nil;
            }
            else
            {
                self.canSwitchShape = YES;
             ////////////这里结束改动了
            
            
            self.startGridIndexX =   self.currentGridIndexX;
            self.startGridIndexY =   self.currentGridIndexY - 3 ;
            self.currentGridIndexX = self.startGridIndexX;
            self.currentGridIndexY = self.startGridIndexY;
            [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];
            [self removeAllChildViewFromMovingView:self];
            }
            
        }
 
         else
        {
            //设置起始位置
            self.hasXGridCount = 1;
            self.hasYGridCount = 4;

            
            int middleGridIndex = (gridCountHoriz + 1)/2 - 1;
            self.startGridIndexX =   middleGridIndex;
            self.startGridIndexY = - self.hasYGridCount;
 
            [self getDoubleLocationXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
            
            

            
        }

        
        [self createVertiLineMovingView];
        _vertiPixelViewArray = [NSMutableArray array];

     }
    return _vertiPixelViewArray;
}


-(void)createHorizLineMovingView
{
    
    //设置起始位置
    
    self.hasXGridCount = 4;
    self.hasYGridCount = 1;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];

    
    //00
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
    
    //10
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:1 AndYDeviGrid:0];
    
    //20
    
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:2 AndYDeviGrid:0];
    
    //30
    
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:3 AndYDeviGrid:0];
}


-(void)createVertiLineMovingView
{
    
    //设置起始位置
    self.hasXGridCount = 1;
    self.hasYGridCount = 4;
    //size
    [self getSizeWithXGridCount:self.hasXGridCount AndYGridCount:self.hasYGridCount];
    
    //00
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:0];
    
    //01
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:1];
    
    //02
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:2];
    
    //03
    [self addPixelViewToMovingViewWithDeviFromStartPixelView:0 AndYDeviGrid:3];

}

 
 @end

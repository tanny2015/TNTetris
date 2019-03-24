//
//  TNPixelView.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNPixelView.h"

@interface TNPixelView()

@end


@implementation TNPixelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//格子坐标
-(void)getCurrentGridIndexXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
    self. currentGridIndexX = self.startGridIndexX + XStepCount;
    self. currentGridIndexY = self.startGridIndexY + YStepCount;
    
}

//xy坐标
-(void)getCurrentNormalXYWithGridIndexX:(double)XGridIndex  AndYGridIndex:(double)YGridIndex
{
    self.x = XGridIndex * pixelViewW;
    self.y = YGridIndex * pixelViewH;
    
}


//把以上俩句整合
-(void)getDoubleLocationXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
    [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
    [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];
}


//#define pixelViewW 10
//#define pixelViewH 10

+ (TNPixelView *)createPixelViewWithPixX:(int)pixX PixY:(int)pixY andState:(BOOL)state
{
    TNPixelView * pixelView = [[TNPixelView alloc] init];
    pixelView.backgroundColor = [UIColor grayColor];
    pixelView.layer.cornerRadius = pixelViewW * 0.5;
 
    pixelView.bounds = CGRectMake(0, 0, pixelViewW, pixelViewH);
 
    pixelView.pixX = pixX; //第几列
    pixelView.pixY = pixY; //第几行
    
    pixelView.x = 0 + pixelViewW * pixX;
    pixelView.y = 0 + pixelViewH * pixY;
    
    pixelView.pixTag =  pixX + gridCountHoriz * pixY;
 
    if(state)
    {
        pixelView.state = state;
    }
    return pixelView;
}

//解除占用
-(void)removeOccupy
{
    self.backgroundColor = [UIColor grayColor];
    self.state = 0;
}

//添加占用
-(void)addOccupy
{
    self.backgroundColor = [UIColor orangeColor];
    self.state = 1;
}


@end

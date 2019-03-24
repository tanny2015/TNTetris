//
//  TNPixelView.h
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNPixelView : UIView

//状态 0/1
@property(nonatomic,assign)BOOL state;


@property(nonatomic,assign)NSInteger startGridIndexX;
@property(nonatomic,assign)NSInteger startGridIndexY;
@property(nonatomic,assign)double currentGridIndexX;
@property(nonatomic,assign)double currentGridIndexY;



//横纵坐标 -- 相对于直接父控件
@property(nonatomic,assign)NSInteger pixX;
@property(nonatomic,assign)NSInteger pixY;

@property(nonatomic,assign)NSInteger pixTag;


//grid坐标
-(void)getCurrentGridIndexXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount;
//xy坐标
-(void)getCurrentNormalXYWithGridIndexX:(double)XGridIndex  AndYGridIndex:(double)YGridIndex;
//整合
-(void)getDoubleLocationXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount;


/**
 *  @param pixX  横坐标
 *  @param pixY  纵坐标
 *  @param state 当前状态
 *  @return 新建好的背景小格子
 */
+ (TNPixelView *)createPixelViewWithPixX:(NSInteger)pixX PixY:(NSInteger)pixY andState:(BOOL)state;


//解除占用
-(void)removeOccupy;

//添加占用
-(void)addOccupy;
@end

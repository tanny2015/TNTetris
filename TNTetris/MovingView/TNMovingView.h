//
//  TNMovingView.h
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNPixelView.h"


@interface TNMovingView : UIView

//移动方块颜色【暂时没用】
@property(nonatomic,strong)UIColor *color;

//pixelView
@property(nonatomic,strong) TNPixelView *pixelView;

//是否在移动
@property(nonatomic,assign)bool moving;


@property(nonatomic,assign)double startGridIndexX;//第一个小pixelView的grid坐标
@property(nonatomic,assign)double startGridIndexY;
@property(nonatomic,assign)double currentGridIndexX;
@property(nonatomic,assign)double currentGridIndexY;
@property(nonatomic,assign)double hasXGridCount;
@property(nonatomic,assign)double hasYGridCount;



@property(nonatomic,assign)BOOL canSwitchShape;
@property(nonatomic,assign)BOOL hasTouchTop; //触顶

//内部数组样式
typedef enum
{
    //是LineShape
    lineHoriz = 0,
    lineVerti,
    
    //是Rect
    rect,
    
    //是LRight
    zeroPIRightL ,
    onePIRightL,
    twoPIRightL,
    threePIRightL,
    
    //是LLeft
    zeroPILeftL ,
    onePILeftL,
    twoPILeftL,
    threePILeftL,
    
    //是TShape
    zeroPIT ,
    onePIT,
    twoPIT,
    threePIT,
    
    //是SLeft
    zeroPILeftS ,
    onePILeftS,
    
    //是SRight
    zeroPIRightS ,
    onePIRightS
    
} pixelViewArrayType;

@property(nonatomic, assign) pixelViewArrayType arrayType;

 //传入的是当前的arrayType
-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double*)XStepCount YStepCount:(double*)YStepCount;

//移除子view
-(void)removeAllChildViewFromMovingView:(TNMovingView *)movingView;


//下边三个暂时没用
//最左边的x
@property(nonatomic,assign)double mostLeftGridIndexX;
//最右边的x
@property(nonatomic,assign)double mostRightGridIndexX;
//最下方的Y
@property(nonatomic,assign)double mostBottomGridIndexY;



-(BOOL)canDropDownWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount ;
-(BOOL)canMoveToLeftWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount;
-(BOOL)canMoveToRightWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount;



//movingView的size
-(void)getSizeWithXGridCount:(double)hasXGridCount AndYGridCount:(double)hasYGridCount;
//grid坐标
-(void)getCurrentGridIndexXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount;
//xy坐标
-(void)getCurrentNormalXYWithGridIndexX:(double)XGridIndex  AndYGridIndex:(double)YGridIndex;
//把以上俩句整合
-(void)getDoubleLocationXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount;

//添加pixelView
-(void)addPixelViewToMovingViewWithDeviFromStartPixelView:(double)XDeviGrid  AndYDeviGrid:(double)YDeviGrid;


-(void)getRandomInitialViewArray;


//可以变换形状
-(BOOL)canSwitch:(TNMovingView *)movingView;



//起始位置【暂时没用】
-(void)setStartLocation;





-(void)moveDown;

-(void)moveToLeft;

//变形
-(void)switchShape;

//右移动
-(void)moveToRight;

//加速
//-(void)accelerate;


//随机数 
-(int)getRandomNumber:(int)from to:(int)to;

@end

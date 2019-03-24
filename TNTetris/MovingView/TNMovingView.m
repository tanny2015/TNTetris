//
//  TNMovingView.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNMovingView.h"

@implementation TNMovingView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.pixelView.backgroundColor = [UIColor greenColor];
    }
   
    return self;
}
 
-(void)getRandomInitialViewArray
{
}

-(void)moveDown
{
    self.y += pixelViewH;
    
}

-(void)moveToLeft
{
    self.x -= pixelViewW;
    
}

//变形
-(void)switchShape
{
    
}

//传入的是当前的arrayType
-(void)switchShapeWithCurrentArrayType:(pixelViewArrayType)arrayType AndXStepCount:(double*)XStepCount YStepCount:(double*)YStepCount
{
    
}

//右移动
-(void)moveToRight
{
   self.x += pixelViewW;
}

 
-(BOOL)canDropDownWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount
{
    
    [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
    
    int currentMaxGridIndexY  = self.currentGridIndexY + (self.hasYGridCount - 1);
    self.hasTouchTop = NO;
    int hasInCountWhenNotAllIn = 0;
    int allowDownCountWhenNotAllIn = 0;
    
    int allowDownCount = 0;

    if (currentMaxGridIndexY >= gridCountVerti - 1)
    {
        return NO;
    }
    
    for (int i =0; i<self.subviews.count; i++)
    {
        TNPixelView * view = self.subviews[i];
        [view getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
 
        if (self.currentGridIndexY <= - 1)
        {
            if(view.currentGridIndexY >= -1 )
            {
                ++hasInCountWhenNotAllIn ;
                TNPixelView * nextLineViewWhenNotAllIn = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:view.currentGridIndexX andY:view.currentGridIndexY + 1];
                if(nextLineViewWhenNotAllIn.state == 0)
                {
                    ++allowDownCountWhenNotAllIn ;
                }
                
                //判断触顶情况[直接可以用这个的else去判断反向的也行]
                if ( nextLineViewWhenNotAllIn.state == 1 )
                {
                     self.hasTouchTop = YES;
                    return NO;
                    
                }
                
            }
        }
        
 
        else if(self.currentGridIndexY > -1 && currentMaxGridIndexY < gridCountVerti - 1)
        {
            TNPixelView * nextLineView = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:view.currentGridIndexX andY:view.currentGridIndexY + 1];
            
            if(nextLineView.state == 0)
            {
                ++allowDownCount ;
            }
            if(self.currentGridIndexY == 0 && nextLineView .state == 1)
            {
                self.hasTouchTop = YES;
                return NO;
            }
            
        }
        
    }
 
    BOOL allowWhenNotAllIn =  (hasInCountWhenNotAllIn > 0 && allowDownCountWhenNotAllIn == hasInCountWhenNotAllIn);
    BOOL allowWhenAllIn = (allowDownCount == self.subviews.count);
    
    if ( allowWhenAllIn || allowWhenNotAllIn) return YES;
    else return NO;
    
    
}




-(BOOL)canMoveToLeftWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount
{
    
    int allowDownCount = 0;
    for (int i =0; i<self.subviews.count; i++)
    {
        TNPixelView * view = self.subviews[i];
        
        double currentGridIndexX = view.startGridIndexX + XStepCount;
        double currentGridIndexY = view.startGridIndexY + YStepCount;
 
        if (currentGridIndexY < 0 )
        {
            ++allowDownCount ;
            continue;
        }
 
         TNPixelView * leftView = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:currentGridIndexX - 1 andY:currentGridIndexY ];
        
        
        if(leftView.state == 0)
        {
            ++allowDownCount ;
        }
    }
    if (allowDownCount == self.subviews.count)
    {
        return YES;
    }
    
    return NO;
}


-(BOOL)canMoveToRightWithYStepCount:(double)YStepCount AndXStepCount:(double)XStepCount
{
    
    int allowDownCount = 0;
    for (int i =0; i<self.subviews.count; i++)
    {
        TNPixelView * view = self.subviews[i];
        
        double currentGridIndexX = view.startGridIndexX + XStepCount;
        double currentGridIndexY = view.startGridIndexY + YStepCount;
        
         if (currentGridIndexY  < 0 )
        {
            ++allowDownCount ;
            continue;
        }
        
        TNPixelView * rightView = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:currentGridIndexX + 1 andY:currentGridIndexY ];
        
         if(rightView.state == 0)
        {
            ++allowDownCount ;
        }
    }
    if (allowDownCount == self.subviews.count)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)canSwitch:(TNMovingView *)movingView
{
    int allowDownCount = 0;
    for (int i =0; i<movingView.subviews.count; i++)
    {
        TNPixelView * view = movingView.subviews[i];
 
        [view getCurrentGridIndexXYWithXStepCount:0 AndYStepCount:0];
 
        if (view.currentGridIndexY  < 0 || view.currentGridIndexY > gridCountVerti -1 || view.currentGridIndexX < 0 || view.currentGridIndexX > gridCountHoriz -1 )
        {
             return NO;
        }
 
        TNPixelView * BGPixelView = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:view.currentGridIndexX  andY:view.currentGridIndexY ];
        
         if(BGPixelView.state == 0)
        {
            ++allowDownCount ;
        }
    }
    if (allowDownCount == movingView.subviews.count)
    {
        return YES;
    }
    
    return NO;
    
}



//格子坐标
-(void)getCurrentGridIndexXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
    self. currentGridIndexX = self.startGridIndexX + XStepCount;
    self. currentGridIndexY = self.startGridIndexY + YStepCount;
    
}

// 真实的x和y坐标【刷新UI】
-(void)getCurrentNormalXYWithGridIndexX:(double)XGridIndex  AndYGridIndex:(double)YGridIndex
{
    self.x = XGridIndex * pixelViewW;
    self.y = YGridIndex * pixelViewH;
}


 -(void)getDoubleLocationXYWithXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
   //grid坐标
    [self getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];

   //xy坐标
    [self getCurrentNormalXYWithGridIndexX:self.currentGridIndexX AndYGridIndex:self.currentGridIndexY];


}

//movingView的大小
-(void)getSizeWithXGridCount:(double)hasXGridCount AndYGridCount:(double)hasYGridCount
{
    [self setSize:CGSizeMake(hasXGridCount * pixelViewW, hasYGridCount * pixelViewH)];
}


//添加pixelView
-(void)addPixelViewToMovingViewWithDeviFromStartPixelView:(double)XDeviGrid  AndYDeviGrid:(double)YDeviGrid
{
   
    self.pixelView = [TNPixelView createPixelViewWithPixX:XDeviGrid PixY:YDeviGrid andState:1];
    self.pixelView.startGridIndexX = self.startGridIndexX + XDeviGrid;
    self.pixelView.startGridIndexY = self.startGridIndexY + YDeviGrid;
    
     [self addSubview:self.pixelView];
    self.pixelView.backgroundColor = [UIColor greenColor];
}


 //设置起始位置
-(void)setStartLocation
{


}


 
//移除子view
-(void)removeAllChildViewFromMovingView:(TNMovingView *)movingView
{
     while (movingView.subviews.count)
    {
         [movingView.subviews[0] removeFromSuperview];
    }
 }


//随机数
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
}


@end

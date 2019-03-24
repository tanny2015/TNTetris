//
//  TNBackgroundVC.m
//  TNTetris
//
//  Created by mac on 15/8/22.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNBackgroundVC.h"
#import "TNPixelView.h"

#import "MBProgressHUD+MJ.h"

#import "TNMovingView.h"
#import "TNMovingViewTypeHeader.h"


@interface TNBackgroundVC ()

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)double timeInterval;

@property(nonatomic,assign)double dropYStepCount;
@property(nonatomic,assign)double moveXStepCount;

@property(nonatomic,strong)TNMovingView *movingView;

@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)UIButton *moveToLeftBtn;
@property(nonatomic,strong)UIButton *switchShapeBtn;
@property(nonatomic,strong)UIButton *moveToRightBtn;
@property(nonatomic,strong)UIButton *accelerateBtn;
@property(nonatomic,strong)UIButton *decelerateBtn;


//movingView的样式
typedef enum
{
    LineShapeView = 0,
    RectShapeView,
    LRightShapeView,
    LLeftShapeView,
    TShapeView,
    SLeftShapeView,
    SRightShapeView
    
} movingViewType;

@property(nonatomic,assign) movingViewType movingViewType;


@end

@implementation TNBackgroundVC

-(void)getRandomMovingView
{
    

    self.movingViewType = arc4random() % 7;
 
    NSLog(@"=====%d",self.movingViewType);
    switch (self.movingViewType)
    {
        case LineShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildLineShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }
            
        case RectShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildRectShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

        case LRightShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildLRightShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

        case LLeftShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildLLeftShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

        case TShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildTShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

        case SLeftShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildSLeftShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

        case SRightShapeView:
        {
            if (self.movingView == nil)
            {
                self.movingView = [[TNChildSRightShapeView alloc] init];
                [self.view addSubview:_movingView];
            }
            
            break;
        }

            
        default:
            break;
    }
    
    
}

//先做恒速的
-(NSTimer *)timer
{
    if (_timer == nil)
    {
        _timer = [NSTimer timerWithTimeInterval:0.15f target:self selector:@selector(onMoving) userInfo:nil repeats:YES ];
       
    }
    return _timer;
}


-(NSMutableArray *)pixelViewArray
{
    if (_pixelViewArray == nil)
    {
        _pixelViewArray = [NSMutableArray array];
    }
    
    
    return _pixelViewArray;
}

 
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.frame = CGRectMake(backgroundViewX, backgroundViewY, backgroundViewW, backgroundViewH);
    self.view.backgroundColor = [UIColor blackColor];
    
//BGView格子添加
    [self circleAddPixelViewToBGView];
 
//创建按钮
    [self createPanel];
    
    [self getRandomMovingView];
    [self.movingView getRandomInitialViewArray];
 }


//#define backgroundViewX 250
//#define backgroundViewY 410


-(void)circleAddPixelViewToBGView
{
 
    for (int i = 0; i < gridCountVerti ; i++)//行
    {
        for (int j = 0; j<gridCountHoriz; j++)//列
        {
            //or九宫格
            TNPixelView *view = createPixelView(j, i);
 
            [self.view addSubview:view];
            [self.pixelViewArray addObject:view];
        }
    }
//数据源
    [TNDataStore sharedDataStore].pixelViewArray = [NSMutableArray arrayWithArray:self.pixelViewArray];
}

//按钮添加
-(void)createPanel
{
    int btnW = 25;
    int btnH = 30;
    int btnPadding = 3;
    
    
    //开始按钮
    self.startBtn = [[self class]  createButton:@selector(startBtnDidClicked:) target:self  title:@"走" frame:CGRectMake( screenW - btnW * 2 - 2 * btnPadding, screenH/2 - btnH * 3/2, 2 *btnW + btnPadding, btnH) addedto:self.parentViewController.view  ];
    
    //左移动
    self.moveToLeftBtn = [[self class] createButton:@selector(moveToLeft) target:self  title:@"左" frame:CGRectMake( self.startBtn.x , CGRectGetMaxY(self.startBtn.frame) + btnPadding, 1.5*btnW, btnH) addedto:self.parentViewController.view ];
    
    //右移动
    self.moveToRightBtn = [[self class] createButton:@selector(moveToRight) target:self  title:@"右" frame:CGRectMake( screenW - 1.5 * btnW - btnPadding, CGRectGetMaxY(self.moveToLeftBtn.frame) + btnPadding, 1.5*btnW, btnH) addedto:self.parentViewController.view ];

    //变形状
    self.switchShapeBtn = [[self class] createButton:@selector(switchShape) target:self  title:@"变" frame:CGRectMake( self.startBtn.x , CGRectGetMaxY(self.moveToRightBtn.frame) + btnPadding , self.startBtn.width, 2 * btnH) addedto:self.parentViewController.view  ];
    
    //加速
    self.accelerateBtn = [[self class] createButton:@selector(accelerate) target:self  title:@"快" frame:CGRectMake( self.startBtn.x ,  CGRectGetMaxY(self.switchShapeBtn.frame)+ btnPadding, 2 * btnW + btnPadding, btnH) addedto:self.parentViewController.view  ];
}


//循环迭换效果
static bool startTimer = NO;
//开始按钮
-(void)startBtnDidClicked:(UIButton *)startBtn
{
    NSLog(@"开始了！");
    
    // 开始
    if (startTimer == NO)
    {
         [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
         startTimer = YES;
        
    }
    // 暂停
    else
    {
        [self.timer invalidate];
        self.timer = nil;
        startTimer = NO;
    }
   
}

//下落
static double finalYStepCount;
static double finalXStepCount;
-(void)onMoving
{
    BOOL canDropDown = [self.movingView canDropDownWithYStepCount:_dropYStepCount AndXStepCount:_moveXStepCount];
    
    //1.触顶了 停止游戏
    if (!canDropDown && self.movingView.hasTouchTop)
    {
        
        [MBProgressHUD showError: @"Game Over,Play Again ~" toView:self.view.superview];
        
        //1.清空最后一个movingView，停止NSTimer
        [self.movingView removeFromSuperview];
        self.movingView = nil;
        
        [self.timer invalidate];
        self.timer = nil;
        startTimer = NO;
        
        //2.重新创建BGView
        [self.pixelViewArray removeAllObjects];
        [self circleAddPixelViewToBGView];
        
        //3.随机创建movingView
        [self getRandomMovingView];
        [self.movingView getRandomInitialViewArray];
        
         return;

    }
    
    //2.可以正常下落
    else if (CGRectGetMaxY(self.movingView.frame) < backgroundViewH &&  canDropDown)
    {
         [self.movingView moveDown];
         self.movingView.moving = YES;
         ++_dropYStepCount;

    }
    
    //3.不能下落，但不是触顶
    else
    {
        [self.timer invalidate];
        self.timer = nil;
        startTimer = NO;
 
        self.movingView.moving = NO;
        
 
        finalYStepCount = _dropYStepCount;
        finalXStepCount = _moveXStepCount;
        _dropYStepCount = 0;
        _moveXStepCount = 0;
      
        
        [self colorEffectiveGridsInArray:self.movingView.subviews AndXStepCount:finalXStepCount AndYStepCount:finalYStepCount];
        [self deleteFullLineAndDistributeNewMovingView];
        
    }

}

static double effectiveValueInlineCount;


-(void)deleteFullLineAndDistributeNewMovingView
{
     //改变颜色
    for(int i = gridCountVerti - 1; i >=0 ;i--)
    {
         effectiveValueInlineCount = 0;
        for (int j = 0; j< gridCountHoriz ; j++)
        {
 
            TNPixelView *view = [[TNDataStore sharedDataStore]  pixelViewArrayWithIndexX:j andY:i ];
            if (view.state == 1)
            {
                 ++effectiveValueInlineCount;
            }
        }
        if (effectiveValueInlineCount==0)
        {
            
            [self.movingView removeFromSuperview];
            self.movingView = nil;
            
#warning  分发新movingView
            [self getRandomMovingView];
            [self.movingView getRandomInitialViewArray];
            
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            startTimer = YES;
 
            return;
        }
        if (effectiveValueInlineCount == gridCountHoriz)
        {
            //消行
            [self deleteFullLineWithIndex:i];
            [self deleteFullLineAndDistributeNewMovingView];
        }
        
    }
    
}




//消行 --传入行数
-(void)deleteFullLineWithIndex:(int)index
{
    for (int j = 0; j< gridCountHoriz ; j++)
    {
        TNPixelView *view = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:j andY:index ];
         [view removeOccupy];
        
    }
    [self putAboveDownWithIndex:index];
}

//把其他有颜色的全部往下放移动一位  - 传入行数
-(void)putAboveDownWithIndex:(int)index
{
    //遍历 -- 从当前行数以上开始
    for(int i = index - 1; i >=0 ;i--)
    {
        effectiveValueInlineCount = 0;
        for (int j = 0; j< gridCountHoriz ; j++)
        {
            TNPixelView *view = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:j andY:i];
            if(view.state == 1)
            {
                TNPixelView *view = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:j andY:i+1 ];
                [view addOccupy];
                ++effectiveValueInlineCount ;
            }
            [view removeOccupy];
        }
        if (effectiveValueInlineCount==0)
        {
            return;
        }
    }
    
    
}

//左移动
-(void)moveToLeft
{
    
    if (CGRectGetMinX(self.movingView.frame) > 0 && self.movingView.moving && startTimer && [self.movingView canMoveToLeftWithYStepCount:_dropYStepCount AndXStepCount:_moveXStepCount])
    {
        [self.movingView moveToLeft];
        --_moveXStepCount ;
    }
    
}

//变形
-(void)switchShape
{
 
    if(self.movingView.arrayType == rect)
    {
        return;
    }
    
     if (CGRectGetMaxX(self.movingView.frame) <= backgroundViewW && CGRectGetMaxY(self.movingView.frame) <= backgroundViewH && self.movingView.y >= 0 && self.movingView.moving && startTimer)
    {
    
        [self.timer invalidate];
        self.timer = nil;
        startTimer = NO;
        self.movingView.moving = NO;
    
        [self.movingView switchShapeWithCurrentArrayType:self.movingView.arrayType AndXStepCount:&_moveXStepCount YStepCount:&_dropYStepCount];
    
        [self.view addSubview:_movingView];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        startTimer = YES;
    }
}

//右移动
-(void)moveToRight
{
    if (CGRectGetMaxX(self.movingView.frame) < backgroundViewW && self.movingView.moving && startTimer  && [self.movingView canMoveToRightWithYStepCount:_dropYStepCount AndXStepCount:_moveXStepCount])
    {
            [self.movingView moveToRight];
             ++_moveXStepCount;
    }
    

}

//加速
-(void)accelerate
{
    if ( self.movingView.moving && startTimer )
    {
        [self onMoving];
    }

}

//添加按钮
+ (UIButton *)createButton:(SEL)action target:(id)target title:(NSString *)text frame:(CGRect)frame addedto:(UIView *)fatherView
{
    
    //添加一个按钮到这个菜单view上去，点击该按钮，就能把他收回去
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    if (text)
    {
        btn.titleLabel.textAlignment = NSTextAlignmentCenter ;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitle:text forState:UIControlStateNormal];
    }
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor orangeColor];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    [fatherView addSubview:btn];
    return btn;
}

//涂色
-(void)colorEffectiveGridsInArray:(NSArray *)array  AndXStepCount:(double)XStepCount AndYStepCount:(double)YStepCount
{
    for (int i = array.count - 1; i >=0 ; i-- )
    {
        TNPixelView *movingView = (TNPixelView *)(array[i]);
        [movingView getCurrentGridIndexXYWithXStepCount:XStepCount AndYStepCount:YStepCount];
        
        TNPixelView *bgView = [[TNDataStore sharedDataStore] pixelViewArrayWithIndexX:movingView.currentGridIndexX andY:movingView.currentGridIndexY];
        [bgView addOccupy];
        
    }
}



  
@end

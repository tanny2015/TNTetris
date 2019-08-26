//
//  TNMainViewController.m
//  TNTetris
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNMainViewController.h"
#import "TNBackgroundVC.h"
@interface TNMainViewController ()
@property(nonatomic,strong)TNBackgroundVC *BGVC;
@end

@implementation TNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
     self.BGVC = [[TNBackgroundVC alloc] init];
    //    self.BGVC.view.backgroundColor = [UIColor orangeColor];
 
    [self addChildViewController:self.BGVC];
    [self.view addSubview:self.BGVC.view];
    [self.BGVC didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

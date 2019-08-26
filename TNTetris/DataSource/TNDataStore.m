//
//  TNDataStore.m
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import "TNDataStore.h"

@implementation TNDataStore
SingletonM(DataStore)






//取出array中的一个pixelView
-(TNPixelView *) pixelViewArrayWithIndexX:(int)indexX andY:(int)indexY
{
    TNPixelView *view = [TNPixelView createPixelViewWithPixX:indexX PixY:indexY andState:0];
    //根据x和y算出tag，毕竟这个array构造的时候，就没有赋予他二维数组的构架，因此只能通过tag这个单一的index来取值
    view = [self.pixelViewArray objectAtIndex:view.pixTag];
    return view;
}

@end

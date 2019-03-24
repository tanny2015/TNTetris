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
    view = [self.pixelViewArray objectAtIndex:view.pixTag];
    return view;
}

@end

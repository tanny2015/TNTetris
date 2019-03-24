//
//  TNDataStore.h
//  TNTetris
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 tanorigin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface TNDataStore : NSObject

@property(nonatomic,strong)NSMutableArray *pixelViewArray;




//取出array中的一个pixelView
-(TNPixelView *) pixelViewArrayWithIndexX:(int)indexX andY:(int)indexY;


SingletonH(DataStore)
@end

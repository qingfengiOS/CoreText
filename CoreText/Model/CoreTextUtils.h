//
//  CoreTextUtils.h
//  CoreText
//
//  Created by 情风 on 2018/7/25.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

@interface CoreTextUtils : NSObject

/**
 检测点击位置是否在链接上
 
 @param view 所在View
 @param point 点击的点
 @param data 数据源
 @return CoreTextLinkData
 */
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end

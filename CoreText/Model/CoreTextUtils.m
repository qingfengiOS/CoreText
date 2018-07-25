//
//  CoreTextUtils.m
//  CoreText
//
//  Created by 情风 on 2018/7/25.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "CoreTextUtils.h"

@implementation CoreTextUtils


/**
 检测点击位置是否在链接上

 @param view 所在View
 @param point 点击的点
 @param data 数据源
 @return CoreTextLinkData
 */
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data {
    CFIndex index = [self touchContentOffsetInView:view atPoint:point data:data];
    if (index == -1) {
        return nil;
    }
    CoreTextLinkData *foundLink = [self linkAtIndex:index linkArray:data.linkArray];
    return foundLink;
}

/**
 将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1

 @param view 所在View
 @param point 点击的点
 @param data 数据源
 @return 偏移量
 */
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data {
    
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return -1;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    //获取每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    
    CFIndex index = -1;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        //获取每一行的rect
        CGRect flipedRect = [self getLinesBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flipedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect),
                                                point.y - CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            index = CTLineGetStringIndexForPosition(line, relativePoint);
        }
    }
    return index;
}

+ (CGRect)getLinesBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

+ (CoreTextLinkData *)linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray {
    CoreTextLinkData *link = nil;
    for (CoreTextLinkData *data in linkArray) {
        if (NSLocationInRange(i, data.range)) {
            link = data;
            break;
        }
    }
    return link;
}

@end

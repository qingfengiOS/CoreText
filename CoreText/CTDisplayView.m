//
//  CTDisplayView.m
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreText/CoreText.h"
#import "PrefixHeader.pch"

@implementation CTDisplayView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //step1 获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //step2 坐标系翻转(上下翻转 如果没有这个步骤，文字会倒转显示)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //step3 创建绘制区域，这里把整个View作为排版绘制的区域
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);//矩形绘制区域
    CGPathAddEllipseInRect(path, NULL, self.bounds);//椭圆绘制区域
    
    //step4
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:@"创建绘制的区域，本身支持各种文字排版的区域 我们这里简单地将的整个界面作为排版的区域。为了加深理解，建议读者将该步骤的代码替换成如下代码 测试设置不同的绘制区域带来的界面变化"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attributedString length]), path, NULL);
    
    //step5
    CTFrameDraw(frame, context);
    
    //step6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);

    
}


@end

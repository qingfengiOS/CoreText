//
//  CTFrameParser.m
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "CTFrameParser.h"
#import "CoreText/CoreText.h"

@implementation CTFrameParser

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config {
    
    NSDictionary *attributes = [self attributrsWithConfig:config];
    NSAttributedString *contentString = [[NSAttributedString alloc]initWithString:content
                                                                       attributes:attributes];
    
    //CTFramesetterRef实例
    CTFramesetterRef framessetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contentString);
    
    //获取绘制区域的高度
    CGSize restrictSize = CGSizeMake(config.width, MAXFLOAT);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framessetter, CFRangeMake(0, 0), NULL, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    //生成CTFrmeRef实例
    CTFrameRef frameRef = [self createFrameWithFramesetter:framessetter config:config height:textHeight];
    
    //保存生成好的CTFrameRef实例和计算好的绘制高度到CoreTextData中
    CoreTextData *data = [[CoreTextData alloc]init];
    data.ctFrame = frameRef;
    data.height = textHeight;
    
    CFRelease(frameRef);
    CFRelease(framessetter);
    return data;
}

/**
 通过配置设置字体大小 字体颜色

 @param config 配置信息
 @return 配置字典
 */
+ (NSDictionary *)attributrsWithConfig:(CTFrameParserConfig *)config {
    
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace }
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor *textColor = config.textColor;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dic[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dic[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dic;
}


/**
 生成CTFrmeRef实例

 @param framesetter framesetter
 @param config 配置信息
 @param height 高度
 @return CTFrameRef对象
 */
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(CTFrameParserConfig *)config
                                  height:(CGFloat)height {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

@end

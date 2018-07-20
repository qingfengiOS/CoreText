//
//  CTFrameParser.h
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

/**
 生成最终绘制界面所需要的CTFrameRef实例
 */
@interface CTFrameParser : NSObject

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig*)config;

/**
 通过配置计算文字CoreTextData

 @param content 绘制内容
 @param config 配置信息
 @return CoreTextData
 */
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
@end

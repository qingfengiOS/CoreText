//
//  CoreTextData.h
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreText/CoreText.h"

/**
 用于保存由CTFrameParser类生成的CTFrameRef实例，以及CTFrameRef实际绘制需要的高度
 */
@interface CoreTextData : NSObject

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CTFrameRef ctFrame;

@end

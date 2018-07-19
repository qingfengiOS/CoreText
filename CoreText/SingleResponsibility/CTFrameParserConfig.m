//
//  CTFrameParserConfig.m
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "CTFrameParserConfig.h"
#import "PrefixHeader.pch"

@implementation CTFrameParserConfig

- (instancetype)init {
    if (self = [super init]) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(51, 51, 51);
    }
    return self;
}

@end

//
//  CoreTextLinkData.h
//  CoreText
//
//  Created by 情风 on 2018/7/25.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * url;
@property (assign, nonatomic) NSRange range;

@end

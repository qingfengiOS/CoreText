//
//  CoreTextDisplayView.h
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"

/**
 持有coreText类实例对象，将CTFrameRef绘制到界面上
 */
@interface CoreTextDisplayView : UIView

@property (nonatomic, strong) CoreTextData *data;

@end

//
//  ViewController.m
//  CoreText
//
//  Created by 情风 on 2018/7/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextDisplayView.h"
#import "CTFrameParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CoreTextDisplayView *displayView = [[CoreTextDisplayView alloc]initWithFrame:CGRectMake(50, 50, 300, 0)];
    displayView.backgroundColor = UIColor.redColor;
    [self.view addSubview:displayView];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc]init];
    config.textColor = [UIColor whiteColor];
    config.width = displayView.bounds.size.width;
    config.lineSpace = 5.0f;
    config.fontSize = 16.0;
    
    CoreTextData *coreTextData = [CTFrameParser parseContent:@"创建绘制的区域，本身支持各种文字排版的区域 我们这里简单地将的整个界面作为排版的区域。为了加深理解，建议读者将该步骤的代码替换成如下代码 测试设置不同的绘制区域带来的界面变化\n    高度已经计算好了" config:config];
    displayView.data = coreTextData;
    displayView.frame = CGRectMake(50, 50, 300, coreTextData.height);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

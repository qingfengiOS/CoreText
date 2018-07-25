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
#import "UIView+frameAdjust.h"
#import "CoreTextLinkData.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CoreTextDisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [self drawWithString];
//    [self drawWithAttributedString];
    
    [self userProtocol];
}

- (void)drawWithString {
  
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc]init];
    config.textColor = [UIColor redColor];
    config.width = self.ctView.width;
    config.lineSpace = 5.0f;
    config.fontSize = 16.0;
    
    CoreTextData *coreTextData = [CTFrameParser parseContent:@"创建绘制的区域，本身支持各种文字排版的区域 我们这里简单地将的整个界面作为排版的区域。为了加深理解，建议读者将该步骤的代码替换成如下代码 测试设置不同的绘制区域带来的界面变化\n    高度已经计算好了" config:config];
    self.ctView.data = coreTextData;
    self.ctView.height = coreTextData.height;
}

- (void)drawWithAttributedString {
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.ctView.width;
    config.textColor = [UIColor blackColor];
    
    NSString *content = @"对于上面的例子，我们给CTFrameParser增加了一个将NSString转换为CoreTextData的方法。"
    "但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体大小，颜色，行高等信息，但是却不能支持定制内容中的某一部分。"
    "例如，如果我们只想让内容的前三个字显示成红色，而其它文字显示成黑色，那么就办不到了。"
    "\n\n"
    "解决的办法很简单，我们让`CTFrameParser`支持接受NSAttributeString作为参数，然后在NSAttributeString中设置好我们想要的信息。";
    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];    //此方法不起效， 使用 -addAttributes range
    CTFrameParserConfig *redConfig = [[CTFrameParserConfig alloc] init];
    redConfig.textColor = [UIColor redColor];
    redConfig.fontSize = 17.0f;
    [attributedString addAttributes:[CTFrameParser attributesWithConfig:redConfig] range:NSMakeRange(0, 8)];
    
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor yellowColor];
}


- (void)userProtocol {
    
    //富文本配置内容
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc]init];
    config.width = [UIScreen mainScreen].bounds.size.width - 20;
    config.textColor = [UIColor blueColor];
    NSString *promotString = @"点击下一步表示已阅读并同意";
    NSString *contentString = @"《关于民航乘客携带锂电池及危险品乘机的限制》、《合众附加综合交通工具意外伤害医疗保险（2013修订）条款》、《航空意外险说明》、《客户告知书》。";
    NSString *content = [NSString stringWithFormat:@"%@%@",promotString,contentString];
    
    NSDictionary *att = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content attributes:att];
    
    //富文本前的提示不需要特殊颜色
    CTFrameParserConfig *darkGrayConfig = [[CTFrameParserConfig alloc]init];
    NSDictionary *darkGrayAtt = [CTFrameParser attributesWithConfig:darkGrayConfig];
    [attributedString addAttributes:darkGrayAtt range:NSMakeRange(0, 13)];
 
    //由绘制文本和配置信息获取数据源
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];
    data.linkArray = [self configLinkArray:promotString contentString:contentString];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor whiteColor];
}


//设置点击链接数据
- (NSMutableArray *)configLinkArray:(NSString *)promotString contentString:(NSString *)contentString {
    NSMutableArray *linkarray = [NSMutableArray array];
    NSArray *array = [contentString componentsSeparatedByString:@"、"];
    NSArray *urlArray = @[@"http://www.shanglv51.com/Content/Static/OpportunityNotice.html",
                          @"http://www.shanglv51.com/Content/doc/合众附加综合交通工具意外伤害医疗保险（2013修订）条款.pdf",
                          @"http://www.shanglv51.com/Content/doc/航空意外险说明.pdf",
                          @"http://www.shanglv51.com/Content/doc/客户告知书.pdf"];
    NSInteger start = promotString.length;
    for (NSUInteger i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CoreTextLinkData *linkData = [[CoreTextLinkData alloc]init];
        linkData.title = str;
        linkData.url = urlArray[i];
        linkData.range = NSMakeRange(start, str.length);
        [linkarray addObject:linkData];
        start += str.length + 1;
    }
    return linkarray;
    
}

@end

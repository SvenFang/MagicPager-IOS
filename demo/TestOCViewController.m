//
//  TestOCViewController.m
//  demo
//
//  Created by Sven on 11/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

#import "TestOCViewController.h"
#import "demo-Swift.h"
#import <magicpager/magicpager.h>

@interface TestOCViewController ()<MagicSvgaDelegate, ModelActionDelegate>

@property (nonatomic, strong) MagicSvga *svgaMagic;

@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSArray<NSString *> *svgaUrls;
@end

@implementation TestOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _svgaUrls = @[
    @"https://mgamevoice2.bs2dl.yy.com/d3467ef261f943108d3111739f00aacd.svga",
    @"https://mgamevoice2.bs2dl.yy.com/607e73833c474514adc0819ba1f9ce04.svga",
    @"https://mgamevoice2.bs2dl.yy.com/14cfe5bfbe3a407babcdcc99f51131c8.svga",
    @"https://mgamevoice2.bs2dl.yy.com/7a82db2b89d84667b6b5c34b773a80f4.svga",
    @"https://mgamevoice2.bs2dl.yy.com/b4521aea4ba44ffda4f096811b2925a6.svga"];
}

- (IBAction)addSvgaAction:(id)sender {
    
    [self addSvga];
}

- (void)addFlow {
    FlexboxWidgetModel *flex = [[FlexboxWidgetModel alloc] init];
    flex.width = ModelConstants.MATCH_PARENT;
    flex.height = ModelConstants.MATCH_PARENT;
    flex.flexDirection = MFlexDirection.ROW_REVERSE;
    flex.justifyContent = MJustifyContent.FLEX_START;
    
    NSMutableArray<BaseWidgetModel *> *items = [NSMutableArray<BaseWidgetModel *> array];
    
    for (int i = 0; i < 3; i++) {
        TextWidgetModel *item = [[TextWidgetModel alloc] init];
        item.text = [NSString stringWithFormat:@"%d", i];
        item.textColor = @"#000000";
        item.textSize = 20;
        item.textVerticalAlignment = VerticalAlignment.CENTER;
        item.textHorizontalAlignment = HorizontalAlignment.CENTER;
        item.bgColor = @"#ffffff";
        item.border = 4;
        item.borderColor = @"#ff00ff";
        item.height = 50 + arc4random() % 50;
        item.width = 50 + arc4random() % 50;
        item.padding = [[Padding alloc] initWithLeft:5 top:5 right:5 bottom:5];
        item.margin = [[Margin alloc] initWithLeft:5 top:5 right:5 bottom:5];
        [items addObject:item];
//        item.actionDelegate = self;
//        item.action = @"native.call(\"magic\", \"dismiss\")";
        PagerRequestData *request = [[PagerRequestData alloc] initWithType:@"test" key:@"testAd" param:nil];
        item.action = [NSString stringWithFormat:@"native.call(\"magic\", \"show\", '%@')", [request jsonString]];
//        item.action = @"native.call(\"magic\", \"show\", '{\"type\":\"test\",\"key\":\"testAd\"}')";
        
    }
    
    flex.items = items;
    
    IMagic *magic = [MagicViewCreator createViewWithModel:flex maxWidth:ModelConstants.MATCH_PARENT maxHeight:ModelConstants.MATCH_PARENT delegate:nil];
    [_contentView addSubview:magic];
}

- (void)addLinear {
    LinearWidgetModel *linear = [[LinearWidgetModel alloc] init];
    linear.width = 375.0;
    linear.height = ModelConstants.MATCH_PARENT;
    linear.orientation = Orientation.HORIZONTAL;
    linear.verticalAlignment = VerticalAlignment.BOTTOM;
    linear.horizontalAlignment = HorizontalAlignment.RIGHT; 

    BlankWidgetModel *blank = [[BlankWidgetModel alloc] init];
    blank.width = 100;
    blank.height = 100;
    blank.bgColor = @"#00ff00";
//    blank.text = @"123";
    blank.borderColor = @"#ffffff";
    blank.border = 2;
    
    BlankWidgetModel *blank2 = [[BlankWidgetModel alloc] init];
        blank2.width = 100;
        blank2.height = 100;
        blank2.bgColor = @"#0000ff";
    //    blank.text = @"123";
        blank2.borderColor = @"#ffffff";
        blank2.border = 2;
    
    linear.items = @[blank, blank2];
    
    IMagic *magic = [MagicViewCreator createViewWithModel:linear maxWidth:375 maxHeight:ModelConstants.MATCH_PARENT delegate:nil];
    [_contentView addSubview:magic];
}


- (void)addSvga {
    SvgaWidgetModel *svgaModel = [[SvgaWidgetModel alloc] init];

    int x = arc4random() % 5;
    
    svgaModel.width = 375;
    svgaModel.loops = 2;
    svgaModel.duration = 0;
    svgaModel.sourceUrl = [_svgaUrls objectAtIndex:x];
    
    SvgaText *svgaText = [[SvgaText alloc] init];
    svgaText.text = @"测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 测试用户 ";
    svgaText.textSize = 15;
    svgaText.color = @"#ff00ff";
    svgaText.alignment = HorizontalAlignment.RIGHT;
    
    svgaModel.textMap = @{@"username": svgaText};
    svgaModel.imageMap = @{@"toux": @"https://upload.jianshu.io/users/upload_avatars/17775851/74897be1-1d4f-4968-909e-cb3cb67e7643?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"};
    
    if (_svgaMagic) {
        [_svgaMagic updateWidgetWithModel:svgaModel];
    } else {
        IMagic *magic = [MagicViewCreator createViewWithModel:svgaModel maxWidth:ModelConstants.MATCH_PARENT maxHeight:ModelConstants.WRAP_CONTENT delegate:nil];
        
        if ([magic isKindOfClass:MagicSvga.class]) {
            [_contentView addSubview:magic];
            _svgaMagic = (MagicSvga *)magic; 
            _svgaMagic.svgaDelegate = self;
        }
    }
}

- (void)onFinishedWithSvga:(MagicSvga *)svga {
    NSLog(@"onFinishedWithSvga");
}

- (void)onErrorWithSvga:(MagicSvga *)svga {
    NSLog(@"onErrorWithSvga");
}

- (void)onStartWithSvga:(MagicSvga *)svga {
    NSLog(@"onStartWithSvga");
}

- (void)magicViewDidClickWithView:(IMagic *)view controller:(UIViewController *)controller {
    NSLog(@"view->%@, vc->%@", view, controller);
}

- (void)dealloc
{
    NSLog(@"TestOCViewController dealloc");
}


@end

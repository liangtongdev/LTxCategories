//
//  ViewController.m
//  LTxCategoriesDemo
//
//  Created by liangtong on 2018/9/4.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "LTxViewController.h"
#import "LTxCategories.h"

@interface LTxViewController ()

//圆角
@property (weak, nonatomic) IBOutlet UILabel *cornerLabel;
@property (weak, nonatomic) IBOutlet UIButton *cornerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cornerImageView;
@property (weak, nonatomic) IBOutlet UILabel *cornerLabel2;
@property (weak, nonatomic) IBOutlet UILabel *cornerTipL;

//角标
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *badgeBtn3;

//placeholder
@property (weak, nonatomic) IBOutlet UITextView *textView;

//animation
@property (weak, nonatomic) IBOutlet UIButton *startAnimateBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopAnimateBtn;

//行间距
@property (weak, nonatomic) IBOutlet UILabel *lineSpaceLabel;

@end

@implementation LTxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //placeholder
    [self showPlaceholder];
    
    //TOAST
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view ltx_makeToast:@"HELLO,WORLD!"];
    });
    
    self.lineSpaceLabel.ltx_lineSpace = 12.f;
    self.lineSpaceLabel.ltx_wordSpace = 4.f;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self showCornerCategories];
    [self showHexColor];
    
    [self showBadgeBtn];
    
}


#pragma mark - animationg

- (IBAction)startAnimation:(UIButton *)sender {
    [sender ltx_startAnimating];
    [self.navigationItem ltx_startAnimatingAt:LTxNaviBarLoaderPositionCenter];
    [[UIApplication  sharedApplication] ltx_beganNetworkActivity];
}
- (IBAction)stopAnimation:(UIButton *)sender {
    [self.startAnimateBtn ltx_stopAnimating];
    [self.navigationItem ltx_stopAnimating];
    [[UIApplication  sharedApplication] ltx_endedNetworkActivity];
}



#pragma mark - placeholder
-(void)showPlaceholder{
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1.f;
    [self.textView ltx_addPlaceHolder:@"this is textview placeholder..."];
}

#pragma mark - 角标
-(void)showBadgeBtn{
    self.badgeBtn1.ltx_badgeValue = @"标";
    
    self.badgeBtn2.ltx_badgeValue = @"666";
    self.badgeBtn2.ltx_badgeBGColor = [UIColor ltx_colorWithHexString:@"#6FB44B"];
    
    self.badgeBtn3.ltx_badgeValue = @"颜色";
    self.badgeBtn3.ltx_badgeBGColor = [UIColor orangeColor];
    self.badgeBtn3.ltx_badgeTextColor = [UIColor blueColor];
}


#pragma mark - 16进制颜色
-(void)showHexColor{
    self.cornerTipL.backgroundColor = [UIColor ltx_colorWithHexString:@"#6FB44B"];
    self.cornerTipL.textColor = [UIColor ltx_colorWithHexString:@"#FFFFFF"];
}

#pragma mark - 圆角
-(void)showCornerCategories{
    self.cornerLabel.cornerType = LTxCornerBottomRight | LTxCornerBottomLeft | LTxCornerTopLeft;
    self.cornerLabel.cornerRadius = 30.f;
    
    self.cornerBtn.cornerType = LTxCornerBottomRight | LTxCornerBottomLeft | LTxCornerTopRight;
    self.cornerBtn.cornerRadius = 30.f;
    
    self.cornerImageView.cornerType = LTxCornerBottomRight | LTxCornerTopLeft;
    self.cornerImageView.cornerRadius = 40.f;
    
    self.cornerLabel2.cornerType = LTxCornerAll;
    self.cornerLabel2.cornerRadius = 60.f;
    
    self.cornerTipL.cornerType = LTxCornerAll;
    self.cornerTipL.cornerRadius = 5.f;
}

@end

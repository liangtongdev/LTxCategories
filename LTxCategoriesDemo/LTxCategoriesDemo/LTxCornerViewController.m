//
//  ViewController.m
//  LTxCategoriesDemo
//
//  Created by liangtong on 2018/9/4.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "LTxCornerViewController.h"
#import "LTxCategories.h"

@interface LTxCornerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cornerLabel;
@property (weak, nonatomic) IBOutlet UIButton *cornerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cornerImageView;
@property (weak, nonatomic) IBOutlet UILabel *cornerLabel2;



@end

@implementation LTxCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view ltx_makeToast:@"HELLO,WORLD!"];
    });
    self.title = @"切圆角";
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.cornerLabel.cornerType = LTxCornerBottomRight | LTxCornerBottomLeft | LTxCornerTopLeft;
    self.cornerLabel.cornerRadius = 30.f;
    
    self.cornerBtn.cornerType = LTxCornerBottomRight | LTxCornerBottomLeft | LTxCornerTopRight;
    self.cornerBtn.cornerRadius = 30.f;
    
    self.cornerImageView.cornerType = LTxCornerBottomRight | LTxCornerTopLeft;
    self.cornerImageView.cornerRadius = 40.f;
    
    self.cornerLabel2.cornerType = LTxCornerAll;
    self.cornerLabel2.cornerRadius = 60.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  LTxCategoriesDemo
//
//  Created by liangtong on 2018/9/4.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "ViewController.h"
#import "LTxCategories.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view ltx_makeToast:@"HELLO,WORLD!"];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

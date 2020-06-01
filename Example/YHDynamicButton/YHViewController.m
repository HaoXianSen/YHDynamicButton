//
//  YHViewController.m
//  YHDynamicButton
//
//  Created by 1335430614@qq.com on 06/01/2020.
//  Copyright (c) 2020 1335430614@qq.com. All rights reserved.
//

#import "YHViewController.h"
#import <YHDynamicButton/YHDynamicButton.h>

@interface YHViewController ()

@end

@implementation YHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    YHDynamicButton *button = [YHDynamicButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:UIColor.redColor];
    [button setTitle:@"lalala" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeTitle:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 100, 50, 44);
    [self.view addSubview:button];
}
- (IBAction)changeTitle2:(UIButton *)sender {
    [self changeTitle:sender];
}

- (void)changeTitle:(UIButton *)btn {
    [btn setTitle:[NSString stringWithFormat:@"%@%@", btn.currentTitle, @"lalala"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

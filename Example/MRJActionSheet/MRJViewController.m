//
//  MRJViewController.m
//  MRJActionSheet
//
//  Created by mrjlovetian@gmail.com on 09/17/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJViewController.h"
#import <MRJActionSheet/MRJActionSheet.h>

@interface MRJViewController ()

@end

@implementation MRJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(69, 69, 169, 69);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"选择日期" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)click{
    MRJActionSheet *sheet = [[MRJActionSheet alloc] initWithTitle:@"标题" buttonTitles:@[@"第一", @"第二", @"第三", @"第四"] redButtonIndex:-1 defColor:nil actionSheetClickBlock:^(MRJActionSheet *actionSheet, int buttonIndex) {
    }];
    [sheet show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

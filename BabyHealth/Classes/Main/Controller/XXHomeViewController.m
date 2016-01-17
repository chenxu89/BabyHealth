//
//  XXHomeViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXFeedViewController.h"
#import "XXLifeViewController.h"
#import "XXBodyViewController.h"

@interface XXHomeViewController ()
@end

@implementation XXHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navSegmentedControl
    NSArray *arr = [NSArray arrayWithObjects:@"喂养情况", @"生活情况", @"体格记录", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    [segment setTintColor:HWTintColor];
    [segment addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;//选中第几个segment 一般用于初始化时选中
    self.navigationItem.titleView = segment;
    
    // XXFeedViewController
    XXFeedViewController *feedVc = [[XXFeedViewController alloc] init];
    [self addChildViewController:feedVc];
    [self.view addSubview:feedVc.view];
}

#pragma mark - 切换navSegmentedControl
- (void)selected:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
            HWLog(@"0");
            break;
        case 1:
            HWLog(@"1");
            break;
        case 2:
            HWLog(@"2");
            break;
            
        default:
            break;
    }
}





@end

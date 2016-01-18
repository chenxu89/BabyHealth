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

@property (nonatomic, assign) NSInteger fromIndex;

@end

@implementation XXHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    XXFeedViewController *feedVc = [[XXFeedViewController alloc] init];
    [self addChildViewController:feedVc];
    
    XXLifeViewController *lifeVc = [[XXLifeViewController alloc] init];
    [self addChildViewController:lifeVc];
    
    XXBodyViewController *bodyVc = [[XXBodyViewController alloc] init];
    [self addChildViewController:bodyVc];
    
    // 默认显示XXFeedViewController
    [self.view addSubview:feedVc.view];
    
    // navSegmentedControl
    NSArray *arr = [NSArray arrayWithObjects:@"喂养情况", @"生活情况", @"体格记录", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    [segment setTintColor:HWTintColor];
    [segment addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;//选中第几个segment 一般用于初始化时选中
    self.navigationItem.titleView = segment;
}

#pragma mark - 切换navSegmentedControl
- (void)selected:(UISegmentedControl *)segment{
    
    // 目标索引
    NSInteger toIndex = segment.selectedSegmentIndex;
    
    // 移除旧控制器的view
    XXBaseViewController *oldVc = self.childViewControllers[self.fromIndex];
//    [oldVc.view removeFromSuperview];
    
    // 显示新控制器的view
    XXBaseViewController *newVc = self.childViewControllers[segment.selectedSegmentIndex];
//    [self.view addSubview:newVc.view];
    
    // 动画切换两个view
    [UIView transitionFromView:oldVc.view toView:newVc.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
    //这个api 原理   ：
    //        1:[fromvalue.superview addSubview:tovalue];
    //        2:[fromvalue removeFromSuperview];
    
    // 重置之前索引
    self.fromIndex = toIndex;
}

@end

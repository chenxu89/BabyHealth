//
//  XXHomeViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXSliderCell.h"
#import <MJExtension.h>
#import "XXFeedRecord.h"
#import "XXBreastFeedFooterView.h"

NSString * const SliderCellIdentifier = @"SliderCellIdentifier";
NSString * const BreastFeedFooterViewIdentifier = @"BreastFeedFooterViewIdentifier";

@interface XXHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIView *ageSegment;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *feedRecords;
@end

@implementation XXHomeViewController

- (NSArray *)feedRecords
{
    if (!_feedRecords) {
        _feedRecords = [XXFeedRecord objectArrayWithFilename:@"feedRecords.plist"];
    }
    return _feedRecords;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ageSegment
    UIView *ageSegment = [[UIView alloc] init];
    ageSegment.backgroundColor = [UIColor purpleColor];
    ageSegment.frame = CGRectMake(0, 64, self.view.bounds.size.width, 44);
    [self.view addSubview:ageSegment];
    self.ageSegment = ageSegment;
    
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, CGRectGetMaxY(ageSegment.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(ageSegment.frame));
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    [self.view bringSubviewToFront:tableView];
    self.tableView = tableView;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XXSliderCell" bundle:nil] forCellReuseIdentifier:SliderCellIdentifier];
    
    // 注册FooterView
    [self.tableView registerNib:[UINib nibWithNibName:@"XXBreastFeedFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:BreastFeedFooterViewIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.feedRecords.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.feedRecords[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = self.feedRecords[indexPath.section];
    
    XXSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier forIndexPath:indexPath];
    
    cell.feedRecord = rows[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2 == 1) {
//        cell.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
//    }
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - 自定义的FooterView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        XXBreastFeedFooterView *footer = (XXBreastFeedFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:BreastFeedFooterViewIdentifier];
        return footer;
    }else{
        return nil;
    }
}

#pragma mark - FooterView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else{
        return 0;
    }
    
}

@end

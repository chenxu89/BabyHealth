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

static NSString * const SliderCellIdentifier = @"SliderCellIdentifier";
static NSString * const BreastFeedFooterViewIdentifier = @"BreastFeedFooterViewIdentifier";

@interface XXHomeViewController () <UITableViewDataSource, UITableViewDelegate, XXBreastFeedFooterViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *feedRecords;

@property (nonatomic, assign, getter=isStopBreastFeed) BOOL stopBreastFeed;// 是否母乳喂养
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
    
    // ageSegmentedControl
    self.ageSegmentedControl = [[RS3DSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _ageSegmentedControl.delegate = self;
    _ageSegmentedControl.backgroundColor = HWTintColor;
    [self.view addSubview:_ageSegmentedControl];
    
    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, CGRectGetMaxY(_ageSegmentedControl.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_ageSegmentedControl.frame));
    
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
    
    // 断母乳就隐藏section0的所有cell
    if (indexPath.section == 0) {
        if (self.isStopBreastFeed) {
//            cell.userInteractionEnabled = NO;
//            [UIView animateWithDuration:0.5 animations:^{
//                cell.backgroundColor = [UIColor grayColor];
//            }];
                cell.hidden = YES;
        }else{
//            cell.userInteractionEnabled = YES;
//            [UIView animateWithDuration:0.5 animations:^{
//                cell.backgroundColor = [UIColor whiteColor];
//            }];
                cell.hidden = NO;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2 == 1) {
//        cell.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
//    }
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 断母乳就隐藏section0的所有cell
    if (indexPath.section == 0) {
        if (self.isStopBreastFeed) {
            return 0;
        }else{
            return 80;
        }
    }
    return 80;
}

#pragma mark - 自定义的FooterView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        XXBreastFeedFooterView *footer = (XXBreastFeedFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:BreastFeedFooterViewIdentifier];
        footer.delegate = self;
        footer.tag = section;
        footer.stopBreastFeedBtn.selected = self.stopBreastFeed;
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

#pragma mark - FooterView的delegate，点击断母乳按钮
- (void)breastFeedFooterView:(XXBreastFeedFooterView *)footerView didClickStopBreastFeedButton:(UIButton *)btn{
    
    self.stopBreastFeed = !self.stopBreastFeed;

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //    [self.tableView reloadData];
}

#pragma mark - RS3DSegmentedControlDelegate
- (NSUInteger)numberOfSegmentsIn3DSegmentedControl:(RS3DSegmentedControl *)segmentedControl
{
    return 8;
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)segmentIndex segmentedControl:(RS3DSegmentedControl *)segmentedControl
{
    switch (segmentIndex) {
        case 0:
            return @"一月";
        case 1:
            return @"二月";
        case 2:
            return @"四月";
        case 3:
            return @"六月";
        case 4:
            return @"九月";
        case 5:
            return @"一岁";
        case 6:
            return @"一岁半";
        case 7:
            return @"二岁";
            
        default:
            return @"六月";
    }
}


- (void)didSelectSegmentAtIndex:(NSUInteger)segmentIndex segmentedControl:(RS3DSegmentedControl *)segmentedControl
{
}


@end

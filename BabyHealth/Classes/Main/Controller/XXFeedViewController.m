//
//  XXFeedViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXFeedViewController.h"
#import "XXSliderCell.h"
#import <MJExtension.h>
#import "XXFeedRecord.h"
#import "XXBreastFeedFooterView.h"

static NSString * const SliderCellIdentifier = @"SliderCellIdentifier";
static NSString * const BreastFeedFooterViewIdentifier = @"BreastFeedFooterViewIdentifier";

@interface XXFeedViewController ()<XXBreastFeedFooterViewDelegate>

@property (nonatomic, strong) NSArray *feedRecords;
@property (nonatomic, assign, getter=isStopBreastFeed) BOOL stopBreastFeed;// 是否母乳喂养
@end

@implementation XXFeedViewController

- (NSArray *)feedRecords
{
    if (!_feedRecords) {
        _feedRecords = [XXFeedRecord objectArrayWithFilename:@"feedRecords.plist"];
    }
    return _feedRecords;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XXSliderCell" bundle:nil] forCellReuseIdentifier:SliderCellIdentifier];
    
    // 注册FooterView
    [self.tableView registerNib:[UINib nibWithNibName:@"XXBreastFeedFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:BreastFeedFooterViewIdentifier];
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


@end

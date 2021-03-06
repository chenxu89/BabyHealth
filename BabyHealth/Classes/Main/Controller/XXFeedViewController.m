//
//  XXFeedViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXFeedViewController.h"
#import "XXBreastFeedFooterView.h"


static NSString * const BreastFeedFooterViewIdentifier = @"BreastFeedFooterViewIdentifier";

@interface XXFeedViewController ()<XXBreastFeedFooterViewDelegate>

@property (nonatomic, strong) NSArray *feedRecords;
@property (nonatomic, assign, getter=isStopBreastFeed) BOOL stopBreastFeed;// 是否母乳喂养
@end

@implementation XXFeedViewController

- (NSArray *)feedRecords
{
    if (!_feedRecords) {
        _feedRecords = [XXRecord objectArrayWithFilename:@"feedRecords.plist"];
    }
    return _feedRecords;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    // 模型数据
    NSArray *rows = self.feedRecords[indexPath.section];
    XXRecord *record = rows[indexPath.row];
    
    if (record.cellStyle == XXRecordCellStyleSlide) {// slider cell
        XXSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier forIndexPath:indexPath];
        cell.record = record;
        [self setupStopBreastFeed:indexPath cell:cell];
        return cell;
        
    }else{// check cell
        XXCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckCellIdentifier forIndexPath:indexPath];
        cell.record = record;
        [self setupStopBreastFeed:indexPath cell:cell];
        
        return cell;
    }
}

#pragma mark - 断母乳就隐藏section0的所有cell
- (void)setupStopBreastFeed:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell{
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
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 断母乳就隐藏section0的所有cell
    if (indexPath.section == 0) {
        if (self.isStopBreastFeed) {
            return 0;
        }
    }
    
    // 模型数据
    NSArray *rows = self.feedRecords[indexPath.section];
    XXRecord *record = rows[indexPath.row];
    if (record.cellStyle == XXRecordCellStyleSlide) {
        return 80;
    }else{
        return 60;
    }
    
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//        if (indexPath.row % 2 == 1) {
//            cell.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1.0];
//        }
//}

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

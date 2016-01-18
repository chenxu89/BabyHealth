//
//  XXBaseViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXBaseViewController.h"

@interface XXBaseViewController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation XXBaseViewController

- (NSArray *)records
{
    if (!_records) {
        _records = [[NSArray alloc] init];
    }
    return _records;
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
    
    // 注册XXSliderCell
    [self.tableView registerNib:[UINib nibWithNibName:@"XXSliderCell" bundle:nil] forCellReuseIdentifier:SliderCellIdentifier];
    
    // 注册XXCheckCell
    [self.tableView registerClass:[XXCheckCell class] forCellReuseIdentifier:CheckCellIdentifier];    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.records.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.records[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 模型数据
    NSArray *rows = self.records[indexPath.section];
    XXRecord *record = rows[indexPath.row];
    
    if (record.cellStyle == XXRecordCellStyleSlide) {// slider cell
        XXSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier forIndexPath:indexPath];
        cell.record = record;
        return cell;
        
    }else{// check cell
        XXCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckCellIdentifier forIndexPath:indexPath];
        cell.record = record;
        
        return cell;
    }
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 模型数据
    NSArray *rows = self.records[indexPath.section];
    XXRecord *record = rows[indexPath.row];
    if (record.cellStyle == XXRecordCellStyleSlide) {
        return 80;
    }else{
        return 60;
    }
}

@end

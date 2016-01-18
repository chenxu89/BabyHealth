//
//  XXBodyViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXBodyViewController.h"

@interface XXBodyViewController ()
@property (nonatomic, strong) NSArray *bodyRecords;
@end

@implementation XXBodyViewController

- (NSArray *)bodyRecords
{
    if (!_bodyRecords) {
        _bodyRecords = [XXRecord objectArrayWithFilename:@"bodyRecords.plist"];
    }
    return _bodyRecords;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bodyRecords.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.bodyRecords[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = self.bodyRecords[indexPath.section];
    
    XXSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier forIndexPath:indexPath];
    
    cell.record = rows[indexPath.row];
    
    return cell;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


@end

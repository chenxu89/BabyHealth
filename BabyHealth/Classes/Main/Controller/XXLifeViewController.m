//
//  XXLifeViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXLifeViewController.h"

@interface XXLifeViewController ()
@property (nonatomic, strong) NSArray *lifeRecords;
@end

@implementation XXLifeViewController

- (NSArray *)lifeRecords
{
    if (!_lifeRecords) {
        _lifeRecords = [XXRecord objectArrayWithFilename:@"lifeRecords.plist"];
    }
    return _lifeRecords;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.lifeRecords.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.lifeRecords[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = self.lifeRecords[indexPath.section];
    
    XXSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:SliderCellIdentifier forIndexPath:indexPath];
    
    cell.feedRecord = rows[indexPath.row];
    
    return cell;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}



@end

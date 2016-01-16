//
//  XXHomeViewController.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXSliderCell.h"

@interface XXHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIView *ageSegment;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation XXHomeViewController

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
    [tableView registerNib:[UINib nibWithNibName:@"XXSliderCell" bundle:nil] forCellReuseIdentifier:@"SliderCell"];// 注册cell
    [self.view addSubview:tableView];
    [self.view bringSubviewToFront:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SliderCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    }
}


@end

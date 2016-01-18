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

    self.records = self.bodyRecords;
}

@end

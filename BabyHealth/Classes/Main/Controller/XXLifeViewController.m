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
    
    self.records = self.lifeRecords;
}





@end

//
//  XXBaseViewController.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RS3DSegmentedControl.h>
#import <MJExtension.h>
#import "XXSliderCell.h"
#import "XXRecord.h"

static NSString * const SliderCellIdentifier = @"SliderCellIdentifier";

@interface XXBaseViewController : UIViewController <RS3DSegmentedControlDelegate>

@property(nonatomic,strong) RS3DSegmentedControl *ageSegmentedControl;

@property (nonatomic, weak) UITableView *tableView;
@end

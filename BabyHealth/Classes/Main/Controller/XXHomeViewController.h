//
//  XXHomeViewController.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RS3DSegmentedControl.h>

@interface XXHomeViewController : UIViewController<RS3DSegmentedControlDelegate>
@property(nonatomic,strong) RS3DSegmentedControl *ageSegmentedControl;
@end

//
//  XXCheckCell.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/18.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const CheckCellIdentifier = @"CheckCellIdentifier";

@class XXRecord;
@interface XXCheckCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) XXRecord *record;

@end

//
//  XXSliderCell.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASValueTrackingSlider.h>
@class XXRecord;
@interface XXSliderCell : UITableViewCell <ASValueTrackingSliderDelegate>
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *slider;

/**
 *  数据模型
 */
@property (nonatomic, strong) XXRecord *record;
@end

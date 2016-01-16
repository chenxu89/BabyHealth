//
//  XXSliderCell.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASValueTrackingSlider.h"

@interface XXSliderCell : UITableViewCell <ASValueTrackingSliderDelegate>
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *slider;

@end

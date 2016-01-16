//
//  XXSliderCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXSliderCell.h"

@implementation XXSliderCell

- (void)awakeFromNib
{
    self.slider.delegate = self;
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;
{
    [self.superview bringSubviewToFront:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  XXSliderCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXSliderCell.h"

@interface XXSliderCell ()
@property (weak, nonatomic) IBOutlet UILabel *realLabel;

@end

@implementation XXSliderCell

- (void)awakeFromNib
{
    self.slider.delegate = self;
    
    // customize slider 1
    self.slider.minimumValue = 100.0;// 最大值
    self.slider.maximumValue = 255.0;// 最小值
    self.slider.popUpViewCornerRadius = 5.0;// 弹窗圆角
    [self.slider setMaxFractionDigitsDisplayed:0];// 小数位数
    self.slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];// 弹窗颜色
    self.slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];// 弹窗文字字体
    self.slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];// 弹窗文字颜色
    self.slider.popUpViewWidthPaddingFactor = 1.7;
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;
{
    [self.superview bringSubviewToFront:self];
}

- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider
{
    self.realLabel.text = [NSString stringWithFormat:@"%0.2f", slider.value];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

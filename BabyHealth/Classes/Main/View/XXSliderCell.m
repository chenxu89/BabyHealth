//
//  XXSliderCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXSliderCell.h"
#import "XXFeedRecord.h"

@interface XXSliderCell ()
@property (weak, nonatomic) IBOutlet UILabel *mainKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *realLabel;

@end

@implementation XXSliderCell

- (void)awakeFromNib
{
    self.slider.delegate = self;
    
    // customize slider
    self.slider.popUpViewCornerRadius = 5.0;// 弹窗圆角
    self.slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];// 弹窗文字字体
    self.slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];// 弹窗文字颜色
    self.slider.thumbTintColor = HWTintColor;// thumb的颜色
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;
{
    [self.superview bringSubviewToFront:self];
}

- (void)setFeedRecord:(XXFeedRecord *)feedRecord{
    _feedRecord = feedRecord;
    
    
    self.slider.minimumValue = feedRecord.minimumValue;// 最小值
    self.slider.maximumValue = feedRecord.maximumValue;// 最大值
    self.slider.value = feedRecord.realValue; // thumb初始位置
    [self.slider setMaxFractionDigitsDisplayed:feedRecord.fractionDigits];// 小数位数
    
    self.mainKeyLabel.text = [NSString stringWithFormat:@"%@ %@", feedRecord.mainKey, feedRecord.subKey];
    self.unitLabel.text = feedRecord.unit;
    self.realLabel.text = [NSString stringWithFormat:@"%0.0f", feedRecord.realValue];
    
    [self setupSliderColorSections:feedRecord];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 拖动slider的时候，
- (IBAction)dragSlider:(ASValueTrackingSlider *)slider {
    
    self.realLabel.text = [NSString stringWithFormat:@"%0.0f", slider.value];
    
    [self setupSliderColorSections:self.feedRecord];
}

/**
 *  根据slider.value的值，设置slider左边条和弹窗背景色分 红黄绿黄红 显示
 *
 *  @param feedRecord 数据模型
 */
- (void)setupSliderColorSections:(XXFeedRecord *)feedRecord{
    
    UIColor *red = [UIColor redColor];
    UIColor *yellow = [UIColor yellowColor];
    UIColor *green = [UIColor greenColor];
    if (self.slider.value < [feedRecord.colorSections[0] floatValue]) {
        
        [self.slider setPopUpViewColor:red];
        self.slider.minimumTrackTintColor = red;
    }else if (self.slider.value < [feedRecord.colorSections[1] floatValue]){
        
        [self.slider setPopUpViewColor:yellow];
        self.slider.minimumTrackTintColor = yellow;
    }else if (self.slider.value < [feedRecord.colorSections[2] floatValue]){
        
        [self.slider setPopUpViewColor:green];
        self.slider.minimumTrackTintColor = green;
    }else if (self.slider.value < [feedRecord.colorSections[3] floatValue]){
        
        [self.slider setPopUpViewColor:yellow];
        self.slider.minimumTrackTintColor = yellow;
    }else{
        
        [self.slider setPopUpViewColor:red];
        self.slider.minimumTrackTintColor = red;
    }
}

@end

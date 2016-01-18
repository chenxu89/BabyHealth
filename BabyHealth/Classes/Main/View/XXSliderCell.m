//
//  XXSliderCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXSliderCell.h"
#import "XXRecord.h"

@interface XXSliderCell ()
@property (weak, nonatomic) IBOutlet UILabel *mainKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *realLabel;

#define XXSliderCellTextColor [UIColor whiteColor]
@end

@implementation XXSliderCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        // cell选中时候不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    }

    return self;
}

- (void)awakeFromNib
{
    self.slider.delegate = self;
    
    // customize slider
    self.slider.popUpViewCornerRadius = 5.0;// 弹窗圆角
    self.slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];// 弹窗文字字体
    self.slider.textColor = [UIColor whiteColor];// 弹窗文字颜色
   
    
    [self.unitLabel sizeToFit];
    [self.mainKeyLabel sizeToFit];

    // 颜色
    
    self.mainKeyLabel.textColor = XXSliderCellTextColor;
    self.realLabel.textColor = XXSliderCellTextColor;
    self.unitLabel.textColor = XXSliderCellTextColor;
    self.slider.thumbTintColor = XXSliderCellTextColor;// 圆球的颜色
    self.slider.popUpViewColor = XXSliderCellTextColor;// 弹窗的背景颜色

    // 设置thumb图片
//    UIImage *thumbImage = [UIImage originImage:[UIImage imageNamed:@"slider_thumb"] scaleToSize:CGSizeMake(20, 20)];
//    [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
//    [self.slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;
{
    [self.superview bringSubviewToFront:self];
}

- (void)setRecord:(XXRecord *)record{
    _record = record;
    
    XXRecordValue *recordValue = record.recordValue;
    
    self.slider.minimumValue = recordValue.minimumValue;// 最小值
    self.slider.maximumValue = recordValue.maximumValue;// 最大值
    self.slider.minimumTrackTintColor = [UIColor whiteColor];
    
    self.slider.value = recordValue.realValue; // thumb初始位置
    
    [self.slider setMaxFractionDigitsDisplayed:record.fractionDigits];// 小数位数
    
    self.mainKeyLabel.text = [NSString stringWithFormat:@"%@ %@", record.mainKey, record.subKey];
    self.unitLabel.text = record.unit;
    
    self.realLabel.text = [NSString stringWithFormat:@"%0.0f", recordValue.realValue];
    
    [self setupSliderColorSections:recordValue];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 拖动slider的时候
- (IBAction)dragSlider:(ASValueTrackingSlider *)slider {

    self.realLabel.text = [NSString stringWithFormat:@"%0.0f", slider.value];
    
    // 设置realValue
    self.record.recordValue.realValue = slider.value;
    
    [self setupSliderColorSections:self.record.recordValue];
    
    HWLog(@"%@", NSStringFromCGRect(self.slider.frame));
}

/**
 *  根据slider.value的值，设置slider左边条和弹窗背景色分 红黄绿黄红 显示
 *
 *  @param record 数据模型
 */
- (void)setupSliderColorSections:(XXRecordValue *)recordValue{
    
    UIColor *green = [UIColor colorWithHue:0.3 saturation:0.65 brightness:0.8 alpha:1.0];
//    UIColor *yellow = [UIColor colorWithHue:0.15 saturation:0.9 brightness:0.9 alpha:1.0];
    UIColor *yellow = [UIColor orangeColor];
    UIColor *red = [UIColor colorWithHue:0.0 saturation:0.8 brightness:1.0 alpha:1.0];
    
    UIColor *tintColor;
    // slider左边在滑动时候会变色
    if (self.slider.value <= recordValue.dangerLessValue) {
        tintColor = red;
    }else if (self.slider.value <= recordValue.warningLessValue){
        tintColor = yellow;
    }else if (self.slider.value <= recordValue.normalValue){
        tintColor = green;
    }else if (self.slider.value <= recordValue.warningMoreValue){
        tintColor = yellow;
    }else{
        tintColor = red;
    }
    
    // cell中各种label文字颜色
//    self.mainKeyLabel.textColor = tintColor;
//    self.realLabel.textColor = tintColor;
//    self.unitLabel.textColor = tintColor;
    
    // cell中thumb颜色
//    self.slider.thumbTintColor = tintColor;
    
    // cell的背景颜色
    self.backgroundColor = tintColor;
    
    // cell的右边的颜色
    self.slider.maximumTrackTintColor = tintColor;
    
    // popUpView的文字颜色
    self.slider.textColor = tintColor;
}


@end

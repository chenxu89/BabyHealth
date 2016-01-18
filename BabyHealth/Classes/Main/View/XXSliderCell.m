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

@end

@implementation XXSliderCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        // cell选中时候不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;
}

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

- (void)setRecord:(XXRecord *)record{
    _record = record;
    
    XXRecordValue *recordValue = record.recordValue;
    
    self.slider.minimumValue = recordValue.minimumValue;// 最小值
    self.slider.maximumValue = recordValue.maximumValue;// 最大值
    
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
}

/**
 *  根据slider.value的值，设置slider左边条和弹窗背景色分 红黄绿黄红 显示
 *
 *  @param record 数据模型
 */
- (void)setupSliderColorSections:(XXRecordValue *)recordValue{
    
    UIColor *green = [UIColor colorWithHue:0.3 saturation:0.65 brightness:0.8 alpha:1.0];
    UIColor *yellow = [UIColor colorWithHue:0.15 saturation:0.9 brightness:0.9 alpha:1.0];
    UIColor *red = [UIColor colorWithHue:0.0 saturation:0.8 brightness:1.0 alpha:1.0];
    
    // slider左边在滑动时候会变色
    if (self.slider.value <= recordValue.dangerLessValue) {
        
        [self.slider setPopUpViewColor:red];
        self.slider.minimumTrackTintColor = red;
    }else if (self.slider.value <= recordValue.warningLessValue){
        
        [self.slider setPopUpViewColor:yellow];
        self.slider.minimumTrackTintColor = yellow;
    }else if (self.slider.value <= recordValue.normalValue){
        
        [self.slider setPopUpViewColor:green];
        self.slider.minimumTrackTintColor = green;
    }else if (self.slider.value <= recordValue.warningMoreValue){
        
        [self.slider setPopUpViewColor:yellow];
        self.slider.minimumTrackTintColor = yellow;
    }else{
        
        [self.slider setPopUpViewColor:red];
        self.slider.minimumTrackTintColor = red;
    }
    
    
    // cell中各种label也跟着变色
    self.mainKeyLabel.textColor = self.slider.minimumTrackTintColor;
    self.realLabel.textColor = self.slider.minimumTrackTintColor;
    self.unitLabel.textColor = self.slider.minimumTrackTintColor;
}


@end

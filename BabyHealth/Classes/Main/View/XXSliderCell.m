//
//  XXSliderCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXSliderCell.h"
#import "XXFeedRecord.h"

@interface XXSliderCell ()<ASValueTrackingSliderDataSource>
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

- (void)setFeedRecord:(XXFeedRecord *)feedRecord{
    _feedRecord = feedRecord;
    
    XXRecordValue *recordValue = feedRecord.recordValue;
    
    self.slider.minimumValue = recordValue.minimumValue;// 最小值
    self.slider.maximumValue = recordValue.maximumValue;// 最大值
    
    self.slider.value = recordValue.realValue; // thumb初始位置
    
    [self.slider setMaxFractionDigitsDisplayed:feedRecord.fractionDigits];// 小数位数
    
    self.mainKeyLabel.text = [NSString stringWithFormat:@"%@ %@", feedRecord.mainKey, feedRecord.subKey];
    self.unitLabel.text = feedRecord.unit;
    
    if (feedRecord.custom) {// 如果是定制数字内容
        self.slider.dataSource = self;
        self.realLabel.text = [self slider:self.slider stringForValue:recordValue.realValue];
    }else{// 如果不是定制数字内容
        self.realLabel.text = [NSString stringWithFormat:@"%0.0f", recordValue.realValue];
    }
    
    [self setupSliderColorSections:recordValue];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 拖动slider的时候
- (IBAction)dragSlider:(ASValueTrackingSlider *)slider {
    
    if (self.feedRecord.custom) {// 如果是需要定制数字内容
        self.realLabel.text = [self slider:self.slider stringForValue:slider.value];
    }else{
        self.realLabel.text = [NSString stringWithFormat:@"%0.0f", slider.value];
    }
    
    // 设置realValue
    self.feedRecord.recordValue.realValue = slider.value;
    
    [self setupSliderColorSections:self.feedRecord.recordValue];
}

/**
 *  根据slider.value的值，设置slider左边条和弹窗背景色分 红黄绿黄红 显示
 *
 *  @param feedRecord 数据模型
 */
- (void)setupSliderColorSections:(XXRecordValue *)recordValue{
    
    UIColor *red = [UIColor redColor];
    UIColor *yellow = [UIColor yellowColor];
    UIColor *green = [UIColor greenColor];
    
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
}

#pragma mark - ASValueTrackingSliderDataSource

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    XXRecordValue *recordValue = self.feedRecord.recordValue;
    NSString *s;
    if (value <= recordValue.dangerLessValue) {
        s = @"少";
    } else if (value <= recordValue.normalValue) {
        s = @"中";
    } else {
        s = @"多";
    }
    
    return s;
}

@end

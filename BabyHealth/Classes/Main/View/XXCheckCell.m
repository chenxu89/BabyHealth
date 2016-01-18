//
//  XXCheckCell.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/18.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXCheckCell.h"
#import "XXRecord.h"
#import "DLRadioButton.h"

@interface XXCheckCell ()

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *checkBtns;
/** 第一个btn */
@property (nonatomic, strong) DLRadioButton *firstBtn;


@end

@implementation XXCheckCell

- (NSMutableArray *)checkBtns
{
    if (!_checkBtns) {
        _checkBtns = [[NSMutableArray alloc] init];
    }
    return _checkBtns;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化titleLabel
        [self setupTitle];
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{

    XXCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckCellIdentifier forIndexPath:indexPath];
    return cell;
}

/**
 *  初始化titleLabel
 */
- (void)setupTitle{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = HWTintColor;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)setRecord:(XXRecord *)record{
    _record = record;
    
    
    
    // titleLabel
    self.titleLabel.text = record.title;
    
    // 单选按钮
    [self setupSingleSelectedBtn:record];
}

/**
 *  初始化单选按钮
 *
 *  @param count 按钮数量
 */
- (void)setupSingleSelectedBtn:(XXRecord *)record{
    NSUInteger count = record.options.count;
    
    NSMutableArray *otherButtons = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < count; i++) {
        
        DLRadioButton *btn = [[DLRadioButton alloc] init];
        
        /** btn的一次性属性 */
        btn.backgroundColor = [UIColor clearColor]; // 必须设置，否则btn不显示
        btn.titleLabel.font = XXCheckCellTitleFont;
        [btn setTitle:record.options[i] forState:UIControlStateNormal];
        [btn setTitleColor:HWTintColor forState:UIControlStateNormal];
        btn.iconColor = HWTintColor; // icon外边圆圈的颜色，默认为TitleColor
        btn.indicatorColor = HWTintColor; // icon中间实心点的颜色，默认为TitleColor
        btn.iconOnRight = YES; // icon是否在右边
        btn.marginWidth = 5; // 文字和icon的间距
        btn.iconSize = 15; // icon的直径
        btn.iconSquare = NO;// icon是否为方形，默认为NO即圆形
        [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // 确定一个firstBtn，将其他btn放入它的组中管理，这样可以实现单选
        if (i == 0) {
            self.firstBtn = btn;
        }else{
            [otherButtons addObject:btn];
        }
        self.firstBtn.otherButtons = otherButtons;
        
        [self.contentView addSubview:btn];
        [self.checkBtns addObject:btn];
    }
}

- (void)selectButton:(DLRadioButton *)btn{
    
}

// 计算子控件的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    
    XXRecord *record = self.record;
    NSUInteger count = record.options.count;
    
    // titleLabel
    CGSize titleSize = [record.title sizeWithFont:XXCheckCellTitleFont];
    CGFloat titleX = 10;
    CGFloat titleY = (self.height - titleSize.height) * 0.5;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    // 单选按钮
    CGFloat btnTitleMargin = 20; // title和第一个btn的间距
    CGFloat btnMargin = 10; // btn之间的间距
    for (NSUInteger i = 0; i < count; i++) {
        
        DLRadioButton *btn = self.checkBtns[i];
        
        // 文字的大小由其内容和字体决定
        CGSize btnTextSize = [record.options[i] sizeWithFont:XXCheckCellOptionFont];
        CGFloat btnW = btnTextSize.width + btn.iconSize + btn.marginWidth;
        CGFloat btnH = btnTextSize.height;
        CGFloat btnX = CGRectGetMaxX(self.titleLabel.frame) + btnTitleMargin + (btnW + btnMargin) * i;
        CGFloat btnY = (self.height - btnH) * 0.5;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


@end

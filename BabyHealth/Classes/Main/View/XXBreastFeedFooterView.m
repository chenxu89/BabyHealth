//
//  XXBreastFeedFooterView.m
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import "XXBreastFeedFooterView.h"

@interface XXBreastFeedFooterView () 
@property (weak, nonatomic) IBOutlet UIButton *stopBreastFeedBtn;

@end

@implementation XXBreastFeedFooterView

- (void)awakeFromNib {
    [self.stopBreastFeedBtn setTitle:@"NO" forState:UIControlStateNormal];
    [self.stopBreastFeedBtn setTitle:@"YES" forState:UIControlStateSelected];
}
- (IBAction)stopBreastFeed:(UIButton *)btn {
    btn.selected = !btn.selected;
    
}


@end

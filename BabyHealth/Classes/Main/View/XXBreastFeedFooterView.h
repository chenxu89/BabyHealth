//
//  XXBreastFeedFooterView.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBreastFeedFooterView;

@protocol XXBreastFeedFooterViewDelegate <NSObject>

@optional
- (void)breastFeedFooterView:(XXBreastFeedFooterView *)footerView didClickStopBreastFeedButton:(UIButton *)btn;

@end

@interface XXBreastFeedFooterView : UITableViewHeaderFooterView
@property (nonatomic, weak) id<XXBreastFeedFooterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *stopBreastFeedBtn;
@end

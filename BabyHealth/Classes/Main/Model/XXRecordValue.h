//
//  XXRecordValue.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/17.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXRecordValue : NSObject

@property (nonatomic, assign) CGFloat realValue;
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;

@property (nonatomic, assign) CGFloat dangerLessValue;
@property (nonatomic, assign) CGFloat warningLessValue;
@property (nonatomic, assign) CGFloat normalValue;
@property (nonatomic, assign) CGFloat warningMoreValue;

@end

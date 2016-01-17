//
//  XXFeedRecord.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXFeedRecord : NSObject

@property (nonatomic, copy) NSString *mainKey;
@property (nonatomic, copy) NSString *subKey;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;
@property (nonatomic, assign) CGFloat realValue;
@property (nonatomic, assign) NSUInteger fractionDigits;
@property (nonatomic, strong) NSArray *colorSections;


@end

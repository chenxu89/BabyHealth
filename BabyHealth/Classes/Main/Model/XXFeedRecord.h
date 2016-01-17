//
//  XXFeedRecord.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRecordValue.h"

@interface XXFeedRecord : NSObject

@property (nonatomic, copy) NSString *mainKey;
@property (nonatomic, copy) NSString *subKey;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) NSUInteger fractionDigits;
@property (nonatomic, assign, getter=isCustom) BOOL custom;
@property (nonatomic, strong) XXRecordValue *recordValue;


@end

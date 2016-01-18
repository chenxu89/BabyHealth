//
//  XXRecord.h
//  BabyHealth
//
//  Created by 陈旭 on 16/1/16.
//  Copyright © 2016年 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRecordValue.h"


#define XXCheckCellTitleFont [UIFont systemFontOfSize:17]
#define XXCheckCellOptionFont [UIFont systemFontOfSize:17]

typedef enum{
    XXRecordCellStyleSlide,
    XXRecordCellStyleCheck
}XXRecordCellStyle;

@interface XXRecord : NSObject

//判断cell类型
@property (nonatomic, assign) XXRecordCellStyle cellStyle;

//slider类型
@property (nonatomic, copy) NSString *mainKey;
@property (nonatomic, copy) NSString *subKey;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) NSUInteger fractionDigits;
@property (nonatomic, strong) XXRecordValue *recordValue;

//check类型
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;

@end

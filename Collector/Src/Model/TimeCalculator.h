//
//  TimeCalculator.h
//  Collector
//
//  Created by Yeehok on 2016/11/14.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeCalculator : NSObject

+ (instancetype)getInstance;

- (NSDate *)getCurrentTime;

- (NSString *)stringFromDate:(NSDate *)date;

- (NSDate *)dateFromString:(NSString *)string;

@end

//
//  TimeCalculator.m
//  Collector
//
//  Created by Yeehok on 2016/11/14.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "TimeCalculator.h"

@interface TimeCalculator ()

@property (nonatomic, strong) NSTimeZone *localZone;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TimeCalculator

static TimeCalculator *instance;

+ (instancetype)getInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[self alloc] initPrivate];
    });
    return instance;
}

- (instancetype)init {
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd"];
    }
    
    return self;
}

#pragma mark Inner interface

- (void)resetTimeZone {
    self.localZone = [NSTimeZone systemTimeZone];
}

#pragma mark Interface

- (NSDate *)getCurrentTime {
    [self resetTimeZone];
    NSDate *date = [NSDate date];
    NSInteger interval = [self.localZone secondsFromGMTForDate:date];
    self.date = [date dateByAddingTimeInterval:interval];
    return self.date;
}

- (NSString *)stringFromDate:(NSDate *)date {
    return [self.dateFormatter stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)string {
    return [self.dateFormatter dateFromString:string];
}

@end

//
//  NSDate+MCExtensions.h
//  MCDateExtensions.iOS
//
//  Created by Simon Audet on 10-10-12.
//  Copyright (c) 2012 Mirego Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (MCExtensions)

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
- (BOOL)isSameDayAsDate:(NSDate*)date;
- (NSDate *)dateAtMidnight;

- (NSDateComponents *)componentsWithUnits:(NSUInteger)units;
- (NSDateComponents *)components;

- (NSDate *)firstOfMonth;
- (NSDate *)firstOfWeek;

- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

@end

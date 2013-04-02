//
//  NSDate+MCExtensions.m
//  MCDateExtensions.iOS
//
//  Created by Simon Audet on 10-10-12.
//  Copyright (c) 2012 Mirego Inc. All rights reserved.
//

#import "NSDate+MCExtensions.h"

@implementation NSDate (MCExtensions)

- (BOOL)isToday
{
    return [self isSameDayAsDate:[NSDate date]];
}

- (BOOL)isYesterday
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:[components day]-1];    
    return [self isSameDayAsDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

- (BOOL)isTomorrow
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:[components day]+1];
    return [self isSameDayAsDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

- (NSDate *)dateAtMidnight
{
    NSCalendar* calendar = [NSCalendar currentCalendar];    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    
    return [calendar dateFromComponents:comp1];
}

- (NSDateComponents *)components
{
    return [self componentsWithUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit];
}

- (NSDateComponents *)componentsWithUnits:(NSUInteger)units
{
    NSCalendar* calendar = [NSCalendar currentCalendar];    
    return [calendar components:units fromDate:self];
}

- (NSDate*) firstOfMonth {
    NSDateComponents* components = [self componentsWithUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit];    
    [components setDay:1];        
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)firstOfWeek
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ([weekdayComponents weekday] - [gregorian firstWeekday])];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:beginningOfWeek];
    return [gregorian dateFromComponents:components];
}

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    return [self dateByAddingCalendarUnit:NSYearCalendarUnit value:years];
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return [self dateByAddingCalendarUnit:NSQuarterCalendarUnit value:quarters];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    return [self dateByAddingCalendarUnit:NSMonthCalendarUnit value:months];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return [self dateByAddingCalendarUnit:NSWeekCalendarUnit value:weeks];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingCalendarUnit:NSDayCalendarUnit value:days];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    return [self dateByAddingCalendarUnit:NSHourCalendarUnit value:hours];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return [self dateByAddingCalendarUnit:NSMinuteCalendarUnit value:minutes];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return [self dateByAddingCalendarUnit:NSSecondCalendarUnit value:seconds];
}

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value
{
    NSDateComponents *components = [self componentsWithUnits:0];
    [components setCalendar:[NSCalendar currentCalendar]];
    
    switch (calendarUnit) {
        case NSYearCalendarUnit:
            [components setYear:value];
            break;
            
        case NSQuarterCalendarUnit:
            [components setQuarter:value];
            break;
            
        case NSMonthCalendarUnit:
            [components setMonth:value];
            break;
            
        case NSWeekCalendarUnit:
            [components setWeek:value];
            break;
            
        case NSDayCalendarUnit:
            [components setDay:value];
            break;
            
        case NSHourCalendarUnit:
            [components setHour:value];
            break;
            
        case NSMinuteCalendarUnit:
            [components setMinute:value];
            break;
            
        case NSSecondCalendarUnit:
            [components setSecond:value];
            break;
            
        default:
            NSAssert(NO, @"Unsupported calendarUnit");
            break;
    }
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    return date;
}

+ (NSDateComponents *)differenceInCalendarUnit:(NSCalendarUnit)calendarUnit betweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *fromDate, *toDate;
    [calendar rangeOfUnit:calendarUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:calendarUnit startDate:&toDate interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:calendarUnit fromDate:fromDate toDate:toDate options:0];
    return difference;
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSDateComponents *difference = [self differenceInCalendarUnit:NSDayCalendarUnit betweenDate:fromDateTime andDate:toDateTime];
    return [difference day];
}

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSDateComponents *difference = [self differenceInCalendarUnit:NSWeekCalendarUnit betweenDate:fromDateTime andDate:toDateTime];
    return [difference week];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSDateComponents *difference = [self differenceInCalendarUnit:NSMonthCalendarUnit betweenDate:fromDateTime andDate:toDateTime];
    return [difference month];
}

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSDateComponents *difference = [self differenceInCalendarUnit:NSYearCalendarUnit betweenDate:fromDateTime andDate:toDateTime];
    return [difference year];
}

@end

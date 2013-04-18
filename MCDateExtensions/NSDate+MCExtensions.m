//
//  NSDate+MCExtensions.m
//  MCDateExtensions.iOS
//
//  Created by Simon Audet on 10-10-12.
//  Copyright (c) 2012 Mirego Inc. All rights reserved.
//

#import "NSDate+MCExtensions.h"

@implementation NSDate (MCExtensions)

static NSCalendar *mcCurrentCalendarCache = nil;

+ (NSCalendar *)mcCurrentCalendar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mcCurrentCalendarCache = [NSCalendar currentCalendar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mcUpdateCurrentCalendar) name:NSCurrentLocaleDidChangeNotification object:nil];
    });
    
    return mcCurrentCalendarCache;
}

+ (void)mcUpdateCurrentCalendar
{
    mcCurrentCalendarCache = [NSCalendar currentCalendar];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (BOOL)isToday
{
    return [self isTodayUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isTodayUsingCalendar:(NSCalendar *)calendar
{
    return [self isSameDayAsDate:[NSDate date] usingCalendar:calendar];
}

- (BOOL)isYesterday
{
    return [self isYesterdayUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isYesterdayUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:[components day]-1];
    return [self isSameDayAsDate:[calendar dateFromComponents:components]];
}

- (BOOL)isTomorrow
{
    return [self isTomorrowUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isTomorrowUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:[components day]+1];
    return [self isSameDayAsDate:[calendar dateFromComponents:components]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date
{
    return [self isSameDayAsDate:date usingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date usingCalendar:(NSCalendar *)calendar
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date];
    
    return
    [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (NSDateComponents *)components
{
    return [self componentsWithUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit];
}

- (NSDateComponents *)componentsUsingCalendar:(NSCalendar *)calendar
{
    return [self componentsWithUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit usingCalendar:calendar];
}

- (NSDateComponents *)componentsWithUnits:(NSUInteger)units
{
    return [self componentsWithUnits:units usingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDateComponents *)componentsWithUnits:(NSUInteger)units usingCalendar:(NSCalendar *)calendar
{
    return [calendar components:units fromDate:self];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (NSDate *)dateAtMidnight
{
    return [self dateAtMidnightUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)dateAtMidnightUsingCalendar:(NSCalendar *)calendar
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    
    return [calendar dateFromComponents:comp1];
}

- (NSDate *)firstOfMonth
{
    return [self firstOfMonthUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)firstOfMonthUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents* components = [self componentsWithUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit usingCalendar:calendar];
    [components setDay:1];        
    return [calendar dateFromComponents:components];
}

- (NSDate *)firstOfWeek
{
    return [self firstOfWeekUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)firstOfWeekUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ([weekdayComponents weekday] - [calendar firstWeekday])];
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    return [self dateByAddingCalendarUnit:NSYearCalendarUnit value:years];
}

- (NSDate *)dateByAddingYears:(NSInteger)years usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSYearCalendarUnit value:years usingCalendar:calendar];
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return [self dateByAddingCalendarUnit:NSQuarterCalendarUnit value:quarters];
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSQuarterCalendarUnit value:quarters usingCalendar:calendar];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    return [self dateByAddingCalendarUnit:NSMonthCalendarUnit value:months];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSMonthCalendarUnit value:months usingCalendar:calendar];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return [self dateByAddingCalendarUnit:NSWeekCalendarUnit value:weeks];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSWeekCalendarUnit value:weeks usingCalendar:calendar];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingCalendarUnit:NSDayCalendarUnit value:days];
}

- (NSDate *)dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSDayCalendarUnit value:days usingCalendar:calendar];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    return [self dateByAddingCalendarUnit:NSHourCalendarUnit value:hours];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSHourCalendarUnit value:hours usingCalendar:calendar];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return [self dateByAddingCalendarUnit:NSMinuteCalendarUnit value:minutes];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSMinuteCalendarUnit value:minutes usingCalendar:calendar];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return [self dateByAddingCalendarUnit:NSSecondCalendarUnit value:seconds];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSSecondCalendarUnit value:seconds usingCalendar:calendar];
}

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value
{
    return [self dateByAddingCalendarUnit:calendarUnit value:value usingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value usingCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [self componentsWithUnits:0 usingCalendar:calendar];
    
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
    
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    return date;
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

+ (NSDateComponents *)differenceInCalendarUnit:(NSCalendarUnit)calendarUnit betweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [self differenceInCalendarUnit:calendarUnit betweenDate:fromDateTime andDate:toDateTime usingCalendar:[NSDate mcCurrentCalendar]];
}

+ (NSDateComponents *)differenceInCalendarUnit:(NSCalendarUnit)calendarUnit betweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    NSDateComponents *difference = nil;
    
    NSDate *fromDate;
    if ([calendar rangeOfUnit:calendarUnit startDate:&fromDate interval:NULL forDate:fromDateTime]) {
        NSDate *toDate;
        if ([calendar rangeOfUnit:calendarUnit startDate:&toDate interval:NULL forDate:toDateTime]) {
            difference = [calendar components:calendarUnit fromDate:fromDate toDate:toDate options:0];
        }
    }
    
    return difference;
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSDayCalendarUnit betweenDate:fromDateTime andDate:toDateTime] day];
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSDayCalendarUnit betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] day];
}

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSWeekCalendarUnit betweenDate:fromDateTime andDate:toDateTime] week];
}

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSWeekCalendarUnit betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] week];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSMonthCalendarUnit betweenDate:fromDateTime andDate:toDateTime] month];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSMonthCalendarUnit betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] month];
}

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSYearCalendarUnit betweenDate:fromDateTime andDate:toDateTime] year];
}

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSYearCalendarUnit betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] year];
}

@end

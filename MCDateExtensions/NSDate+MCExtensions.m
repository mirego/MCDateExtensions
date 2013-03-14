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
    NSDateComponents* components = [self componentsWithUnits:0];
    [components setYear:years];
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSDateComponents* components = [self componentsWithUnits:0];    
    [components setDay:days];
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSDateComponents* components = [self componentsWithUnits:0];    
    [components setHour:hours];
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSDateComponents* components = [self componentsWithUnits:0];    
    [components setMinute:minutes];
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    NSDateComponents* components = [self componentsWithUnits:0];    
    [components setSecond:seconds];
    [components setCalendar:[NSCalendar currentCalendar]];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *fromDate, *toDate;
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

@end

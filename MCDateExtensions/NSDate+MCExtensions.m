// Copyright (c) 2013-2015, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:[components day]-1];
    return [self isSameDayAsDate:[calendar dateFromComponents:components]];
}

- (BOOL)isTomorrow
{
    return [self isTomorrowUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isTomorrowUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:[components day]+1];
    return [self isSameDayAsDate:[calendar dateFromComponents:components]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date
{
    return [self isSameDayAsDate:date usingCalendar:[NSDate mcCurrentCalendar]];
}

- (BOOL)isSameDayAsDate:(NSDate *)date usingCalendar:(NSCalendar *)calendar
{
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
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
    return [self componentsWithUnits:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond];
}

- (NSDateComponents *)componentsUsingCalendar:(NSCalendar *)calendar
{
    return [self componentsWithUnits:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond usingCalendar:calendar];
}

- (NSDateComponents *)componentsWithUnits:(NSCalendarUnit)units
{
    return [self componentsWithUnits:units usingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDateComponents *)componentsWithUnits:(NSCalendarUnit)units usingCalendar:(NSCalendar *)calendar
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
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    
    return [calendar dateFromComponents:comp1];
}

- (NSDate *)firstOfMonth
{
    return [self firstOfMonthUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)firstOfMonthUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents* components = [self componentsWithUnits:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay usingCalendar:calendar];
    [components setDay:1];
    return [calendar dateFromComponents:components];
}

- (NSDate *)firstOfWeek
{
    return [self firstOfWeekUsingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)firstOfWeekUsingCalendar:(NSCalendar *)calendar
{
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ([weekdayComponents weekday] - [calendar firstWeekday])];
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitYear value:years];
}

- (NSDate *)dateByAddingYears:(NSInteger)years usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitYear value:years usingCalendar:calendar];
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitQuarter value:quarters];
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitQuarter value:quarters usingCalendar:calendar];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitMonth value:months];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitMonth value:months usingCalendar:calendar];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitWeekOfYear value:weeks];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitWeekOfYear value:weeks usingCalendar:calendar];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitDay value:days];
}

- (NSDate *)dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitDay value:days usingCalendar:calendar];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitHour value:hours];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitHour value:hours usingCalendar:calendar];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitMinute value:minutes];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitMinute value:minutes usingCalendar:calendar];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitSecond value:seconds];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds usingCalendar:(NSCalendar *)calendar
{
    return [self dateByAddingCalendarUnit:NSCalendarUnitSecond value:seconds usingCalendar:calendar];
}

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value
{
    return [self dateByAddingCalendarUnit:calendarUnit value:value usingCalendar:[NSDate mcCurrentCalendar]];
}

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value usingCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [self componentsWithUnits:0 usingCalendar:calendar];
    
    switch (calendarUnit) {
        case NSCalendarUnitEra:
            [components setEra:value];
            break;
            
        case NSCalendarUnitYear:
            [components setYear:value];
            break;
            
        case NSCalendarUnitMonth:
            [components setMonth:value];
            break;
            
        case NSCalendarUnitDay:
            [components setDay:value];
            break;
            
        case NSCalendarUnitHour:
            [components setHour:value];
            break;
            
        case NSCalendarUnitMinute:
            [components setMinute:value];
            break;
            
        case NSCalendarUnitSecond:
            [components setSecond:value];
            break;
            
        case NSCalendarUnitQuarter:
            [components setQuarter:value];
            break;
            
        case NSCalendarUnitWeekOfYear:
            [components setWeekOfYear:value];
            break;
            
        case NSCalendarUnitWeekday:
            [components setWeekday:value];
            break;
            
        case NSCalendarUnitWeekdayOrdinal:
            [components setWeekdayOrdinal:value];
            break;
            
        case NSCalendarUnitWeekOfMonth:
            [components setWeekOfMonth:value];
            break;
            
        case NSCalendarUnitYearForWeekOfYear:
            [components setYearForWeekOfYear:value];
            break;
            
        case NSCalendarUnitNanosecond:
            [components setNanosecond:value];
            break;
            
        default:
            NSAssert(NO, @"Unsupported calendarUnit");
            break;
    }
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
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
    return [[self differenceInCalendarUnit:NSCalendarUnitDay betweenDate:fromDateTime andDate:toDateTime] day];
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSCalendarUnitDay betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] day];
}

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSCalendarUnitWeekOfYear betweenDate:fromDateTime andDate:toDateTime] weekOfYear];
}

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSCalendarUnitWeekOfYear betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] weekOfYear];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSCalendarUnitMonth betweenDate:fromDateTime andDate:toDateTime] month];
}

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSCalendarUnitMonth betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] month];
}

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime
{
    return [[self differenceInCalendarUnit:NSCalendarUnitYear betweenDate:fromDateTime andDate:toDateTime] year];
}

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar
{
    return [[self differenceInCalendarUnit:NSCalendarUnitYear betweenDate:fromDateTime andDate:toDateTime usingCalendar:calendar] year];
}

@end

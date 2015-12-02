# MCDateExtensions - Having fun with NSDate.
[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/MCDateExtensions/badge.png)](https://cocoadocs.org/docsets/MCDateExtensions)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/MCDateExtensions/badge.png)](https://cocoadocs.org/docsets/MCDateExtensions)

```objective-c
#import "NSDate+MCExtensions.h"

- (void)funWithMCDateExtensions
{
  NSDate* today = [NSDate date];

  // Today? Tomorrow? Yesterday?
  [today isToday]; // returns YES
  [today isYesterday]; // returns NO
  [today isTomorrow]; // returns NO

  // Compare based on day
  [today isSameDayAsDate:[NSDate date]]; // Most likely returns YES

  // Get all the details of a date
  NSDateComponents* todayBrokenDown = [today components];
  // ...with specific units
  NSDateComponents* specificUnits = [today componentsWithUnits:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)];

  // Some fun Maths!
  NSDate* sameDayNextYear = [today dateByAddingYears:1];
  NSDate* sameDayNextQuarter = [today dateByAddingQuarters:1];
  NSDate* sameDayInTwoMonth = [today dateByAddingMonths:2];
  NSDate* sameDayNextWeek = [today dateByAddingWeeks:1];
  NSDate* yesterday = [today dateByAddingDays:-1];
  NSDate* tomorrow = [today dateByAddingHours:24];
  NSDate* nextHour = [today dateByAddingMinutes:60];
  NSDate* inTwoMinutes = [today dateByAddingSeconds:120];
  NSDate* inAFewSeconds = [today dateByAddingCalendarUnit:(NSCalendarUnitSecond) value:30];

  // Differences
  NSInteger days = [NSDate daysBetweenDate:today andDate:tomorrow]; // returns 1
  NSInteger weeks = [NSDate daysBetweenDate:today andDate:sameDayNextWeek]; // returns 1
  NSInteger months = [NSDate monthsBetweenDate:today andDate:sameDayInTwoMonth]; // returns 2
  NSInteger years = [NSDate monthsBetweenDate:today andDate:sameDayNextYear]; // returns 1
}
```

## Adding to your project

If you're using [`CocoaPods`](http://cocoapods.org/), there's nothing simpler.
Add the following to your [`Podfile`](http://docs.cocoapods.org/podfile.html)
and run `pod install`

```ruby
pod 'MCDateExtensions', :git => 'https://github.com/mirego/MCDateExtensions.git'
```

Don't forget to `#import "NSDate+MCExtensions.h"` where it's needed.


## License

MCDateExtensions is © 2013-2015 [Mirego](http://www.mirego.com) and may be freely
distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).
See the [`LICENSE.md`](https://github.com/mirego/MCDateExtensions/blob/master/LICENSE.md) file.

## About Mirego

[Mirego](http://mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We're a team of [talented people](http://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://mirego.org).

We also [love open-source software](http://open.mirego.com) and we try to give back to the community as much as we can.

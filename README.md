# MCDateExtensions - Having fun with NSDate.

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
  NSDateComponents* specificUnits = [today componentsWithUnits:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)];

  // Some fun Maths!
  NSDate* sameDayNextYear = [today dateByAddingYears:1];
  NSDate* sameDayNextQuarter = [today dateByAddingQuarters:1];
  NSDate* sameDayInTwoMonth = [today dateByAddingMonths:2];
  NSDate* sameDayNextWeek = [today dateByAddingWeeks:1];
  NSDate* yesterday = [today dateByAddingDays:-1];
  NSDate* tomorrow = [today dateByAddingHours:24];
  NSDate* nextHour = [today dateByAddingMinutes:60];
  NSDate* inTwoMinutes = [today dateByAddingSeconds:120];
  NSDate* inAFewSeconds = [today dateByAddingCalendarUnit:(NSSecondCalendarUnit) value:30];

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

```
pod 'MCDateExtensions', :git => 'https://github.com/mirego/MCDateExtensions.git'
```

Don't forget to `#import "NSDate+MCExtensions.h"` where it's needed.


## License

MCDateExtensions is © 2013 [Mirego](http://www.mirego.com) and may be freely
distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).
See the [`LICENSE.md`](https://github.com/mirego/MCDateExtensions/blob/master/LICENSE.md) file.

## About Mirego

Mirego is a team of passionate people who believe that work is a place where you can innovate and have fun.
We proudly built mobile applications for
[iPhone](http://mirego.com/en/iphone-app-development/ "iPhone application development"),
[iPad](http://mirego.com/en/ipad-app-development/ "iPad application development"),
[Android](http://mirego.com/en/android-app-development/ "Android application development"),
[Blackberry](http://mirego.com/en/blackberry-app-development/ "Blackberry application development"),
[Windows Phone](http://mirego.com/en/windows-phone-app-development/ "Windows Phone application development") and
[Windows 8](http://mirego.com/en/windows-8-app-development/ "Windows 8 application development").
Learn more about our team at [life.mirego.com](http://life.mirego.com "Join our mobile design and development team").
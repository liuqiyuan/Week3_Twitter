//
//  Utils.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/9/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)calculateDateDiff:(NSDate *)date {
    if (date == nil) {
        return nil;
    }
    NSDate * now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:date toDate:now options:0];
    NSInteger months = [components month];
    NSInteger days = [components day];
    NSInteger hours = [components hour];
    if (months == 0 && days == 0) {
        return [NSString stringWithFormat:@"%ld h", (long)hours];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        return [formatter stringFromDate:date];
    }
}

@end

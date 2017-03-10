//
//  NSBundle+IDBundle.m
//  OneHundredDays
//
//  Created by Andrey Bronnikov on 23.02.17.
//  Copyright © 2017 Bronnikov. All rights reserved.
//

#import "NSBundle+IDBundle.h"

// Language codes
static NSString * const kEnglishLanguageCodeKey = @"en";
static NSString * const kRussianLanguageCodeKey = @"ru";

@implementation NSBundle (IDBundle)

+ (NSBundle *)bundleWithLocale: (NSLocale *)locale {
    NSString *currentLanguageCode = [locale objectForKey:NSLocaleLanguageCode];
    NSString *localeBundleString = [[NSBundle mainBundle] pathForResource:currentLanguageCode ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:localeBundleString];
    return languageBundle;
}

@end

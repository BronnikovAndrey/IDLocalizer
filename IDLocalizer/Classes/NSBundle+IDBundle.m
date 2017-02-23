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

+ (NSBundle *)bundleWithLanguageCode: (NSString *)languageCode {
    NSString *ruLocaleBundleString = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:ruLocaleBundleString];
    return languageBundle;
}

+ (NSBundle *)currentBundle {
    NSString *currentLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    return [self bundleWithLanguageCode:currentLanguageCode];
}

+ (NSBundle *)englishBundle {
    return [self bundleWithLanguageCode:kEnglishLanguageCodeKey];
}

+ (NSBundle *)russianBundle {
    return [self bundleWithLanguageCode:kRussianLanguageCodeKey];
}

@end

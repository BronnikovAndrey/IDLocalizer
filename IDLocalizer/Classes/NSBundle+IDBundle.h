//
//  NSBundle+IDBundle.h
//  OneHundredDays
//
//  Created by Andrey Bronnikov on 23.02.17.
//  Copyright © 2017 Bronnikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (IDBundle)

+ (NSBundle *)bundleWithLocale: (NSLocale *)locale;

@end

//
//  SFLocalizationUtils.h
//  SMSFinance
//
//  Created by Андрей on 11.10.16.
//  Copyright © 2016 ImproveGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSBundle+IDBundle.h"
#import "IDLocalizerItem.h"

@interface IDLocalizer : NSObject

// ******* INITIALIZATORS ******* //
+ (instancetype)defaultLocalizer;

- (instancetype)initWithLocale: (NSLocale *)locale
                         item: (IDLocalizerItem *)item;

- (instancetype)initWithLocale: (NSLocale *)locale
                         items: (NSArray <IDLocalizerItem *>*)items;


// ******* PROPERTIES ******* //
@property (strong, nonatomic, readonly) NSLocale *permanentLocale;
@property (strong, nonatomic, readonly) NSArray <IDLocalizerItem *> *permanentItems;


// Key
- (NSString *)localizedStringAtKey: (NSString *)key;

// Key, comment
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment;

// Key, comment, table
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                             items:(NSArray <IDLocalizerItem *>*)items;

@end

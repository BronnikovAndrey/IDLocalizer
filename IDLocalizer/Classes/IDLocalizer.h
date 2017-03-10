//
//  SFLocalizationUtils.h
//  SMSFinance
//
//  Created by Андрей on 11.10.16.
//  Copyright © 2016 ImproveGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSBundle+IDBundle.h"

@interface IDLocalizer : NSObject

// ******* INITIALIZATORS ******* //
+ (instancetype)defaultLocalizer;

- (instancetype)initWithLocale: (NSLocale *)locale
                         table: (NSString *)table;

- (instancetype)initWithLocale: (NSLocale *)locale
                        tables: (NSArray <NSString *>*)tables;


// ******* PROPERTIES ******* //
@property (strong, nonatomic, readonly) NSLocale *permanentLocale;
@property (strong, nonatomic, readonly) NSArray <NSString *> *permanentTables;


// Key
- (NSString *)localizedStringAtKey: (NSString *)key;

// Key, comment
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment;

// Key, comment, table
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                            tables:(NSArray <NSString *> *)tables;

@end

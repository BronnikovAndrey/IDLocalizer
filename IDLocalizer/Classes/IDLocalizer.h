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

- (instancetype)initWithTable: (NSString *)table;

- (instancetype)initWithTable:(NSString *)table
                       bundle:(NSBundle *)bundle
           localizablePostfix:(BOOL)postfix;

// ******* PROPERTIES ******* //
@property (strong, nonatomic, readonly) NSBundle *permanentBundle;
@property (strong, nonatomic, readonly) NSString *permanentTable;

// ******* KEY ******* //
- (NSString *)localizedStringAtKey: (NSString *)key;

// ******* KEY, COMMENT ******* //
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment;

// ******* KEY, COMMENT, TABLE ******* //
- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                         tableName:(NSString *)tableName;


@end

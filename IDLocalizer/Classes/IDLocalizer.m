//
//  SFLocalizationUtils.m
//  SMSFinance
//
//  Created by Андрей on 11.10.16.
//  Copyright © 2016 ImproveGroup. All rights reserved.
//

#import "IDLocalizer.h"
#import <objc/runtime.h>

static NSString * const kDefaultTableNameKey = @"Localizable";

@interface IDLocalizer ()

@property (strong, nonatomic, readwrite) NSBundle *permanentBundle;
@property (strong, nonatomic, readwrite) NSString *permanentTable;

@end

@implementation IDLocalizer

#pragma mark - Initializators
+ (instancetype)defaultLocalizer {
    if (self == [self class]) {
        IDLocalizer *localizer = [[[self class] alloc] initWithTable:kDefaultTableNameKey bundle:[NSBundle currentBundle] localizablePostfix:YES];
        return localizer;
    }
    return nil;
}

- (instancetype)initWithTable: (NSString *)table {

    return [self initWithTable:table bundle:self.permanentBundle localizablePostfix:YES];
}

- (instancetype)initWithTable:(NSString *)table
                       bundle:(NSBundle *)bundle
           localizablePostfix:(BOOL)postfix {
    
    self = [super init];
    if (self) {
        NSString *totalTableString = table;
        if (postfix) {
            totalTableString = [totalTableString stringByAppendingString:kDefaultTableNameKey];
        }
        _permanentTable = totalTableString;
        _permanentBundle = bundle;
    }
    return self;
}

#pragma mark - Localizing
- (NSString *)localizedStringAtKey: (NSString *)key {
    
    return [self localizedStringAtKey:key comment:nil];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment {
    
    return [self localizedStringAtKey:key comment:comment tableName:self.permanentTable];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                         tableName:(NSString *)tableName {
    
    return [self localizedStringAtKey:key comment:comment tableName:tableName bundle:self.permanentBundle];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                         tableName:(NSString *)tableName
                            bundle:(NSBundle *)bundle {
    
    NSString *localizedString = [bundle localizedStringForKey:key value:key table:tableName];
    if (!localizedString || [localizedString isEqualToString:key]) {
        localizedString = [[NSBundle mainBundle] localizedStringForKey:key value:key table:nil];
    }
    return localizedString;
}

#pragma mark - Runtime
NSArray *loc_allProtocolMethods(Protocol *protocol) {
    NSMutableArray *methodList = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 4; ++i) {
        unsigned int numberOfMethodDescriptions = 0;
        struct objc_method_description *methodDescriptions = protocol_copyMethodDescriptionList(protocol, (i / 2) % 2, i % 2, &numberOfMethodDescriptions);
        
        for (unsigned int j = 0; j < numberOfMethodDescriptions; ++j) {
            struct objc_method_description methodDescription = methodDescriptions[j];
            [methodList addObject:NSStringFromSelector(methodDescription.name)];
        }
        free(methodDescriptions);
    }
    
    return methodList;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSString *selectorString = NSStringFromSelector([anInvocation selector]);
    
    NSString *currentProtocolString = [NSString stringWithFormat:@"%@Protocol", NSStringFromClass([self class])];
    Protocol *currentProtocol = (NSProtocolFromString(currentProtocolString));
    if ([loc_allProtocolMethods (currentProtocol) containsObject:selectorString]) {
        NSString *newValue = [self localizedStringAtKey: selectorString];
        [anInvocation setReturnValue:&newValue];
    }
    else {
        NSLog(@"WARNING: Localizer didn't find property");
    }
}

@end

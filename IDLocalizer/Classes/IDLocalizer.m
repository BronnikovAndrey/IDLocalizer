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

@property (strong, nonatomic, readwrite) NSLocale *permanentLocale;
@property (strong, nonatomic, readwrite) NSArray <NSString *> *permanentTables;

@end

@implementation IDLocalizer

#pragma mark - Initializators
+ (instancetype)defaultLocalizer {
    if (self == [self class]) {
        NSLocale *locale = [NSLocale currentLocale];
        NSArray *tables = @[kDefaultTableNameKey];
        IDLocalizer *localizer = [[[self class] alloc] initWithLocale:locale tables:tables];
        return localizer;
    }
    return nil;
}

- (instancetype)initWithLocale: (NSLocale *)locale
                         table: (NSString *)table {
    return [self initWithLocale:locale tables:@[table]];
}

- (instancetype)initWithLocale: (NSLocale *)locale
                        tables: (NSArray <NSString *>*)tables {
    self = [super init];
    if (self) {
        _permanentLocale = locale;
        _permanentTables = tables;
    }
    return self;
}

#pragma mark - Localizing
- (NSString *)localizedStringAtKey: (NSString *)key {
    return [self localizedStringAtKey:key comment:nil];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment {
    
    return [self localizedStringAtKey:key comment:comment tables:self.permanentTables];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                            tables:(NSArray <NSString *> *)tables {
    
    return [self localizedStringAtKey:key comment:comment tables:tables locale:self.permanentLocale];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                            tables:(NSArray <NSString *> *)tables
                            locale:(NSLocale *)locale {
    
    NSBundle *bundle = [NSBundle bundleWithLocale:locale];
    
    NSString *localizedString = nil;
    for (NSString *table in self.permanentTables) {
        NSString *stringsPath = [bundle pathForResource:table ofType:@"strings"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:stringsPath];
        
        if ([dictionary.allKeys containsObject:key]) {
            localizedString = [bundle localizedStringForKey:key value:key table:table];
            return localizedString;
        }
    }
    return nil;
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
    
    Protocol *rootProtocol = [self protocolOfClass:[IDLocalizer class]];
    Protocol *currentProtocol = [self protocolOfClass:[self class]];
    
    BOOL isMethodFromRoot =
    [loc_allProtocolMethods (rootProtocol) containsObject:selectorString];
    
    BOOL isMethodFromCurrent =
    [loc_allProtocolMethods (currentProtocol) containsObject:selectorString];
    
    
    NSString *newValue = [self localizedStringAtKey: selectorString];
    [anInvocation setReturnValue:&newValue];
    
    // TODO: Protocols in runtime
    if (isMethodFromCurrent || isMethodFromRoot) {
       // NSString *newValue = [self localizedStringAtKey: selectorString];
       // [anInvocation setReturnValue:&newValue];
    }
    else {
        NSLog(@"WARNING: Localizer didn't find method, which returns string \"%@\". Check method in your localize module protocol or IDLocalizerProtocol.h", selectorString);
    }
}

- (Protocol *)protocolOfClass: (Class)class {
    NSString *protocolString = [NSString stringWithFormat:@"%@Protocol", NSStringFromClass(class)];
    Protocol *protocol = (NSProtocolFromString(protocolString));
    return protocol;
}





//+ (NSBundle *)currentBundle {
//    NSString *currentLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
//    return [self bundleWithLanguageCode:currentLanguageCode];
//}

@end

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
static NSString * const kDefaultProtocolNameKey = @"IDLocalizerProtocol";

@interface IDLocalizer ()

@property (strong, nonatomic, readwrite) NSLocale *permanentLocale;
@property (strong, nonatomic, readwrite) NSArray <IDLocalizerItem *> *permanentItems;

@end

@implementation IDLocalizer

#pragma mark - Initializators
+ (instancetype)defaultLocalizer {
    if (self == [self class]) {
        NSLocale *locale = [NSLocale currentLocale];
        IDLocalizerItem *item = [[IDLocalizerItem alloc] initWithTable:kDefaultTableNameKey
                                                        protocolString:kDefaultProtocolNameKey];
        IDLocalizer *localizer = [[[self class] alloc] initWithLocale:locale item:item];
        return localizer;
    }
    return nil;
}

- (instancetype)initWithLocale:(NSLocale *)locale item:(IDLocalizerItem *)item {
    return [self initWithLocale:locale items:@[item]];
}

- (instancetype)initWithLocale:(NSLocale *)locale items:(NSArray<IDLocalizerItem *> *)items {
    self = [super init];
    if (self) {
        _permanentLocale = locale;
        _permanentItems = items;
    }
    return self;
}

#pragma mark - Localizing
- (NSString *)localizedStringAtKey: (NSString *)key {
    return [self localizedStringAtKey:key comment:nil];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment {
    return [self localizedStringAtKey:key comment:comment items:self.permanentItems];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                             items:(NSArray <IDLocalizerItem *> *)items {
    
    return [self localizedStringAtKey:key comment:comment items:items locale:self.permanentLocale];
}

- (NSString *)localizedStringAtKey:(NSString *)key
                           comment:(NSString *)comment
                             items:(NSArray <IDLocalizerItem *> *)items
                            locale:(NSLocale *)locale {
    
    NSBundle *bundle = [NSBundle bundleWithLocale:locale];
    NSString *localizedString = nil;
    for (IDLocalizerItem *item in self.permanentItems) {
        NSString *table = item.table;
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



+ (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector];
}

+ (BOOL)resolveInstanceMethod:(SEL)name {
    return [super resolveInstanceMethod:name];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"@@@"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSString *selectorString = NSStringFromSelector([anInvocation selector]);

    /*
    NSArray *protocols = [self.permanentItems valueForKeyPath:@"protocol"];
    
    BOOL isMethodInProtocol = NO;
    for (Protocol *protocol in protocols) {
        isMethodInProtocol =
        [loc_allProtocolMethods (protocol) containsObject:selectorString];
        if (isMethodInProtocol) {
            break;
        }
    }
    
    if (isMethodInProtocol) {
     */
        // TODO: Check protocol have descriptions with loc_allProtocolMethods:
        NSString *newValue = [self localizedStringAtKey: selectorString];
        NSAssert1(newValue,  @"Localizer didn't find method ***%@***", selectorString);
        [anInvocation setReturnValue:&newValue];
    /*
    }
    else {
        NSAssert1(NO, @"Localizer didn't find method, which returns string %@", selectorString);
    }
     */
}

@end

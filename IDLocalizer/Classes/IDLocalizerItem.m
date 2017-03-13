//
//  IDLocalizerItem.m
//  VIPER-L
//
//  Created by Андрей on 13.03.17.
//  Copyright © 2017 Bronnikov. All rights reserved.
//

#import "IDLocalizerItem.h"
#import <objc/runtime.h>

@interface IDLocalizerItem ()

@property (strong, nonatomic, readwrite) NSString *table;
@property (strong, nonatomic, readwrite) Protocol *protocol;
@property (strong, nonatomic, readwrite) NSString *protocolString;

@end

@implementation IDLocalizerItem

- (instancetype)initWithTable: (NSString *)table protocol: (Protocol *)protocol
{
    self = [super init];
    if (self) {
        _table = table;
        _protocol = protocol;
    }
    return self;
}

- (instancetype)initWithTable: (NSString *)table protocolString: (NSString *)protocolString {
    self.protocolString = protocolString;
    return [self initWithTable:table protocol: NSProtocolFromString(protocolString)];
}

@end

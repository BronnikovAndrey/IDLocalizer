//
//  IDLocalizerItem.h
//  VIPER-L
//
//  Created by Андрей on 13.03.17.
//  Copyright © 2017 Bronnikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDLocalizerItem : NSObject

- (instancetype)initWithTable: (NSString *)table protocol: (Protocol *)protocol;
- (instancetype)initWithTable: (NSString *)table protocolString: (NSString *)protocolString;

@property (strong, nonatomic, readonly) NSString *table;
@property (strong, nonatomic, readonly) Protocol *protocol;
@property (strong, nonatomic, readonly) NSString *protocolString;

@end

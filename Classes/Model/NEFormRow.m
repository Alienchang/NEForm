//
//  NEFormRow.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEFormRow.h"
@interface NEFormRow()

@end
@implementation NEFormRow
- (instancetype)initWithType:(NSString *)type {
    self = [super init];
    if (self) {
        _type = type;
        _enable = YES;
    }
    return self;
}
- (NSMutableDictionary *)extConfig {
    if (!_extConfig) {
        _extConfig = [NSMutableDictionary new];
    }
    return _extConfig;
}

@end

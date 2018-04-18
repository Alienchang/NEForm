//
//  NEForm.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEForm.h"

@implementation NEForm
- (void)addSection:(NEFormSection *)section {
    [self.sections addObject:section];
}
- (void)deleteSection:(NEFormSection *)section {
    [self.sections removeObject:section];
}

#pragma mark -- getter
- (NSMutableArray <NEFormSection *>*)sections {
    if (!_sections) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}
@end

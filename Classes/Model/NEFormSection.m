//
//  NEFormSection.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEFormSection.h"

@interface NEFormSection()

@end

@implementation NEFormSection
- (void)addRow:(NEFormRow *)row {
    [self.rows addObject:row];
}
- (void)deleteRow:(NEFormRow *)row {
    [self.rows removeObject:row];
}

- (NSMutableArray <NEFormRow *>*)rows {
    if (!_rows) {
        _rows = [NSMutableArray new];
    }
    return _rows;
}
@end

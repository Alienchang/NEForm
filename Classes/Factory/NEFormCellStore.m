//
//  NEFormCellStore.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEFormCellStore.h"

static NSMutableDictionary *ne_formCellStore;

@implementation NEFormCellStore
+ (void)registerCell:(Class)cell
          identifier:(NSString *)identifier {
    if (!ne_formCellStore) {
        ne_formCellStore = [NSMutableDictionary new];
    }
    if (!cell || !identifier) {
        return;
    }
    [ne_formCellStore setObject:cell forKey:identifier];
}

+ (Class)cellWithIdentifier:(NSString *)identifier {
    if (!identifier) {
        return nil;
    }
    return [ne_formCellStore objectForKey:identifier];
}
+ (NSArray <NSString *>*)allIdentifiers {
    return [ne_formCellStore allKeys];
}
@end

//
//  NEFormCellStore.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEFormCellStore : NSObject
+ (void)registerCell:(Class)cell
          identifier:(NSString *)identifier;
+ (Class)cellWithIdentifier:(NSString *)identifier;
+ (NSArray <NSString *>*)allIdentifiers;
@end

//
//  NEFormSection.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEFormRow.h"

@interface NEFormSection : NSObject
@property (nonatomic ,assign) CGFloat heightOfHeader;
@property (nonatomic ,assign) CGFloat heightOfFooter;
@property (nonatomic ,strong) NSMutableArray <NEFormRow *>*rows;
- (void)addRow:(NEFormRow *)row;
- (void)deleteRow:(NEFormRow *)row;

@end

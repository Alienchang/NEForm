//
//  NEForm.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEFormSection.h"

@interface NEForm : NSObject
@property (nonatomic ,strong) NSMutableArray <NEFormSection *>*sections;

- (void)addSection:(NEFormSection *)section;
- (void)deleteSection:(NEFormSection *)section;

@end

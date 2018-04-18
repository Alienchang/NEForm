//
//  NEPickerFormCell.h
//  NESocialClient
//
//  Created by Chang Liu on 11/30/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEBaseFormCell.h"
#import "NEFormPickerView.h"

extern NSString *const kNEPickerFormType;
extern NSString *const kNEPickerDoneAttributedString;
extern NSString *const kNEPickerLeftAttributedString;
extern NSString *const kNEPickerFormType;
@interface NEPickerFormCell : NEBaseFormCell
@property (nonatomic ,strong) NEFormPickerView *formPickerView;
- (void)tapAction;
@end

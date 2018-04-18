//
//  NEDatePickerFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 12/1/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEDatePickerFormCell.h"
#import "NEFormCellStore.h"
NSString *const kNEDatePickerFormType = @"kNEDatePickerFormType";
@implementation NEDatePickerFormCell
+ (void)load {
    [NEFormCellStore registerCell:[NEDatePickerFormCell class] identifier:kNEDatePickerFormType];
}

- (void)setFormRow:(NEFormRow *)formRow {
    [super setFormRow:formRow];
    if ([formRow.value isKindOfClass:[NSDate class]]) {
        NSDate *date = formRow.value;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        [self.subTitleLabel setText:dateString];
    }
}

- (void)tapAction {
    NSAttributedString *leftAttributed = nil;
    NSAttributedString *rightAttributed = nil;
    if (self.formRow.extConfig[kNEPickerLeftAttributedString]) {
        leftAttributed = self.formRow.extConfig[kNEPickerLeftAttributedString];
    } else {
//        leftAttributed = [[NSAttributedString alloc] initWithString:@"left text" attributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    }
    if (self.formRow.extConfig[kNEPickerDoneAttributedString]) {
        rightAttributed = self.formRow.extConfig[kNEPickerDoneAttributedString];
    } else {
        rightAttributed = [[NSAttributedString alloc] initWithString:@"done" attributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    }
    
    NEWeakSelf(self);
    self.formPickerView = [NEFormPickerView showWithOptions:nil leftAttributed:leftAttributed rightAttributed:rightAttributed pickerType:NEFormPickerTypeDate valueChange:^(id object) {
        [weakself.formRow setValue:object];
        NSDate *date = object;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        [weakself.subTitleLabel setText:dateString];
        if (weakself.formRow.valueChageBlock) {
            weakself.formRow.valueChageBlock(date);
        }
    }];
}
@end

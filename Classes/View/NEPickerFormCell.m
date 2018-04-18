//
//  NEPickerFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/30/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEPickerFormCell.h"
#import "NEFormChoiceOption.h"

#import "NEFormCellStore.h"
NSString *const kNEPickerFormType = @"kNEPickerFormType";
NSString *const kNEPickerDoneAttributedString = @"kNEPickerDoneAttributedString";
NSString *const kNEPickerLeftAttributedString = @"kNEPickerLeftAttributedString";
@interface NEPickerFormCell()

@end

@implementation NEPickerFormCell

+ (void)load {
    [NEFormCellStore registerCell:[NEPickerFormCell class] identifier:kNEPickerFormType];
}

- (void)setFormRow:(NEFormRow *)formRow {
    [super setFormRow:formRow];
    [self.titleLabel setAttributedText:self.formRow.title];
    [self.subTitleLabel setAttributedText:self.formRow.subtitle];
    [self.subTitleLabel setTextAlignment:NSTextAlignmentRight];
    if ([formRow isKindOfClass:[NEFormChoiceOption class]]) {
        NEFormChoiceOption *option = formRow.value;
        [self.subTitleLabel setText:option.title];
    }
    
    [self.subTitleLabel setTextAlignment:NSTextAlignmentRight];
}

- (void)update {
    [super update];
    [self.titleLabel sizeToFit];
    [self.titleLabel setFrame:CGRectMake(16, 0, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.frame))];
    if (self.formRow.accessoryView) {
        [self.subTitleLabel setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.titleLabel.frame) - 8 - 12 - 18, CGRectGetHeight(self.frame))];
    } else {
        [self.subTitleLabel setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.titleLabel.frame) - 12, CGRectGetHeight(self.frame))];
    }
    
    if ([self.formRow.value isKindOfClass:[NEFormChoiceOption class]]) {
        NEFormChoiceOption *option = self.formRow.value;
        [self.subTitleLabel setText:option.title];
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
    self.formPickerView = [NEFormPickerView showWithOptions:self.formRow.options leftAttributed:leftAttributed rightAttributed:rightAttributed          valueChange:^(NEFormChoiceOption *option) {
        if (weakself.formRow.valueChageBlock) {
            weakself.formRow.valueChageBlock(option);
        }
        [weakself.formRow setValue:option];
        [weakself.subTitleLabel setText:option.title];
    }];
}
@end

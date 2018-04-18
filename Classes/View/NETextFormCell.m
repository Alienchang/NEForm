//
//  NETextFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/24/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NETextFormCell.h"
#import "NEFormCellStore.h"
NSString *const kNETextFormType = @"kNETextFormType";
@implementation NETextFormCell

+ (void)load {
    [NEFormCellStore registerCell:[NETextFormCell class] identifier:kNETextFormType];
}

- (void)setFormRow:(NEFormRow *)formRow {
//    if (self.formRow) {
//        return;
//    }
    [super setFormRow:formRow];
    [self.titleLabel setAttributedText:self.formRow.title];
    [self.subTitleLabel setAttributedText:self.formRow.subtitle];
    [self.subTitleLabel setTextAlignment:NSTextAlignmentRight];
}

- (void)update {
    [super update];
    [self.titleLabel sizeToFit];
    [self.titleLabel setFrame:CGRectMake(16, 0, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.frame))];
    
    [self.subTitleLabel setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, CGRectGetWidth(self.frame) - 38 - CGRectGetMaxX(self.titleLabel.frame), CGRectGetHeight(self.frame))];
}
@end

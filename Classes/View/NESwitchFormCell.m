//
//  NESwitchFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NESwitchFormCell.h"
#import "NEFormCellStore.h"
NSString *const kNESwitchFormType = @"kNESwitchFormType";
NSString *const kNESwitchOnTintColor = @"kNESwitchOnTintColor";
NSString *const kNESwitchTintColor = @"kNESwitchTintColor";

@interface NESwitchFormCell()
@property (nonatomic ,strong) UISwitch *switchControl;
@end

@implementation NESwitchFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.switchControl];
    }
    return self;
}

+ (void)load {
    [NEFormCellStore registerCell:[NESwitchFormCell class] identifier:kNESwitchFormType];
}
- (void)setFormRow:(NEFormRow *)formRow {
    [super setFormRow:formRow];
    [self.switchControl setOn:[(NSNumber *)formRow.value integerValue]];
}
- (void)update {
    [super update];
    
    [self.titleLabel setFrame:CGRectMake(16, 0, CGRectGetWidth(self.frame) - 16 - 10 - 51, CGRectGetHeight(self.frame))];
    [self.switchControl setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), (self.formRow.heightOfRow - 31) / 2 , 51, 31)];
    [self.titleLabel setAttributedText:self.formRow.title];
    [self.subTitleLabel setAttributedText:self.formRow.subtitle];
    [self.subTitleLabel setFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetHeight(self.frame) - 2 - 14, CGRectGetMinX(self.switchControl.frame) - CGRectGetMinX(self.titleLabel.frame) , 14)];
    
    UIColor *tintColor = self.formRow.extConfig[kNESwitchTintColor];
    if (tintColor) {
        [self.switchControl setTintColor:tintColor];
    }
    
    UIColor *onTintColor = self.formRow.extConfig[kNESwitchOnTintColor];
    if (onTintColor) {
        [self.switchControl setOnTintColor:onTintColor];
    }
    
    UIColor *subTitleColor = self.formRow.extConfig[kNESubTitleColor];
    if (subTitleColor) {
        [self.subTitleLabel setTextColor:subTitleColor];
    }
}

#pragma mark -- getter
- (UISwitch *)switchControl {
    if (!_switchControl) {
        _switchControl = [UISwitch new];
        [_switchControl addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchControl;
}

#pragma mark -- private func
- (void)valueChangeAction:(UISwitch *)sender {
    if (self.formRow.valueChageBlock) {
        self.formRow.valueChageBlock(@(sender.on));
    }
}
@end

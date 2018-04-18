//
//  NEAvatarFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEAvatarFormCell.h"
#import "NEFormCellStore.h"
NSString *const kNEAvatarFormType = @"kNEAvatarFormType"; 
@implementation NEAvatarFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setFormRow:(NEFormRow *)formRow {
    if (self.formRow) {
        return;
    }
    [super setFormRow:formRow];
    [formRow addObserver:self forKeyPath:NSStringFromSelector(@selector(image)) options:NSKeyValueObservingOptionNew context:nil];
    if (formRow.accessoryView) {
        [self setAccessoryView:formRow.accessoryView];
    }
}
+ (void)load {
    [NEFormCellStore registerCell:[NEAvatarFormCell class] identifier:kNEAvatarFormType];
}

- (void)update {
    [super update];
    [self.customImageView setFrame:CGRectMake(16, 11, 60, 60)];
    [self.customImageView.layer setCornerRadius:30];
    [self.customImageView.layer setMasksToBounds:YES];
    [self.titleLabel setFrame:CGRectMake(CGRectGetMaxX(self.customImageView.frame) + 12, 19, CGRectGetWidth(self.frame) - (CGRectGetMaxX(self.customImageView.frame) + 12) - 28, 24)];
    [self.subTitleLabel setFrame:CGRectMake(CGRectGetMaxX(self.customImageView.frame) + 12, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.frame) - (CGRectGetMaxX(self.customImageView.frame) + 12) - 28, 16)];
    [self.customImageView setImage:self.formRow.image];
    [self.titleLabel setAttributedText:self.formRow.title];
    [self.subTitleLabel setAttributedText:self.formRow.subtitle];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(image))]) {
        UIImage *image = change[NSKeyValueChangeNewKey];
        [self.customImageView setImage:image];
    }
}

-(void)dealloc {
    [self.formRow removeObserver:self forKeyPath:NSStringFromSelector(@selector(image))];
}
@end

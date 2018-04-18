//
//  NEBaseFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEBaseFormCell.h"
#import "NEFormCellStore.h"
NSString *const kNESubTitleColor = @"kNESubTitleColor";
NSString *const kNEBaseFormCell = @"kNEBaseFormCell";
@implementation NEBaseFormCell

+ (void)load {
    [NEFormCellStore registerCell:[NEBaseFormCell class] identifier:kNEBaseFormCell];
}

+ (instancetype)formCellWithIdentifier:(NSString *)identifier {
    return [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    [self.contentView addSubview:self.customImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.accessoryView setFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, (CGRectGetHeight(self.frame) - 18) / 2, 18, 18)];
    [self update];
}

- (void)update {

}

- (void)setFormRow:(NEFormRow *)formRow {
    _formRow = formRow;
    [self setUserInteractionEnabled:formRow.enable];
    if (!formRow.showAccessoryView) {
        [self setAccessoryView:nil];
    } else {
        [self setAccessoryView:formRow.accessoryView];
    }
    
}

+ (NSNumber *)heightWithRow:(NEFormRow *)row {
    if (row.heightOfRow) {
        return @(row.heightOfRow);
    } else {
        return @(44);
    }
}

- (void)tapAction {
    if (self.formRow.tapedBlock) {
        self.formRow.tapedBlock();
    }
}

#pragma mark -- getter
- (UIImageView *)customImageView {
    if (!_customImageView) {
        _customImageView = [UIImageView new];
        [_customImageView setContentMode:UIViewContentModeScaleAspectFill];
        
    }
    return _customImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
    }
    return _subTitleLabel;
}

- (CGFloat)height {
    return 0;
}
@end

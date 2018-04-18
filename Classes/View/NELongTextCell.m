//
//  NELongTextCell.m
//  NESocialClient
//
//  Created by Chang Liu on 11/27/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NELongTextCell.h"
#import "NEFormCellStore.h"

NSString *const kNELongTextType = @"kNELongTextType";

@interface NELongTextCell()
@property (nonatomic ,assign) CGRect subTitleFrame;
@end

@implementation NELongTextCell

+ (void)load {
    [NEFormCellStore registerCell:[NELongTextCell class] identifier:kNELongTextType];
}

- (void)setFormRow:(NEFormRow *)formRow {
    if (self.formRow) {
        return;
    }
    [super setFormRow:formRow];
    [self setAccessoryView:[UIView new]];
    [self.titleLabel setAttributedText:formRow.title];
    [self.subTitleLabel setAttributedText:formRow.subtitle];
    [self.subTitleLabel setNumberOfLines:0];
    [self.subTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
}

- (void)update {
    [super update];
    [self.titleLabel setFrame:CGRectMake(16, 16, CGRectGetWidth(self.frame) - 32, 18)];
    
    CGRect tempSubTitleFrame = [self.formRow.subtitle boundingRectWithSize:CGSizeMake(WIDTH_SCREEN - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    [self setSubTitleFrame:CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame) + 12, CGRectGetWidth(tempSubTitleFrame), CGRectGetHeight(tempSubTitleFrame))];
    [self.subTitleLabel setFrame:self.subTitleFrame];
}

+ (NSNumber *)heightWithRow:(NEFormRow *)row {
    if (row.heightOfRow) {
        return @(row.heightOfRow);
    } else {
        CGRect tempSubTitleFrame = [row.subtitle boundingRectWithSize:CGSizeMake(WIDTH_SCREEN - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        return @(46 + CGRectGetHeight(tempSubTitleFrame) + 16);
    }
}
@end


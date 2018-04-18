//
//  NETextViewFormCell.m
//  NESocialClient
//
//  Created by Chang Liu on 12/6/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NETextViewFormCell.h"
#import "NEFormCellStore.h"
#import "NEFormConst.h"

NSString *const kNETextViewType = @"kNETextViewType";
@interface NETextViewFormCell()

@end

@implementation NETextViewFormCell

+ (void)load {
    [NEFormCellStore registerCell:[NETextViewFormCell class] identifier:kNETextViewType];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (void)setFormRow:(NEFormRow *)formRow {
    if (self.formRow) {
        return;
    }
    [super setFormRow:formRow];
    [self setAccessoryView:[UIView new]];
    [self.titleLabel setAttributedText:formRow.title];
//    [self.subTitleLabel setAttributedText:formRow.subtitle];
//    [self.subTitleLabel setNumberOfLines:0];
//    [self.subTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *content = formRow.value;
    [self.textView setText:content];
    CGFloat textViewHeight = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.textView.frame), MAXFLOAT)].height;
    [self.textView ne_setHeight:self.textView.contentSize.height + self.textView.contentInset.top + self.textView.contentInset.bottom];
}

- (void)update {
    [super update];
    [self.titleLabel setFrame:CGRectMake(16, 16, CGRectGetWidth(self.frame) - 32, 18)];
    
    CGRect tempSubTitleFrame = [self.formRow.subtitle boundingRectWithSize:CGSizeMake(WIDTH_SCREEN - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    [self setSubTitleFrame:CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame) + 12, CGRectGetWidth(tempSubTitleFrame), CGRectGetHeight(tempSubTitleFrame))];
//    [self.subTitleLabel setFrame:self.subTitleFrame];
    [self.textView setFrame:CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame) + 12, WIDTH_SCREEN - 32, CGRectGetHeight(self.textView.frame))];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[[self textViewClass] alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame), WIDTH_SCREEN - 32, 44)];
        [_textView setDelegate:self];
    }
    return _textView;
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self updateHeight];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self updateHeight];
    if (self.formRow.action) {
        self.formRow.action(textView.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        [self updateHeight];
    }
    return YES;
}


- (void)updateHeight {
    if (self.textView.contentSize.height != CGRectGetHeight(self.textView.frame)) {
        CGFloat textViewHeight = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.textView.frame), MAXFLOAT)].height;
        [self.textView ne_setHeight:self.textView.contentSize.height];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_reload_tableView_row object:self];
        [self.textView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (CGFloat)height {
    return 96 + CGRectGetHeight(self.textView.frame);
}

- (Class)textViewClass {
    return [UITextView class];
}
@end

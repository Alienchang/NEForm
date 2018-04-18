//
//  NEFormPickerView.m
//  NESocialClient
//
//  Created by Chang Liu on 11/30/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEFormPickerView.h"

@interface NEFormPickerView ()<UIPickerViewDelegate ,UIPickerViewDataSource>

@end

@implementation NEFormPickerView
+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options
                 leftAttributed:(NSAttributedString *)leftAttributed
                rightAttributed:(NSAttributedString *)rightAttributed
                    valueChange:(void(^)(id object))valueChange {
    return [self showWithOptions:options
                  leftAttributed:leftAttributed
                 rightAttributed:rightAttributed
                      pickerType:NEFormPickerTypeString
                     valueChange:valueChange];
}

+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options
                 leftAttributed:(NSAttributedString *)leftAttributed
                rightAttributed:(NSAttributedString *)rightAttributed
                     pickerType:(NEFormPickerType)pickerType
                    valueChange:(void(^)(id object))valueChange {
    CGFloat topBarHeight = 44;
    CGFloat padding      = 12;
    CGFloat rowHeight    = 33;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat pickerHeight = 0;
    if (pickerType == NEFormPickerTypeString) {
        if (rowHeight * options.count > 216) {
            pickerHeight = padding * 2 + 216 + topBarHeight;
        } else {
            pickerHeight = padding * 2 + rowHeight * options.count + topBarHeight;
        }
    } else {
        pickerHeight = padding * 2 + 216 + topBarHeight;
    }
    
    
    UIButton *bgButton = [[UIButton alloc] initWithFrame:keyWindow.bounds];
    [bgButton setAlpha:0];
    [bgButton setBackgroundColor:[UIColor blackColor]];
    [keyWindow addSubview:bgButton];
    
    NEFormPickerView *formPickerView = [[self alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(keyWindow.bounds), CGRectGetWidth(keyWindow.bounds), pickerHeight) pickerType:pickerType];
    
    [formPickerView setBgButton:bgButton];
    [formPickerView setOptions:options];
    [formPickerView setLeftTitle:leftAttributed];
    [formPickerView setRightTitle:rightAttributed];
    [formPickerView setValueChangeBlock:valueChange];
    [keyWindow addSubview:formPickerView];
    
    [UIView animateWithDuration:.3 animations:^{
        [bgButton setAlpha:.5];
        [formPickerView setFrame:CGRectMake(0, CGRectGetHeight(keyWindow.bounds) - pickerHeight, CGRectGetWidth(keyWindow.bounds), pickerHeight)];
    }];
    
    return formPickerView;
}

+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options {
    return [self showWithOptions:options leftAttributed:nil rightAttributed:nil valueChange:nil];
}

- (instancetype)initWithFrame:(CGRect)frame pickerType:(NEFormPickerType)pickerType {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat topBarHeight = 44;
        CGFloat padding      = 12;
        CGFloat rowHeight    = 33;
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightButton];
        if (pickerType == NEFormPickerTypeDate) {
            [self addSubview:self.datePicker];
            [self.datePicker setFrame:CGRectMake(0, topBarHeight, CGRectGetWidth(frame), CGRectGetHeight(frame) - 44 - 2 * 12)];
        } else if (pickerType == NEFormPickerTypeString) {
            [self addSubview:self.pickerView];
            [self.pickerView setFrame:CGRectMake(0, topBarHeight, CGRectGetWidth(frame), CGRectGetHeight(frame) - 44 - 2 * 12)];
        }
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setOptions:(NSArray<NEFormChoiceOption *> *)options {
    _options = options;
    
}

- (void)setLeftTitle:(NSAttributedString *)leftTitle {
    _leftTitle = leftTitle;
    [self.leftLabel setAttributedText:leftTitle];
    [self.leftLabel sizeToFit];
    [self.leftLabel setFrame:CGRectMake(16, 0, CGRectGetWidth(self.leftLabel.frame), 44)];
}

- (void)setRightTitle:(NSAttributedString *)rightTitle {
    _rightTitle = rightTitle;
    [self.rightButton setAttributedTitle:rightTitle forState:UIControlStateNormal];
    [self.rightButton sizeToFit];
    [self.rightButton setFrame:CGRectMake(CGRectGetWidth(self.frame) - 16 - CGRectGetWidth(self.rightButton.frame), 0, CGRectGetWidth(self.rightButton.frame), 44)];
    [self.rightButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBgButton:(UIButton *)bgButton {
    _bgButton = bgButton;
    [bgButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- public func
- (void)cancelAction {
    
}

- (void)confirmAction {
    
}

#pragma mark -- getter
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
    }
    return _leftLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
    }
    return _rightButton;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        [_pickerView setDelegate:self];
        [_pickerView setDataSource:self];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (void)dismiss {
    CGFloat topBarHeight = 44;
    CGFloat padding      = 12;
    CGFloat rowHeight    = 33;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat pickerHeight = padding * 2 + rowHeight * self.options.count + topBarHeight;
    
    [UIView animateWithDuration:.3 animations:^{
        [self.bgButton setAlpha:0];
        [self setFrame:CGRectMake(0, CGRectGetHeight(keyWindow.bounds), CGRectGetWidth(keyWindow.bounds), pickerHeight)];
    } completion:^(BOOL finished) {
        [self.bgButton removeFromSuperview];
        [self setBgButton:nil];
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerViewDelegat && UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NEFormChoiceOption *option = self.options[row];
    return option.title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NEFormChoiceOption *option = self.options[row];
    if (self.valueChangeBlock) {
        self.valueChangeBlock(option);
    }
}

- (void)datePickerValueChanged {
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.datePicker.date);
    }
}

- (void)dealloc {
    
}
@end

//
//  NEFormPickerView.h
//  NESocialClient
//
//  Created by Chang Liu on 11/30/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NEFormChoiceOption.h"
//@protocol NEFormPickerViewProtocal <NSObject>
//- (void)cancelAction;
//- (void)confirmAction;
//@end
typedef enum : NSUInteger {
    NEFormPickerTypeString,
    NEFormPickerTypeDate,
} NEFormPickerType;

@interface NEFormPickerView : UIView

@property (nonatomic ,strong) NSArray <NEFormChoiceOption *>*options;
@property (nonatomic ,copy) NSAttributedString *rightTitle;
@property (nonatomic ,copy) NSAttributedString *leftTitle;
@property (nonatomic ,strong) UIButton *bgButton;
@property (nonatomic ,strong) UILabel  *leftLabel;
@property (nonatomic ,strong) UIButton *rightButton;
@property (nonatomic ,copy)   void(^valueChangeBlock)(id object);
@property (nonatomic ,strong) UIPickerView *pickerView;
@property (nonatomic ,strong) UIDatePicker *datePicker;

+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options;
+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options
                 leftAttributed:(NSAttributedString *)leftAttributed
                rightAttributed:(NSAttributedString *)rightAttributed
                    valueChange:(void(^)(id object))valueChange;

+ (instancetype)showWithOptions:(NSArray<NEFormChoiceOption *> *)options
                 leftAttributed:(NSAttributedString *)leftAttributed
                rightAttributed:(NSAttributedString *)rightAttributed
                     pickerType:(NEFormPickerType)pickerType
                    valueChange:(void(^)(id object))valueChange;

- (void)cancelAction;
- (void)confirmAction;

- (void)dismiss;
@end

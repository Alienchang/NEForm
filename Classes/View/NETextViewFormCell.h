//
//  NETextViewFormCell.h
//  NESocialClient
//
//  Created by Chang Liu on 12/6/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEBaseFormCell.h"
extern NSString *const kNETextViewType;
@interface NETextViewFormCell : NEBaseFormCell<UITextViewDelegate>
@property (nonatomic ,strong) UITextView *textView;

- (Class)textViewClass;
@end

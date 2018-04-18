//
//  NEBaseFormCell.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEFormRow.h"
#import "NEImageView.h"
extern NSString *const kNESubTitleColor;
extern NSString *const kNEBaseFormCell;
@interface NEBaseFormCell : UITableViewCell
@property (nonatomic ,strong) NEFormRow   *formRow;
@property (nonatomic ,strong) UIImageView *customImageView;
@property (nonatomic ,strong) UILabel     *titleLabel;
@property (nonatomic ,strong) UILabel     *subTitleLabel;
@property (nonatomic ,assign) CGFloat     height;

+ (instancetype)formCellWithIdentifier:(NSString *)identifier;
- (void)addSubviews;
- (void)update;
+ (NSNumber *)heightWithRow:(NEFormRow *)row;
- (void)tapAction;
@end

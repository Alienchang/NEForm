//
//  NEFormRow.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEFormChoiceOption.h"

@interface NEFormRow : NSObject
@property (nonatomic ,copy ,readonly) NSString *type;
@property (nonatomic ,copy) NSAttributedString *title;
@property (nonatomic ,copy) NSAttributedString *subtitle;

@property (nonatomic ,strong) UIView *accessoryView;
@property (nonatomic ,assign) BOOL showAccessoryView;
@property (nonatomic ,assign) BOOL enable;
@property (nonatomic ,copy)   void(^valueChageBlock)(id object);

@property (nonatomic ,copy)   void(^tapedBlock)(void);

@property (nonatomic ,copy)   void(^action)(id value);

@property (nonatomic ,strong) UIImage *image;

@property (nonatomic ,strong) NSMutableDictionary *extConfig;

@property (nonatomic ,strong) id value;

@property (nonatomic ,strong) NSArray <NEFormChoiceOption *>*options;
/**
 初始化

 @param type cellIndetifier，在cell头文件中
 @return 返回自己
 */
- (instancetype)initWithType:(NSString *)type;

@property (nonatomic ,assign) CGFloat heightOfRow;

@end

//
//  NEFormChoiceOption.h
//  NESocialClient
//
//  Created by Chang Liu on 11/30/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEFormChoiceOption : NSObject
@property (nonatomic ,copy)   void(^choiceAction)(NEFormChoiceOption *formChoiceOption);
@property (nonatomic ,strong) id value;
@property (nonatomic ,copy)   NSString *title;
@end

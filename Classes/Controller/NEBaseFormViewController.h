//
//  NEBaseFormViewController.h
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEFormSection.h"
#import "NEForm.h"
@interface NEBaseFormViewController : UIViewController<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NEForm *form;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

- (void)reloadRow:(NEFormRow *)row;
@end

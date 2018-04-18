//
//  NEBaseFormViewController.m
//  NESocialClient
//
//  Created by Chang Liu on 11/23/17.
//  Copyright © 2017 Next Entertainment. All rights reserved.
//

#import "NEBaseFormViewController.h"
#import "NEFormCellFactory.h"
#import "NEFormCellStore.h"
#import "NEBaseFormCell.h"
#import <objc/runtime.h>
#import "NEFormConst.h"
#import "NEFormHeader.h"

@interface NEBaseFormViewController ()
@property (nonatomic ,strong) NSMutableDictionary *cellsStroe;
@end

@implementation NEBaseFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES; //iOS 11 被废弃不好使了
    }
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:self.view.bounds];
}

- (void)setForm:(NEForm *)form {
    _form = form;
    [self reloadTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:kNotification_reload_tableView object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:kNotification_reload_tableView_row object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- getter
- (NSMutableDictionary *)cellsStroe {
    if (!_cellsStroe) {
        _cellsStroe = [NSMutableDictionary new];
    }
    return _cellsStroe;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setTableFooterView:[UIView new]];
        [_tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        for (NSString *identifiers in [NEFormCellStore allIdentifiers]) {
            Class cellClass = [NEFormCellStore cellWithIdentifier:identifiers];
            [_tableView registerClass:cellClass forCellReuseIdentifier:identifiers];
        }
    }
    return _tableView;
}

#pragma mark -- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.form sections].count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NEFormRow *row = [[self.form sections][indexPath.section] rows][indexPath.row];
    NEBaseFormCell *cell = self.cellsStroe[indexPath];
    if (!cell) {
        Class cellClass = [NEFormCellStore cellWithIdentifier:row.type];
        SEL selector = @selector(formCellWithIdentifier:);
        IMP imp = [cellClass methodForSelector:selector];
        NEBaseFormCell * (*func)(id ,SEL ,NSString *) = (void *)imp;
        cell = func(cellClass ,selector ,row.type);
        [self.cellsStroe setObject:cell forKey:indexPath];
        [cell setFormRow:row];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.form sections][section] rows].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEBaseFormCell *cell = self.cellsStroe[indexPath];
    if ([cell height] > 0) {
        return [cell height];
    } else {
        NEFormRow *row = [[self.form sections][indexPath.section] rows][indexPath.row];
        Class cellClass = [NEFormCellStore cellWithIdentifier:row.type];
        SEL selector = @selector(heightWithRow:);
        IMP imp = [cellClass methodForSelector:selector];
        NSNumber * (*func)(id ,SEL ,NEFormRow *) = (void *)imp;
        NSNumber * number = func(cellClass ,selector ,row);
        return [number floatValue];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NEFormSection *formSection = [self.form sections][section];
    return formSection.heightOfFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NEFormSection *formSection = [self.form sections][section];
    return formSection.heightOfHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NEBaseFormCell *cell = self.cellsStroe[indexPath];
    [cell tapAction];
    [self.tableView endEditing:YES];
}

#pragma mark -- public func
- (void)reloadRow:(NEFormRow *)row {
    for (NSInteger sectionIndex = 0; sectionIndex < [self.form sections].count; ++ sectionIndex) {
        NEFormSection *section = [self.form sections][sectionIndex];
        for (NSInteger rowIndex = 0; rowIndex < [section rows].count; ++ rowIndex) {
            NEFormRow *tempRow = [[self.form sections][sectionIndex] rows][rowIndex];
            if (tempRow == row) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                NEBaseFormCell *cell = self.cellsStroe[indexPath];
                [cell setFormRow:row];
//                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyBoardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetHeight(keyBoardRect), 0)];
    
    NSDictionary* info = [notification userInfo];
    // 注意不要用UIKeyboardFrameBeginUserInfoKey，第三方键盘可能会存在高度不准，相差40高度的问题
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    // 修改滚动天和tableView的contentInset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    
    UITableViewCell *firstResponderCell = nil;
    for (UITableViewCell *cell in self.cellsStroe.allValues) {
        if ([cell isKindOfClass:[NETextViewFormCell class]]) {
            if ([((NETextViewFormCell *)cell).textView isFirstResponder]) {
                firstResponderCell = cell;
            }
        }
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:firstResponderCell];
    // 跳转到当前点击的输入框所在的cell
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

#pragma mark -- private func
- (void)reloadTableView {
    [self.tableView reloadData];
}

- (void)reloadTableView:(NSNotification*)notification {
    UITableViewCell *cell = notification.object;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)dealloc {
    
}
@end

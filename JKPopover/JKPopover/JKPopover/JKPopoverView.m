//
//  JKPopoverView.m
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKPopoverView.h"
#import "JKPopoverCell.h"

@interface JKPopoverView ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** items */
@property (nonatomic, strong) NSArray *items;

/** tableView的frame */
@property (nonatomic, assign) CGRect popFrame;
@end

@implementation JKPopoverView

+ (void)showWithPopoverItems:(NSArray *)items popFrame:(CGRect)popFrame tableViewConfiguration:(void(^)(UITableView *tableView))tableViewConfiguration{
    
    for (id itm in items) {
        if (![itm isKindOfClass:[JKPopoverItem class]]) {
            NSLog(@"数组中每个元素都应该是(JKPopoverItem *)！");
            return;
        }
    }
    
    JKPopoverView *popView = [[JKPopoverView alloc] init];
    
    !tableViewConfiguration ? : tableViewConfiguration(popView.tableView);
    
    popView.items = items;
    popView.popFrame = popFrame;
    
    [[UIApplication sharedApplication].delegate.window addSubview:popView];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        _tableView = tableView;
        
        _tableView.layer.anchorPoint = CGPointMake(0.5, 0);
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.layer.cornerRadius = 5;
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _tableView.hidden = YES;
        
        [_tableView registerClass:[JKPopoverCell class] forCellReuseIdentifier:NSStringFromClass([JKPopoverCell class])];
    }
    return _tableView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)orientationChanged:(NSNotification *)noti{
    
    switch ([UIApplication sharedApplication].statusBarOrientation){
        case UIInterfaceOrientationPortrait:{
            
            //        orientationLabel.text = "面向设备保持垂直，Home键位于下部"
            [self relayout];
        }
        case UIInterfaceOrientationPortraitUpsideDown:{
            
            //            orientationLabel.text = "面向设备保持垂直，Home键位于上部"
        }
        case UIInterfaceOrientationLandscapeLeft:{
            
            //            orientationLabel.text = "面向设备保持水平，Home键位于左侧"
            [self relayout];
        }
        case UIInterfaceOrientationLandscapeRight:{
            
            //            orientationLabel.text = "面向设备保持水平，Home键位于右侧"
            [self relayout];
        }
        default:{
            
            //            orientationLabel.text = "方向未知"
        }
    }
}

- (void)relayout{
    
    self.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height));
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//点击空白移除
- (void)remove{
    
    self.window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(1, 0.001);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        self.window.userInteractionEnabled = YES;
        
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        [self removeFromSuperview];
        
    }];
}

//设置tableView的frame
- (void)setPopFrame:(CGRect)popFrame{
    _popFrame = popFrame;
    
    if (self.popFrame.size.width && self.popFrame.size.height) {
        
        self.tableView.frame = self.popFrame;
        
    }else{
        
        self.tableView.bounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width) * 0.6, ([UIScreen mainScreen].bounds.size.height) * 0.6);
        self.tableView.center = self.center;
    }
    
    self.tableView.transform = CGAffineTransformMakeScale(1, 0.001);
}

- (void)didMoveToSuperview{
    if (!self.superview) return;
    
    self.tableView.hidden = NO;
    
    self.window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.tableView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        self.window.userInteractionEnabled = YES;
    }];
}

- (void)setFrame:(CGRect)frame{
    
    frame = [UIScreen mainScreen].bounds;
    
    [super setFrame:frame];
}

#pragma mark - UITableViewDataSource
/** 返回多少行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.items.count;
}

/** 设置cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKPopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JKPopoverCell class])];
    
    if (cell == nil) {
        
        cell = [[JKPopoverCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([JKPopoverCell class])];
    }
    
    cell.item = self.items[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/** 选中了某一行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JKPopoverItem *item = self.items[indexPath.row];
    
    !item.selectBlock ? : item.selectBlock(item);
    
    [self remove];
}

/** 设置每行的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JKPopoverItem *item = self.items[indexPath.row];
    
    return item.rowHeight;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
        
    }else{
        
        return YES;
    }
}
@end

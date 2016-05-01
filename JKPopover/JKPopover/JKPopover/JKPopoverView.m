//
//  JKPopoverView.m
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKPopoverView.h"

#define JKScreenW [UIScreen mainScreen].bounds.size.width
#define JKScreenH [UIScreen mainScreen].bounds.size.height

@interface JKPopoverView ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation JKPopoverView

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 初始化
+ (instancetype)popoverView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.popFrame.size.width && self.popFrame.size.height) {
        self.tableView.frame = self.popFrame;
    }else{
        self.tableView.bounds = CGRectMake(0, 0, JKScreenW * 0.6, JKScreenH * 0.6);
        self.tableView.center = self.center;
    }
}

//点击空白移除
- (void)remove{
    [self removeFromSuperview];
}

//设置tableView的frame
- (void)setPopFrame:(CGRect)popFrame{
    _popFrame = popFrame;
    
    [self layoutIfNeeded];
}

#pragma mark - UITableViewDataSource
/** 返回多少行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource numberOfRowsInMainTableViewpopoverView:self];
}

/** 设置cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    static NSString *reuseId = @"pop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseId];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //设置cell文字
    cell.textLabel.text = [self.dataSource popoverView:self titleInrow:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    //cell普通状态图片
    if ([self.dataSource respondsToSelector:@selector(popoverView:imageNameInrow:)]) {
        cell.imageView.image = [UIImage imageNamed:[self.dataSource popoverView:self imageNameInrow:indexPath.row]];
    }
    
    //cell高亮状态图片
    if ([self.dataSource respondsToSelector:@selector(popoverView:hightImageNameInrow:)]) {
        cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource popoverView:self hightImageNameInrow:indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
/** 选中了某一行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(popoverView:didSelectIndex:)]) {
        [self.delegate popoverView:self didSelectIndex:indexPath.row];
    }
}

/** 设置每行的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(popoverView:heightForRowAtIndexPath:)]) {
        return [self.delegate popoverView:self heightForRowAtIndexPath:indexPath];
    }else{
        return 44;
    }
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

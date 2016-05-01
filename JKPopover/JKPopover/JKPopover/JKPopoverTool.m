//
//  JKPopoverTool.m
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKPopoverTool.h"
#import "JKPopoverView.h"

typedef void(^Block)(NSInteger index);

@interface JKPopoverTool () <JKPopoverViewDataSource, JKPopoverViewDelegate>

@end

static JKPopoverView *_popView;
static JKPopoverTool *_tool;
static CGFloat        _rowHeight;
static NSArray       *_items;

@implementation JKPopoverTool

+ (instancetype)showWithPopoverItems:(NSArray *)items popFrame:(CGRect)popFrame rowHeight:(CGFloat)rowHeight{
    if (_popView == nil) {
        _popView = [[JKPopoverView alloc] init];
        _popView.frame = [UIScreen mainScreen].bounds;
        
        _tool = [[self alloc] init];
    }
    _popView.popFrame = popFrame;
    _rowHeight = rowHeight;
    _items = items;
    
    //设置代理和数据源
    [_tool setDataSourceAndDelegate];
    
    //添加到主窗口
    [[UIApplication sharedApplication].keyWindow addSubview:_popView];
    
    return _tool;
}

//设置代理和数据源
- (void)setDataSourceAndDelegate{
    _popView.dataSource = self;
    _popView.delegate = self;
}

#pragma mark - JKPopoverViewDataSource
- (NSInteger)numberOfRowsInMainTableViewpopoverView:(JKPopoverView *)popoverView{
    return _items.count;
}

- (NSString *)popoverView:(JKPopoverView *)popoverView titleInrow:(NSInteger)row{
    JKPopoverItem *item = _items[row];
    return item.title;
}

- (NSString *)popoverView:(JKPopoverView *)popoverView imageNameInrow:(NSInteger)row{
    JKPopoverItem *item = _items[row];
    return item.normalImage;
}

- (NSString *)popoverView:(JKPopoverView *)popoverView hightImageNameInrow:(NSInteger)row{
    JKPopoverItem *item = _items[row];
    return item.highlightedImage;
}

#pragma mark - JKPopoverViewDelegate
- (CGFloat)popoverView:(JKPopoverView *)popoverView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight;
}

- (void)popoverView:(JKPopoverView *)popoverView didSelectIndex:(NSInteger)index{
    
    !self.selectedIndexBlock? : self.selectedIndexBlock(index);

    _popView = nil;
    
    [popoverView removeFromSuperview];
}
@end

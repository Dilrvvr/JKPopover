//
//  JKPopoverView.h
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKPopoverView;

@protocol JKPopoverViewDataSource <NSObject>
@required
/** 返回多少行 */
- (NSInteger)numberOfRowsInMainTableViewpopoverView:(JKPopoverView *)popoverView;
/** 设置每行的标题 */
- (NSString *)popoverView:(JKPopoverView *)popoverView titleInrow:(NSInteger)row;

@optional
/** 设置每行的普通图片名称 */
- (NSString *)popoverView:(JKPopoverView *)popoverView imageNameInrow:(NSInteger)row;
/** 设置每行的高亮图片名称 */
- (NSString *)popoverView:(JKPopoverView *)popoverView hightImageNameInrow:(NSInteger)row;
@end


@protocol JKPopoverViewDelegate <NSObject>
@optional
/** 选中了某一行 */
- (void)popoverView:(JKPopoverView *)popoverView didSelectIndex:(NSInteger)index;
/** 设置每行的高度 */
- (CGFloat)popoverView:(JKPopoverView *)popoverView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface JKPopoverView : UIView

/** tableView的frame */
@property (nonatomic, assign) CGRect popFrame;

/** 数据源 */
@property (nonatomic, weak) id<JKPopoverViewDataSource> dataSource;

/** 代理 */
@property (nonatomic, weak) id<JKPopoverViewDelegate> delegate;

+ (instancetype)popoverView;

@end

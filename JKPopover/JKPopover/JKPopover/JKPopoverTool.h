//
//  JKPopoverTool.h
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPopoverItem.h"

@interface JKPopoverTool : NSObject

/** 用于监听cell点击的block */
@property (nonatomic, copy) void(^selectedIndexBlock)(NSInteger index);

/**
*  设置要显示的popoverView
*
*  @param items          JKPopoverItem的数组
*  @param popFrame       popover的frame
*  @param rowHeight      每行的高度
*/
+ (instancetype)showWithPopoverItems:(NSArray *)items popFrame:(CGRect)popFrame rowHeight:(CGFloat)rowHeight;
@end

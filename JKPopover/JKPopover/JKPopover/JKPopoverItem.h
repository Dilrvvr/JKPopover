//
//  JKPopoverItem.h
//  Popover
//
//  Created by albert on 16/4/18.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKPopoverItem : NSObject
/** 标题 */
@property (nonatomic, copy, readonly) NSString *title;

/** 富文本标题 */
@property (nonatomic, copy, readonly) NSAttributedString *attrTitle;

/** textAlignment 无图片时默认默认center，有图片默认left */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/** 普通状态图片名称 */
@property (nonatomic, copy, readonly) NSString *normalImage;

/** 高亮状态图片名称 */
@property (nonatomic, copy, readonly) NSString *highlightedImage;

/** textLabel左间距 仅适用于没有图片并且为NSTextAlignmentLeft时 默认为8 */
@property (nonatomic, assign) CGFloat textLabelLeftMargin;

/** 选中样式 默认default */
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;

/** accessoryType 默认none */
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

/** 是否隐藏底部分隔线  默认NO */
@property (nonatomic, assign) BOOL sepLineHidden;

/** cell高度 默认44 */
@property (nonatomic, assign) CGFloat rowHeight;

/** 点击事件回调 */
@property (nonatomic, copy, readonly) void (^selectBlock)(JKPopoverItem *item);

+ (instancetype)itemWithTitle:(NSString *)title normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage selectBlock:(void(^)(JKPopoverItem *item))selectBlock;

+ (instancetype)itemWithAttrTitle:(NSAttributedString *)attrTitle normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage selectBlock:(void(^)(JKPopoverItem *item))selectBlock;
@end

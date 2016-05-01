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
@property (nonatomic, copy) NSString *title;
/** 普通状态图片名称 */
@property (nonatomic, copy) NSString *normalImage;
/** 高亮状态图片名称 */
@property (nonatomic, copy) NSString *highlightedImage;

+ (instancetype)itemWithTitle:(NSString *)title normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage;
@end

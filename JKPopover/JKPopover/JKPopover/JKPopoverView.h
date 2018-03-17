//
//  JKPopoverView.h
//  Popover
//
//  Created by albert on 16/4/16.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPopoverItem.h"

@interface JKPopoverView : UIView

+ (void)showWithPopoverItems:(NSArray *)items popFrame:(CGRect)popFrame tableViewConfiguration:(void(^)(UITableView *tableView))tableViewConfiguration;
@end

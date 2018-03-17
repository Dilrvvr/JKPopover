//
//  JKPopoverItem.m
//  Popover
//
//  Created by albert on 16/4/18.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKPopoverItem.h"

@interface JKPopoverItem ()

@end

@implementation JKPopoverItem

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)popoverWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (instancetype)itemWithTitle:(NSString *)title normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage selectBlock:(void(^)(JKPopoverItem *item))selectBlock{
    JKPopoverItem *item = [[JKPopoverItem alloc] init];
    
    item->_title = title;
    item->_normalImage = normalImage;
    item->_highlightedImage = highlightedImage;
    item->_selectBlock = selectBlock;
    
    item.textAlignment = (normalImage == nil) ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    return item;
}

+ (instancetype)itemWithAttrTitle:(NSAttributedString *)attrTitle normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage selectBlock:(void(^)(JKPopoverItem *item))selectBlock{
    JKPopoverItem *item = [[JKPopoverItem alloc] init];
    
    item->_attrTitle = attrTitle;
    item->_normalImage = normalImage;
    item->_highlightedImage = highlightedImage;
    item->_selectBlock = selectBlock;
    
    item.textAlignment = (normalImage == nil) ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    return item;
}

- (instancetype)init{
    if (self = [super init]) {
        self.textLabelLeftMargin = 8;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.sepLineHidden = NO;
        self.rowHeight = 44;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
@end

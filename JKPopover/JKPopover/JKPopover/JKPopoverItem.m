//
//  JKPopoverItem.m
//  Popover
//
//  Created by albert on 16/4/18.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKPopoverItem.h"

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

+ (instancetype)itemWithTitle:(NSString *)title normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage{
    JKPopoverItem *item = [[JKPopoverItem alloc] init];
    
    item.title = title;
    item.normalImage = normalImage;
    item.highlightedImage = highlightedImage;
    
    return item;
}
@end

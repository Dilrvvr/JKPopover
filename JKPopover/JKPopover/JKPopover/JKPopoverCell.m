//
//  JKPopoverCell.m
//  FreshDelivery
//
//  Created by albert on 2017/8/9.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKPopoverCell.h"
#import "JKPopoverItem.h"

@interface JKPopoverCell ()
/** lineLayer */
@property (nonatomic, weak) CALayer *lineLayer;
@end

@implementation JKPopoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialization];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialization];
    }
    
    return self;
}

- (void)initialization{
    
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1].CGColor;
    [self.layer addSublayer:lineLayer];
    self.lineLayer = lineLayer;
}

- (void)setItem:(JKPopoverItem *)item{
    _item = item;
    
    self.selectionStyle = _item.selectionStyle;
    
    self.accessoryType = _item.accessoryType;
    
    if (item.title) {
        
        self.textLabel.text = item.title;
    }
    
    if (item.attrTitle) {
        self.textLabel.attributedText = item.attrTitle;
    }
    
    if (item.normalImage) {
        self.imageView.image = [UIImage imageNamed:item.normalImage];
    }
    
    if (item.highlightedImage) {
        self.imageView.highlightedImage = [UIImage imageNamed:item.highlightedImage];
    }
    
    self.lineLayer.hidden = _item.sepLineHidden;
    
    self.textLabel.textAlignment = _item.textAlignment;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.item.normalImage && self.textLabel.textAlignment == NSTextAlignmentLeft) {
        
        CGRect rect = self.contentView.bounds;
        
        rect.origin.x = self.item.textLabelLeftMargin;
        rect.size.width = self.contentView.bounds.size.width - self.item.textLabelLeftMargin * 2;
        
        self.textLabel.frame = rect;
    }
    
    self.lineLayer.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

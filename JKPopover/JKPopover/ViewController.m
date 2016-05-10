//
//  ViewController.m
//  JKPopover
//
//  Created by albert on 16/5/1.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "ViewController.h"
#import "JKPopoverTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *showButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    showButton.frame = CGRectMake(100, 100, 60, 30);
    showButton.backgroundColor = [UIColor cyanColor];
    [showButton setTitle:@"show" forState:(UIControlStateNormal)];
    [showButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [showButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
    [showButton addTarget:self action:@selector(show) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:showButton];
    NSLog(@"%@", NSStringFromCGPoint(showButton.center));
}

- (void)show{
    JKPopoverItem *item1 = [JKPopoverItem itemWithTitle:@"全部已读" normalImage:@"ic_quanxuan" highlightedImage:nil];
    JKPopoverItem *item2 = [JKPopoverItem itemWithTitle:@"全部删除" normalImage:@"ic_delet" highlightedImage:nil];
    NSArray *itemsArr = @[item1, item2];
  
    [[JKPopoverTool showWithPopoverItems:itemsArr popFrame:CGRectMake(70, 133, 120, 88) rowHeight:44] setSelectedIndexBlock:^(NSInteger index) {
        switch (index) {
            case 0:
                NSLog(@"选中了第1行---");
                break;
                
            case 1:
                NSLog(@"选中了第2行---");
                break;
                
            default:
                break;
        }
    }];
}
@end

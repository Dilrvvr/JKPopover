//
//  ViewController.m
//  JKPopover
//
//  Created by albert on 16/5/1.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "ViewController.h"
#import "JKPopoverView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    __weak typeof(self) weakSelf = self;
    
    JKPopoverItem *item1 = [JKPopoverItem itemWithTitle:@"redColor" normalImage:nil highlightedImage:nil selectBlock:^(JKPopoverItem *item) {
        
        weakSelf.view.backgroundColor = [UIColor redColor];
    }];
    
    JKPopoverItem *item2 = [JKPopoverItem itemWithTitle:@"whiteColor" normalImage:nil highlightedImage:nil selectBlock:^(JKPopoverItem *item) {
        
        weakSelf.view.backgroundColor = [UIColor whiteColor];
    }];
    
    JKPopoverItem *item3 = [JKPopoverItem itemWithTitle:@"orangeColor" normalImage:nil highlightedImage:nil selectBlock:^(JKPopoverItem *item) {
        
        weakSelf.view.backgroundColor = [UIColor orangeColor];
    }];
    
    [JKPopoverView showWithPopoverItems:@[item1, item2, item3] popFrame:CGRectMake(70, 133, 120, 132) tableViewConfiguration:^(UITableView *tableView) {
        
    }];
}
@end

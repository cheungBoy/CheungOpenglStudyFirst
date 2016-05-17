//
//  ViewController.m
//  CheungOpenglStudyFirst
//
//  Created by cheungBoy on 16/5/17.
//  Copyright © 2016年 cheungBoy. All rights reserved.
//

#import "ViewController.h"
#import "CheungOpenglView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    CheungOpenglView *cheungV = [[CheungOpenglView alloc] init];
    cheungV.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:cheungV];
    cheungV.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

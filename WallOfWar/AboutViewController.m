//
//  AboutViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 1/7/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:(248.0/255.0) green:(244.0/255.0) blue:(219.0/255.0) alpha:1.0]];
    self.aboutView = [AboutView new];
    if (self.view.bounds.size.width > 415) {
        self.aboutView.frame = CGRectMake(96.0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }
    [self.view addSubview:_aboutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

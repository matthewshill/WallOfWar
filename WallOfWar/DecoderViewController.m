//
//  ViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "DecoderViewController.h"

@interface DecoderViewController (){
}
@end

@implementation DecoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.userInteractionEnabled = YES;
    
    _decoderView = [DecoderView new];
    
    if (self.view.bounds.size.width > 415) {
        _decoderView.frame = CGRectMake(96, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }
    
    [self.view addSubview:_decoderView];
    //NSLog(@"%@", self.view.subviews.firstObject);
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    [self setUpText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpText{
    //titl
    _aboutTitle = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.025, (SCREEN_HEIGHT * .015) + statusBarHeight, SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * .07)];
    [_aboutTitle setText:@"About"];
    [_aboutTitle setFont:titleFont];
    [_aboutTitle setEditable:NO];
    [_aboutTitle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_aboutTitle];
    
    //body
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wow" ofType:@"txt"];
    NSError *error;
    NSLog(@"file path: %@", filePath);
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:fileContents
                                                               attributes:@{NSFontAttributeName:stdFont}];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:text];
    NSLayoutManager *textLayout = [[NSLayoutManager alloc] init];
    //add layout manager to text storage object
    [textStorage addLayoutManager:textLayout];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(320, 640)];
    //add text view container to layout
    [textLayout addTextContainer:textContainer];
    //UITextView object using text container
    _body = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.025, SCREEN_HEIGHT * .1, SCREEN_WIDTH * .95, SCREEN_HEIGHT) textContainer:textContainer];
    [_body setScrollEnabled:NO];
    [_body setEditable:NO];
    [_body setBackgroundColor:[UIColor clearColor]];
    _body.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.view addSubview:_body];
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

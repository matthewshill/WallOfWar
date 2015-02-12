//
//  AboutView.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 2/12/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //initialization code
        //[self setBackgroundColor:[UIColor colorWithRed:(248.0/255.0) green:(244.0/255.0) blue:(219.0/255.0) alpha:1.0]];
        [self setUpText];
    }
    return self;
}
-(void)setUpText{
    //titl
    
    _aboutTitle = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.025, (SCREEN_HEIGHT * .015) + statusBarHeight, SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * .07)];
    [_aboutTitle setText:@"About"];
    [_aboutTitle setFont:titleFont];
    [_aboutTitle setEditable:NO];
    [_aboutTitle setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_aboutTitle];
    
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
    [self addSubview:_body];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

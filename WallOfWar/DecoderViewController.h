//
//  ViewController.h
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecoderView.h"

@interface DecoderViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) IBOutlet DecoderView *decoderView;

@end


//
//  ViewController.h
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface DecoderViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeTextField;
@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property (strong, nonatomic) IBOutlet UITextField *regionTextField;
@property (strong, nonatomic) IBOutlet UITextField *attackTextField;
@property (strong, nonatomic) IBOutlet UITextField *friendlywiaTextField;
@property (strong, nonatomic) IBOutlet UITextField *friendlykiaTextField;
@property (strong, nonatomic) IBOutlet UITextField *civilianwiaTextField;
@property (strong, nonatomic) IBOutlet UITextField *civiliankiaTextField;
@property (strong, nonatomic) IBOutlet UITextField *enemywiaTextField;
@property (strong, nonatomic) IBOutlet UITextField *enemykiaTextField;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) IBOutlet UIButton *nextResult;
@property (strong, nonatomic) IBOutlet UIButton *prevResult;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSMutableArray *results;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *resultImage;
@property (strong, nonatomic) UIImageView *properQueryImage;
@property (strong, nonatomic) UIImageView *typeIcon;

@property (strong, nonatomic) UIView *typeIconTray;
@property (strong, nonatomic) UIView *categoryIconTray;
@property (strong, nonatomic) UIView *attackOnIconTray;
@property (strong, nonatomic) UIView *regionIconTray;
@property (strong, nonatomic) UIView *fwiaIconTray;
@property (strong, nonatomic) UIView *fkiaIconTray;
@property (strong, nonatomic) UIView *cwiaIconTray;
@property (strong, nonatomic) UIView *ckiaIconTray;
@property (strong, nonatomic) UIView *ewiaIconTray;
@property (strong, nonatomic) UIView *ekiaIconTray;

@property (strong, nonatomic) UILabel *categoryIconTrayLabel;
@property (strong, nonatomic) UILabel *typeIconTrayLabel;
@property (strong, nonatomic) UILabel *attackOnIconTrayLabel;
@property (strong, nonatomic) UILabel *regionIconTrayLabel;
@property (strong, nonatomic) UILabel *friendlyIconTrayLabel;
@property (strong, nonatomic) UILabel *woundedLabel;
@property (strong, nonatomic) UILabel *killedLabel;
@property (strong, nonatomic) UILabel *enemyLabel;
@property (strong, nonatomic) UILabel *enemyLabel2;
@property (strong, nonatomic) UILabel *civilianLabel;
@property (strong, nonatomic) UILabel *civilianLabel2;
@property (strong, nonatomic) UILabel *friendlyLabel;
@property (strong, nonatomic) UILabel *friendlyLabel2;

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *regionLabel;
@property (strong, nonatomic) UILabel *attackLabel;
@property (strong, nonatomic) UILabel *friendlyResultLabel;
@property (strong, nonatomic) UILabel *friendlyResultLabel2;
@property (strong, nonatomic) UILabel *enemyResultLabel;
@property (strong, nonatomic) UILabel *enemyResultLabel2;
@property (strong, nonatomic) UILabel *civilianResultLabel;
@property (strong, nonatomic) UILabel *civilianResultLabel2;
@property (strong, nonatomic) UILabel *currRec;
@property (strong, nonatomic) UILabel *totalRec;
@property (strong, nonatomic) UILabel *timeLabel;

@end


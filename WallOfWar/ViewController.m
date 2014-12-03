//
//  ViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

int currIndex = 0;
bool searchButtonPressed = false;
NSString *query;
bool typeExpanded = false;
bool categoryExpanded = false;
bool regionExpanded = false;
bool typeIconSelected = false;
NSMutableArray *typeIconArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    
    _results = [[NSMutableArray alloc] init];
   
    //custom status bar background
    UIView *statusBarView =  [[UIView alloc] initWithFrame:statusBarViewFrame];
    statusBarView.backgroundColor  =  statusBarColor;
    [self.view addSubview:statusBarView];
    self.view.userInteractionEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    //[self setUpTextFields];
    [self setUpIconTrays];
    [self setUpButtons];
    [self setUpResultsBox];
}

-(void)setUpIconTrays{
    _typeIconTray = [[UIView alloc] initWithFrame:typeTrayFrame];
    //_typeIconTray.layer.borderColor = iconTrayBorderColor;
    _typeIconTray.layer.borderWidth = iconTrayBorderWidth;
    _typeIconTray.layer.borderColor = selectedRed.CGColor;
    [self.view addSubview:_typeIconTray];
    
    _typeIconTrayLabel = [[UILabel alloc] initWithFrame:iconTrayLabelFrame];
    [_typeIconTrayLabel setFont:stdFont];
    //_typeIconTrayLabel.textColor = iconTrayLabelColor;
    _typeIconTrayLabel.textColor = selectedRed;
    [_typeIconTrayLabel setText:@"TYPE"];
    [_typeIconTray addSubview:_typeIconTrayLabel];
    
    _categoryIconTray = [[UIView alloc] initWithFrame:categoryTrayFrame];
    _categoryIconTray.layer.borderColor = iconTrayBorderColor;
    _categoryIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_categoryIconTray];
    
    _categoryIconTrayLabel = [[UILabel alloc] initWithFrame:iconTrayLabelFrame];
    [_categoryIconTrayLabel setFont:stdFont];
    _categoryIconTrayLabel.textColor = iconTrayLabelColor;
    [_categoryIconTrayLabel setText:@"CATEGORY"];
    [_categoryIconTray addSubview:_categoryIconTrayLabel];
    
    _attackOnIconTray = [[UIView alloc] initWithFrame:attackOnTrayFrame];
    _attackOnIconTray.layer.borderColor = iconTrayBorderColor;
    _attackOnIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_attackOnIconTray];
    
    _attackOnIconTrayLabel = [[UILabel alloc] initWithFrame:iconTrayLabelFrame];
    [_attackOnIconTrayLabel setFont:stdFont];
    _attackOnIconTrayLabel.textColor = iconTrayLabelColor;
    [_attackOnIconTrayLabel setText:@"ATTACK ON"];
    [_attackOnIconTray addSubview:_attackOnIconTrayLabel];
    
    _regionIconTray = [[UIView alloc] initWithFrame:regionTrayFrame];
    _regionIconTray.layer.borderColor = iconTrayBorderColor;
    _regionIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_regionIconTray];
    
    _regionIconTrayLabel = [[UILabel alloc] initWithFrame:iconTrayLabelFrame];
    [_regionIconTrayLabel setFont:stdFont];
    _regionIconTrayLabel.textColor = iconTrayLabelColor;
    [_regionIconTrayLabel setText:@"REGION"];
    [_regionIconTray addSubview:_regionIconTrayLabel];
    
    _fwiaIconTray = [[UIView alloc] initWithFrame:fwiaTrayFrame];
    _fwiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _fwiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_fwiaIconTray];
    
    _fkiaIconTray = [[UIView alloc] initWithFrame:fkiaTrayFrame];
    _fkiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _fkiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_fkiaIconTray];
    
    _ewiaIconTray = [[UIView alloc] initWithFrame:ewiaTrayFrame];
    _ewiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ewiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ewiaIconTray];
    
    _ekiaIconTray = [[UIView alloc] initWithFrame:ekiaTrayFrame];
    _ekiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ekiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ekiaIconTray];
    
    _cwiaIconTray = [[UIView alloc] initWithFrame:cwiaTrayFrame];
    _cwiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _cwiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_cwiaIconTray];
    
    _ckiaIconTray = [[UIView alloc] initWithFrame:ckiaTrayFrame];
    _ckiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ckiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ckiaIconTray];
    
    _woundedLabel = [[UILabel alloc] initWithFrame:woundedLabelFrame];
    [_woundedLabel setFont:stdFont];
    _woundedLabel.textColor = iconTrayLabelColor;
    [_woundedLabel setText:@"Wounded"];
    [self.view addSubview:_woundedLabel];
    
    _killedLabel = [[UILabel alloc] initWithFrame:killedLabelFrame];
    [_killedLabel setFont:stdFont];
    _killedLabel.textColor = iconTrayLabelColor;
    [_killedLabel setText:@"Killed"];
    [self.view addSubview:_killedLabel];
    
    _enemyLabel = [[UILabel alloc] initWithFrame:enemyLabelFrame];
    [_enemyLabel setFont:stdFont];
    _enemyLabel.textColor = iconTrayLabelColor;
    [_enemyLabel setText:@"Enemy"];
    [self.view addSubview:_enemyLabel];
    
    _civilianLabel = [[UILabel alloc] initWithFrame:civilianLabelFrame];
    [_civilianLabel setFont:stdFont];
    _civilianLabel.textColor = iconTrayLabelColor;
    [_civilianLabel setText:@"Civilian"];
    [self.view addSubview:_civilianLabel];
    
    _friendlyLabel = [[UILabel alloc] initWithFrame:friendlyLabelFrame];
    [_friendlyLabel setFont:stdFont];
    _friendlyLabel.textColor = iconTrayLabelColor;
    [_friendlyLabel setText:@"Friendly"];
    [self.view addSubview:_friendlyLabel];
    
    
}
-(void)setUpButtons{
    _clearButton = [[UIButton alloc] init];
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton addTarget:self action:@selector(clearButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    _clearButton.frame = clearButtonFrame;
    [_clearButton setBackgroundImage:[UIImage imageNamed:@"Reset.png"] forState:UIControlStateNormal];
    [self.view addSubview:_clearButton];
    
    _searchButton = [[UIButton alloc] init];
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_searchButton setTitle:@"Search" forState:UIControlStateNormal];
    _searchButton.frame = submitButtonFrame;
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    [self.view addSubview:_searchButton];
    
    _prevResult = [[UIButton alloc] init];
    _prevResult = [UIButton buttonWithType:UIButtonTypeCustom];
    [_prevResult addTarget:self action:@selector(prevButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_prevResult setTitle:@"Prev" forState:UIControlStateNormal];
    [_prevResult setBackgroundImage:[UIImage imageNamed:@"Previous.png"] forState:UIControlStateNormal];
    _prevResult.frame = prevRecordButtonFrame;
    [self.view addSubview:_prevResult];
    
    _nextResult = [[UIButton alloc] init];
    _nextResult = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextResult addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_nextResult setTitle:@"Next" forState:UIControlStateNormal];
    [_nextResult setBackgroundImage:[UIImage imageNamed:@"Next.png"] forState:UIControlStateNormal];
    _nextResult.frame = nextRecordButtonFrame;
    [self.view addSubview:_nextResult];

}
-(void)setUpResultsBox{
    _resultImage = [[UIImageView alloc] initWithFrame:resultImageFrame];
    [_resultImage setImage:[UIImage imageNamed:@"Result.png"]];
    [self.view addSubview:_resultImage];
    
    _imageView = [[UIImageView alloc] initWithFrame:textBoxFrame];
    [_imageView setImage:[UIImage imageNamed:@"TextBox2.png"]];
    [self.view addSubview:_imageView];
    
    _properQueryImage = [[UIImageView alloc] initWithFrame:properQueryImageFrame];
    [_properQueryImage setImage:[UIImage imageNamed:@"properQuery.png"]];
    _properQueryImage.hidden = TRUE;
    [self.view addSubview:_properQueryImage];
    
    _currRec = [[UILabel alloc] initWithFrame:CGRectMake(125, 397, 100, 100)];
    [_currRec setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _currRec.textColor = [UIColor blackColor];
    //_currRec.text = @"1";
    [self.view addSubview:_currRec];
    
    _totalRec = [[UILabel alloc] initWithFrame:CGRectMake(138, 397, 100, 100)];
    [_totalRec setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _totalRec.textColor = [UIColor blackColor];
    //_totalRec.text = @"2";
    [self.view addSubview:_totalRec];
    
    _dateLabel = [[UILabel alloc] initWithFrame:dateTextFrame];
    [_dateLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _dateLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_dateLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:timeTextFrame];
    [_timeLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _timeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_timeLabel];
    
    _typeLabel = [[UILabel alloc] initWithFrame:typeTextFrame];
    [_typeLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _typeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_typeLabel];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:categoryTextFrame];
    [_categoryLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _categoryLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_categoryLabel];
    
    _regionLabel = [[UILabel alloc] initWithFrame:attackOnTextFrame];
    [_regionLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _regionLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_regionLabel];
    
    _attackLabel = [[UILabel alloc] initWithFrame:attackOnTextFrame];
    [_attackLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _attackLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_attackLabel];
    
    _friendlyResultLabel = [[UILabel alloc] initWithFrame:friendlyTextFrame];
    [_friendlyResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _friendlyResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_friendlyResultLabel];
    
    _civilianResultLabel = [[UILabel alloc] initWithFrame:civilianTextFrame];
    [_civilianResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _civilianResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_civilianResultLabel];
    
    _enemyResultLabel = [[UILabel alloc] initWithFrame:enemyTextFrame];
    [_enemyResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10]];
    _enemyResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_enemyResultLabel];
}

-(void)setUpTextFields{
    _typeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, 150, 40)];
    _typeTextField.backgroundColor = [UIColor blackColor];
    _typeTextField.textColor = [UIColor whiteColor];
    _typeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _typeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _typeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_typeTextField];
    _typeTextField.delegate = self;
    
    _categoryTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100,150, 40)];
    _categoryTextField.backgroundColor = [UIColor blackColor];
    _categoryTextField.textColor = [UIColor whiteColor];
    _categoryTextField.borderStyle = UITextBorderStyleRoundedRect;
    _categoryTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Category" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _categoryTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_categoryTextField];
    _categoryTextField.delegate = self;
    
    _regionTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, 150, 40)];
    _regionTextField.backgroundColor = [UIColor blackColor];
    _regionTextField.textColor = [UIColor whiteColor];
    _regionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _regionTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Region" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _regionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_regionTextField];
    _regionTextField.delegate = self;
    
    _attackTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 190, 150, 40)];
    _attackTextField.backgroundColor = [UIColor blackColor];
    _attackTextField.textColor = [UIColor whiteColor];
    _attackTextField.borderStyle = UITextBorderStyleRoundedRect;
    _attackTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"AttackOn" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _attackTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_attackTextField];
    _attackTextField.delegate = self;
    
    _enemywiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 55, 150, 40)];
    _enemywiaTextField.backgroundColor = [UIColor blackColor];
    _enemywiaTextField.textColor = [UIColor whiteColor];
    _enemywiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _enemywiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enemies Wounded" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _enemywiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_enemywiaTextField];
    _enemywiaTextField.delegate = self;
    
    _enemykiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 100, 150, 40)];
    _enemykiaTextField.backgroundColor = [UIColor blackColor];
    _enemykiaTextField.textColor = [UIColor whiteColor];
    _enemykiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _enemykiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enemies Killed" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _enemykiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_enemykiaTextField];
    _enemykiaTextField.delegate = self;
    
    _civilianwiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 145, 150, 40)];
    _civilianwiaTextField.backgroundColor = [UIColor blackColor];
    _civilianwiaTextField.textColor = [UIColor whiteColor];
    _civilianwiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _civilianwiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Civilians Wounded" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _civilianwiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_civilianwiaTextField];
    _civilianwiaTextField.delegate = self;
    
    _civiliankiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 190, 150, 40)];
    _civiliankiaTextField.backgroundColor = [UIColor blackColor];
    _civiliankiaTextField.textColor = [UIColor whiteColor];
    _civiliankiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _civiliankiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Civilians Killed" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _civiliankiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_civiliankiaTextField];
    _civiliankiaTextField.delegate = self;
    
    _friendlywiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 235, 150, 40)];
    _friendlywiaTextField.backgroundColor = [UIColor blackColor];
    _friendlywiaTextField.textColor = [UIColor whiteColor];
    _friendlywiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _friendlywiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Friendly Wounded" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _friendlywiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_friendlywiaTextField];
    _friendlywiaTextField.delegate = self;
    
    _friendlykiaTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 280, 150, 40)];
    _friendlykiaTextField.backgroundColor = [UIColor blackColor];
    _friendlykiaTextField.textColor = [UIColor whiteColor];
    _friendlykiaTextField.borderStyle = UITextBorderStyleRoundedRect;
    _friendlykiaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Friendly Killed" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _friendlykiaTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_friendlykiaTextField];
    _friendlykiaTextField.delegate = self;
}

-(void) performQuery {
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"wallofwar" ofType:@"sqlite"];
    
    sqlite3 *db;
    sqlite3_stmt *statement;
    
    [self getUserInput];
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        NSLog(@"SUCCESSS");
        
        if ([self isValidQuery]) {
            query = [NSString stringWithFormat:@"SELECT * FROM wow WHERE type = \"%@\" AND category = \"%@\" AND region = \"%@\" AND attackon =\"%@\"", _typeTextField.text,_categoryTextField.text, _regionTextField.text,_attackTextField.text];
            
            [self checkForWoundedAndKilled];
            
            if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSString *date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *type = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *category = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    NSString *region = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    NSString *attackon = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    NSString *friendlywia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                    NSString *friendlykia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                    NSString *civilianwia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                    NSString *civiliankia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                    NSString *enemywia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
                    NSString *enemykia = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                    
                    NSString *text = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",date, type, category, region, attackon, friendlywia, friendlykia, civilianwia, civiliankia, enemywia, enemykia];
                    [_results addObject:text];
                    
                }
                [self formatResults];
                currIndex = currIndex + 1;
                [_currRec setText:[NSString stringWithFormat:@"%i", currIndex]];
                [_totalRec setText:[NSString stringWithFormat:@"%lu", (unsigned long)[_results count]]];
            }
        }//if
    }//if
}//performQuery

-(BOOL)isValidQuery{
    if (([_categoryTextField.text length] > 0) && ([_typeTextField.text length] > 0) && ([_regionTextField.text length] > 0) && ([_attackTextField.text length] > 0)) {
        return TRUE;
    }//if
    else{
        _properQueryImage.hidden = FALSE;
        return FALSE;
    }//else
    
}//validQuery

-(void)checkForWoundedAndKilled{
    if ([_friendlywiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND friendlywia=\"%@\"", query, _friendlywiaTextField.text];
    }
    if ([_friendlykiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND friendlykia=\"%@\"", query, _friendlykiaTextField.text];
    }
    if ([_civilianwiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND civilianwia=\"%@\"", query, _civilianwiaTextField.text];
    }
    if ([_civiliankiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND civiliankia=\"%@\"", query, _civiliankiaTextField.text];
    }
    if ([_enemywiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND enemywia=\"%@\"", query, _enemywiaTextField.text];
    }
    if ([_enemykiaTextField.text length] > 0) {
        query = [NSString stringWithFormat:@"%@ AND enemykia=\"%@\"", query, _enemykiaTextField.text];
    }
}

-(void)formatResults{
    NSArray *data = [[_results objectAtIndex:currIndex] componentsSeparatedByString:@","];
    NSArray *dateAndTime = [[data objectAtIndex:0] componentsSeparatedByString:@" "];
    [_dateLabel setText:[dateAndTime objectAtIndex:0]];
    [_timeLabel setText:[dateAndTime objectAtIndex:1]];
    [_typeLabel setText:[data objectAtIndex:1]];
    [_categoryLabel setText:[data objectAtIndex:2]];
    [_regionLabel setText:[data objectAtIndex:3]];
    [_attackLabel setText:[data objectAtIndex:4]];
    [_friendlyResultLabel setText:[NSString stringWithFormat:@"%@ %@", [data objectAtIndex:5], [data objectAtIndex:6]]];
    [_civilianResultLabel setText:[NSString stringWithFormat:@"%@ %@", [data objectAtIndex:7], [data objectAtIndex:8]]];
    [_enemyResultLabel setText:[NSString stringWithFormat:@"%@ %@", [data objectAtIndex:9], [data objectAtIndex:10]]];
}//formatResults

-(void)getUserInput{
    [_categoryTextField resignFirstResponder];
    [_typeTextField resignFirstResponder];
    [_regionTextField resignFirstResponder];
    [_attackTextField resignFirstResponder];
    [_enemykiaTextField resignFirstResponder];
    [_enemywiaTextField resignFirstResponder];
    [_civiliankiaTextField resignFirstResponder];
    [_civilianwiaTextField resignFirstResponder];
    [_friendlywiaTextField resignFirstResponder];
    [_friendlykiaTextField resignFirstResponder];
}//getUserInput

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}//textFieldShould

-(IBAction)searchButtonPressed:(id)sender{
    if (!searchButtonPressed) {
        [self performQuery];
        searchButtonPressed = true;
    }//if
}//searchButtonPressed

-(IBAction)clearButtonPressed:(id)sender{
    searchButtonPressed = false;
    _categoryTextField.text = NULL;
    _typeTextField.text = NULL;
    _regionTextField.text = NULL;
    _attackTextField.text = NULL;
    _enemykiaTextField.text = NULL;
    _enemywiaTextField.text = NULL;
    _civiliankiaTextField.text = NULL;
    _civilianwiaTextField.text = NULL;
    _results = [[NSMutableArray alloc] init];
    currIndex = 0;
    _textView.text = NULL;
    _dateLabel.text = NULL;
    _categoryLabel.text = NULL;
    _typeLabel.text = NULL;
    _regionLabel.text = NULL;
    _attackLabel.text = NULL;
    _friendlyResultLabel.text = NULL;
    _civilianResultLabel.text = NULL;
    _enemyResultLabel.text = NULL;
    _currRec.text = NULL;
    _totalRec.text = NULL;
    _timeLabel.text = NULL;
    _properQueryImage.hidden = TRUE;
    NSLog(@"TypeExpanded Before: %d",typeExpanded);
    NSLog(@"TypeIconSelected Before: %d", typeIconSelected);
    typeIconSelected = false;
    [self resetIconTrayFrame];
    [self resetIconTrayColors];
    NSLog(@"TypeExpanded After: %d",typeExpanded);
    NSLog(@"TypeIconSelected After: %d", typeIconSelected);
}//clearButtonPressed

-(IBAction)nextButtonPressed:(id)sender{
    if (currIndex < [_results count]){
        [self formatResults];
        [_currRec setText:[NSString stringWithFormat:@"%i", currIndex + 1 ]];
        if (currIndex != [_results count] -1) {
            currIndex = currIndex + 1;
        }//if
    }//if
}//nextButtonPressed

-(IBAction)prevButtonPressed:(id)sender{
    if (currIndex > 0) {
        [_currRec setText:[NSString stringWithFormat:@"%i", currIndex]];
        currIndex = currIndex - 1;
        [self formatResults];
    }//if
}//prevButtonPressed

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"TOUCHINNNN");
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    NSLog(@"touches: %@", touches);
    /*if (CGRectContainsPoint(_typeIconTray.frame, touch)) {
        _typeIconTray.layer.borderColor = selectedRed.CGColor;
        _typeIconTrayLabel.textColor = selectedRed;
    }*/
    if (CGRectContainsPoint(_categoryIconTray.frame, touch)){
        _categoryIconTray.layer.borderColor = selectedRed.CGColor;
        _categoryIconTrayLabel.textColor = selectedRed;
    }
    if (CGRectContainsPoint(_regionIconTray.frame, touch)) {
        _regionIconTray.layer.borderColor = selectedRed.CGColor;
        _regionIconTrayLabel.textColor = selectedRed;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"TOUCH ENDED");
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    //[self resetIconTrayColors];
    CGRect newFrame;
    if (CGRectContainsPoint(_typeIconTray.frame, touch) && (!categoryExpanded && !regionExpanded && !typeExpanded && !typeIconSelected)) {
        [self changeTypeIconTrayColors];
        [UIView animateWithDuration:0.3
                         animations:^{
                             _typeIconTray.frame = typeExtendedFrame;
                             _attackOnIconTray.hidden = YES;
                             _regionIconTray.hidden = YES;
                             typeExpanded = true;
                         }];
        [self displayTypeIcons];
        
    }
    else if (typeExpanded && !typeIconSelected) {
        for (int i = 0; i<[typeIconArray count]; i++) {
            UIImageView *icon = [typeIconArray objectAtIndex:i];
            if (CGRectContainsPoint(icon.frame, touch)) {
                [self selectedTypeIcon:icon];
                [self resetIconTrayFrame];
            }//if
        }//for
    }//if
    else if (CGRectContainsPoint(_categoryIconTray.frame, touch) && !typeExpanded && !regionExpanded){
        newFrame = _categoryIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.015) + statusBarHeight;
        newFrame.size.width += (SCREEN_WIDTH * 0.3627);
        newFrame.size.height += (SCREEN_WIDTH * 0.3627);
        
        [UIView animateWithDuration:1.0 animations:^{
            _categoryIconTray.frame = newFrame;
            _woundedLabel.hidden = YES;
            _enemyLabel.hidden = YES;
            _killedLabel.hidden = YES;
            _civilianLabel.hidden = YES;
            _friendlyLabel.hidden = YES;
            _fkiaIconTray.hidden = YES;
            _fwiaIconTray.hidden = YES;
            _cwiaIconTray.hidden = YES;
            _ckiaIconTray.hidden = YES;
            _ewiaIconTray.hidden = YES;
            _ekiaIconTray.hidden = YES;
            _typeIconTray.hidden = YES;
            _regionIconTray.hidden = YES;
            _attackOnIconTray.hidden = YES;
            categoryExpanded = true;}];
    }
    else if (CGRectContainsPoint(_regionIconTray.frame, touch) && !typeExpanded && !categoryExpanded) {
        newFrame = _regionIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.015) + statusBarHeight;
        newFrame.size.height += (SCREEN_HEIGHT * 0.1375);
        
        [UIView animateWithDuration:1.0
                         animations:^{
                             _regionIconTray.frame = newFrame;
                             _attackOnIconTray.hidden = YES;
                             regionExpanded = true;
                         }];
    }
    
}

-(void)displayTypeIcons{
    typeIconArray = [[NSMutableArray alloc] init];
    UIImageView *icon;
    for (int i = 0; i<15; i++) {
        if (i<8) {
            CGRect iconFrame = CGRectMake(((SCREEN_WIDTH * 0.1658) + ((0.0862 * SCREEN_WIDTH) *i)), (SCREEN_HEIGHT* 0.06) + statusBarHeight, SCREEN_WIDTH * 0.0672, SCREEN_HEIGHT * 0.0504);
            
            icon = [[UIImageView alloc] initWithFrame:iconFrame];
            [typeIconArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"type_%d.png", i + 1]]];
            [icon setImage:[typeIconArray objectAtIndex:i]];
            [self.view addSubview:icon];
            icon.hidden = NO;
            icon.alpha = 0.0;
            [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * i) options:UIViewAnimationOptionCurveEaseIn animations:^{
                icon.alpha = 1.0;
            } completion:^(BOOL finished) {
            }];
            icon.userInteractionEnabled = YES;
            [typeIconArray replaceObjectAtIndex:i withObject:icon];
        }
        else{
            int j = i - 8;
            CGRect iconFrame = CGRectMake(((SCREEN_WIDTH * 0.1658) + ((0.0862 * SCREEN_WIDTH) *j)), (SCREEN_HEIGHT* 0.06) + (SCREEN_HEIGHT * 0.065) + statusBarHeight, SCREEN_WIDTH * 0.0672, SCREEN_HEIGHT * 0.0504);
             icon = [[UIImageView alloc] initWithFrame:iconFrame];
             [typeIconArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"type_%d.png", i + 1]]];
             [icon setImage:[typeIconArray objectAtIndex:i]];
             [self.view addSubview:icon];
             icon.hidden = NO;
             icon.alpha = 0.0;
             [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * i) options:UIViewAnimationOptionCurveEaseIn animations:^{
             icon.alpha = 1.0;
             } completion:^(BOOL finished) {
             }];
            icon.userInteractionEnabled = YES;
             [typeIconArray replaceObjectAtIndex:i withObject:icon];
        }//else
        
    }//for
}
-(void)selectedTypeIcon:(UIImageView *)icon{
    //set selected icon within type icon tray frame
    CGRect typeFrame = CGRectMake(SCREEN_WIDTH * 0.2268, SCREEN_HEIGHT * 0.075 + statusBarHeight, SCREEN_WIDTH * 0.18375, SCREEN_HEIGHT * 0.14);
    UIImageView *selectedIcon = icon;
    selectedIcon.frame = typeFrame;
    //selectedIcon.hidden = NO;
    [self.view addSubview:selectedIcon];
    [self changeCatIconTrayColors];
    typeIconSelected = TRUE;
}
-(void)resetIconTrayColors{
    _typeIconTray.layer.borderColor = selectedRed.CGColor;
    _typeIconTrayLabel.textColor = selectedRed;
    _categoryIconTray.layer.borderColor = iconTrayBorderColor;
    _categoryIconTrayLabel.textColor = iconTrayLabelColor;
    _regionIconTray.layer.borderColor = iconTrayBorderColor;
    _regionIconTrayLabel.textColor = iconTrayLabelColor;
}
-(void)changeTypeIconTrayColors{
    _typeIconTray.layer.borderColor = iconTrayBorderColor;
    _typeIconTrayLabel.textColor = iconTrayLabelColor;
}
-(void)changeCatIconTrayColors{
    _categoryIconTray.layer.borderColor = selectedRed.CGColor;
    _categoryIconTrayLabel.textColor = selectedRed;
}
-(void)resetIconTrayFrame{
    CGRect newFrame;
    if(typeExpanded){
        //newFrame = _typeIconTray.frame;
        //newFrame.size.width -= (SCREEN_WIDTH * 0.3627);
        
        [UIView animateWithDuration:0.0
                         animations:^{
                             _typeIconTray.frame = typeTrayFrame;
                             _attackOnIconTray.hidden = NO;
                             _regionIconTray.hidden = NO;
                             typeExpanded = false;
                             //typeIconSelected = false;
                         }];
        
        for (int i = 0; i<[typeIconArray count]; i++) {
            UIImageView *icon = [typeIconArray objectAtIndex:i];
            icon.alpha = 0.0;
            [typeIconArray replaceObjectAtIndex:i withObject:icon];
        }

    }
    if (categoryExpanded){
        newFrame = _categoryIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.29) +statusBarHeight;
        newFrame.size.width -= (SCREEN_WIDTH * 0.3627);
        newFrame.size.height -= (SCREEN_WIDTH * 0.3627);
        
        [UIView animateWithDuration:0.0 animations:^{
            _categoryIconTray.frame = newFrame;
            _woundedLabel.hidden = NO;
            _enemyLabel.hidden = NO;
            _killedLabel.hidden = NO;
            _civilianLabel.hidden = NO;
            _friendlyLabel.hidden = NO;
            _fkiaIconTray.hidden = NO;
            _fwiaIconTray.hidden = NO;
            _cwiaIconTray.hidden = NO;
            _ckiaIconTray.hidden = NO;
            _ewiaIconTray.hidden = NO;
            _typeIconTray.hidden = NO;
            _regionIconTray.hidden = NO;
            _attackOnIconTray.hidden = NO;
            _ekiaIconTray.hidden = NO;
            categoryExpanded = false;}];
    }
    if (regionExpanded) {
        newFrame = _regionIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.1525) + statusBarHeight;
        newFrame.size.height -= (SCREEN_HEIGHT * 0.1375);
        
        [UIView animateWithDuration:0.0
                         animations:^{
                             _regionIconTray.frame = newFrame;
                             _attackOnIconTray.hidden = NO;
                             regionExpanded = false;
                         }];
    }
    
}

@end

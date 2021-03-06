//
//  ViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "DecoderViewController.h"

@interface DecoderViewController (){
    NSString *attackOn;
    NSMutableArray *categoryNames;
    NSMutableArray *regionNames;
    NSMutableDictionary *typeIconDictionary;
    NSMutableArray *typeIconIndex;
    NSMutableArray *categoryIconArray;
    NSMutableArray *regionIconArray;
    NSMutableArray *currWokArray;
    UIImageView *selectedTypeIcon;
    UIImageView *selectedCatIcon;
    UIImageView *selectedAttackIcon;
    UIImageView *selectedRegionIcon;
    UIImageView *selectedFwiaIcon;
    UIImageView *selectedFkiaIcon;
    UIImageView *selectedCwiaIcon;
    UIImageView *selectedCkiaIcon;
    UIImageView *selectedEwiaIcon;
    UIImageView *selectedEkiaIcon;
    UIView *currWokView;
    NSString *selectedType;
    NSString *selectedCategory;
    NSString *selectedRegion;
    NSString *selectedFwia;
    NSString *selectedFkia;
    NSString *selectedCwia;
    NSString *selectedCkia;
    NSString *selectedEwia;
    NSString *selectedEkia;
}
@end

@implementation DecoderViewController

int currIndex = 0;
bool searchButtonPressed = false;
NSString *query;
bool typeExpanded = false;
bool categoryExpanded = false;
bool regionExpanded = false;
bool typeIconSelected = false;
bool catIconSelected = false;
bool attackIconSelcted = false;
bool regionIconSelected = false;
bool wokViewSelected = false;
bool ekiaExpanded = false;
bool ewiaExpanded = false;
bool ckiaExpanded = false;
bool cwiaExpanded = false;
bool fwiaExpanded = false;
bool fkiaExpanded = false;
bool wOkQuery = false;
bool wOkEnabled = false;
int width;
int typesize;
int leftmargin;
int textsmall;


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
    if (IS_IPad) {
        width = 575;
        typesize = 21;
        leftmargin = 96;
        textsmall = 5;
        
    }
    if (IS_IPhone) {
        width = SCREEN_WIDTH;
        typesize = 10.8;
        leftmargin = 0;
        textsmall = 0;
        
        
    }
    
    [self setUpIconTrays];
    [self setUpButtons];
    [self setUpResultsBox];
    [self setUpTypeIconArray];
}

-(void)setUpTypeIconArray{
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"TypeIcons" ofType:@"plist"];
    typeIconDictionary = [[NSMutableDictionary alloc] init];
    typeIconIndex = [[NSMutableArray alloc] init];
    // Build the array from the plist
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    for (NSString *s in array) {
        UIImage *img = [UIImage imageNamed:s];
        if ([s containsString:@".png"]) {
            NSString *s2 = [s stringByReplacingOccurrencesOfString:@".png" withString:@""];
            [typeIconDictionary setValue:img forKey:s2];
            [typeIconIndex addObject:s2];
        }
    }

}
-(void)setUpIconTrays{
    _typeIconTray = [[UIView alloc] initWithFrame: CGRectMake(leftmargin + width * 0.025, (SCREEN_HEIGHT * 0.015) + statusBarHeight, width * stdWidth, SCREEN_HEIGHT * stdHeight)];//typeTrayFrame];
    //_typeIconTray.layer.borderColor = iconTrayBorderColor;
    _typeIconTray.layer.borderWidth = iconTrayBorderWidth;
    _typeIconTray.layer.borderColor = selectedRed.CGColor;
    [self.view addSubview:_typeIconTray];
    
    _typeIconTrayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width * 0.025), (SCREEN_HEIGHT * 0.015), 42, 18)];//iconTrayLabelFrame];
    [_typeIconTrayLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:10.8]];//stdFont];
    //_typeIconTrayLabel.textColor = iconTrayLabelColor;
    _typeIconTrayLabel.textColor = selectedRed;
    [_typeIconTrayLabel setText:@"TYPE"];
    [_typeIconTray addSubview:_typeIconTrayLabel];
    
    _categoryIconTray = [[UIView alloc] initWithFrame:CGRectMake(leftmargin + width * 0.025, (SCREEN_HEIGHT * 0.29) + statusBarHeight, width * stdWidth, SCREEN_HEIGHT * stdHeight)]; //categoryTrayFrame];
    _categoryIconTray.layer.borderColor = iconTrayBorderColor;
    _categoryIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_categoryIconTray];
    
    _categoryIconTrayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width * 0.025), (SCREEN_HEIGHT * 0.015), 100, 18)];//iconTrayLabelFrame];
    [_categoryIconTrayLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//stdFont];
    _categoryIconTrayLabel.textColor = iconTrayLabelColor;
    [_categoryIconTrayLabel setText:@"CATEGORY"];
    [_categoryIconTray addSubview:_categoryIconTrayLabel];
    
    _attackOnIconTray = [[UIView alloc] initWithFrame:CGRectMake(leftmargin + width* 0.5125, (SCREEN_HEIGHT * 0.015) + statusBarHeight, width * stdWidth, SCREEN_HEIGHT * 0.1225)];//attackOnTrayFrame];
    _attackOnIconTray.layer.borderColor = iconTrayBorderColor;
    _attackOnIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_attackOnIconTray];
    
    _attackOnIconTrayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width * 0.025), (SCREEN_HEIGHT * 0.015), 100, 18)];//iconTrayLabelFrame];
    [_attackOnIconTrayLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//stdFont];
    _attackOnIconTrayLabel.textColor = iconTrayLabelColor;
    [_attackOnIconTrayLabel setText:@"ATTACK ON"];
    [_attackOnIconTray addSubview:_attackOnIconTrayLabel];
    
    _regionIconTray = [[UIView alloc] initWithFrame:CGRectMake(leftmargin + width * 0.5125, (SCREEN_HEIGHT * 0.1525) + statusBarHeight, width * stdWidth, SCREEN_HEIGHT * 0.1225)]; //regionTrayFrame];
    _regionIconTray.layer.borderColor = iconTrayBorderColor;
    _regionIconTray.layer.borderWidth = iconTrayBorderWidth;
    [self.view addSubview:_regionIconTray];
    
    _regionIconTrayLabel = [[UILabel alloc] initWithFrame:CGRectMake((width * 0.025), (SCREEN_HEIGHT * 0.015), 100, 18)];//iconTrayLabelFrame];
    [_regionIconTrayLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//stdFont];
    _regionIconTrayLabel.textColor = iconTrayLabelColor;
    [_regionIconTrayLabel setText:@"REGION"];
    [_regionIconTray addSubview:_regionIconTrayLabel];
    
    _fwiaIconTray = [[UIView alloc] initWithFrame: CGRectMake(leftmargin + width* 0.5125, (SCREEN_HEIGHT * 0.32) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)]; //fwiaTrayFrame];
    _fwiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _fwiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_fwiaIconTray];
    
    _fkiaIconTray = [[UIView alloc] initWithFrame: CGRectMake(leftmargin + width * 0.7975, (SCREEN_HEIGHT * 0.32) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)]; //fkiaTrayFrame];
    _fkiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _fkiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_fkiaIconTray];
    
    _ewiaIconTray = [[UIView alloc] initWithFrame: CGRectMake(leftmargin + width* 0.5125, (SCREEN_HEIGHT * 0.474) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)]; //ewiaTrayFrame];
    _ewiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ewiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ewiaIconTray];
    
    _ekiaIconTray = [[UIView alloc] initWithFrame:CGRectMake(leftmargin + width * 0.7975, (SCREEN_HEIGHT * 0.474) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)];//ekiaTrayFrame];
    _ekiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ekiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ekiaIconTray];
    
    _cwiaIconTray = [[UIView alloc] initWithFrame: CGRectMake(leftmargin + width * 0.5125, (SCREEN_HEIGHT * 0.397) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)]; //cwiaTrayFrame];
    _cwiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _cwiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_cwiaIconTray];
    
    _ckiaIconTray = [[UIView alloc] initWithFrame:CGRectMake(leftmargin + width* 0.7975, (SCREEN_HEIGHT * 0.397) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065)];//ckiaTrayFrame];
    _ckiaIconTray.layer.borderWidth = iconTrayBorderWidth;
    _ckiaIconTray.layer.borderColor = iconTrayBorderColor;
    [self.view addSubview:_ckiaIconTray];
    
    _woundedLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.5502, (SCREEN_HEIGHT * 0.2975) + statusBarHeight, width * 0.2, SCREEN_HEIGHT * 0.02)];//woundedLabelFrame];
    [_woundedLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//stdFont];
    _woundedLabel.textColor = iconTrayLabelColor;
    [_woundedLabel setText:@"Wounded"];
    [self.view addSubview:_woundedLabel];
    
    _killedLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + (width * 0.8544), (SCREEN_HEIGHT * 0.2975) + statusBarHeight, width * 0.2, SCREEN_HEIGHT * 0.02)];//killedLabelFrame];
    [_killedLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];//stdFont];
    _killedLabel.textColor = iconTrayLabelColor;
    [_killedLabel setText:@"Killed"];
    [self.view addSubview:_killedLabel];
    
    _enemyLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + (width * 0.7077), (SCREEN_HEIGHT * 0.498) + statusBarHeight, width * 0.0734, SCREEN_HEIGHT * 0.01699)];//enemyLabelFrame];
    [_enemyLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:(typesize - textsmall)]];//stdFont];
    _enemyLabel.textColor = iconTrayLabelColor;
    [_enemyLabel setText:@"Enemy"];
    [self.view addSubview:_enemyLabel];
    
    _civilianLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + (width* 0.7), (SCREEN_HEIGHT * 0.4208) + statusBarHeight, width * 0.0846, SCREEN_HEIGHT * 0.0175)];//civilianLabelFrame];
    [_civilianLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize - textsmall]];//stdFont];
    _civilianLabel.textColor = iconTrayLabelColor;
    [_civilianLabel setText:@"Civilian"];
    [self.view addSubview:_civilianLabel];
    
    _friendlyLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + (width * 0.7), (SCREEN_HEIGHT * 0.3438) + statusBarHeight, width * 0.1, SCREEN_HEIGHT * 0.025)];//friendlyLabelFrame];
    [_friendlyLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:(typesize - textsmall)]];//stdFont];
    _friendlyLabel.textColor = iconTrayLabelColor;
    [_friendlyLabel setText:@"Friendly"];
    [self.view addSubview:_friendlyLabel];
    
    
}
-(void)setUpButtons{
    _clearButton = [[UIButton alloc] init];
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton addTarget:self action:@selector(clearButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    _clearButton.frame = CGRectMake(leftmargin + width* 0.7298, (SCREEN_HEIGHT * 0.81) + statusBarHeight, width * 0.1066, SCREEN_HEIGHT * 0.06);//clearButtonFrame;
    [_clearButton setBackgroundImage:[UIImage imageNamed:@"Reset.png"] forState:UIControlStateNormal];
    [self.view addSubview:_clearButton];
    
    _searchButton = [[UIButton alloc] init];
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_searchButton setTitle:@"Search" forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(leftmargin + width * 0.8614, (SCREEN_HEIGHT * 0.81) + statusBarHeight, width * 0.1066, SCREEN_HEIGHT * 0.06);//submitButtonFrame;
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    [self.view addSubview:_searchButton];
    
    _prevResult = [[UIButton alloc] init];
    _prevResult = [UIButton buttonWithType:UIButtonTypeCustom];
    [_prevResult addTarget:self action:@selector(prevButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_prevResult setTitle:@"Prev" forState:UIControlStateNormal];
    [_prevResult setBackgroundImage:[UIImage imageNamed:@"Previous.png"] forState:UIControlStateNormal];
    _prevResult.frame = CGRectMake(leftmargin + width * 0.025, (SCREEN_HEIGHT * 0.81) + statusBarHeight, width * 0.1066, SCREEN_HEIGHT * 0.06);//prevRecordButtonFrame;
    [self.view addSubview:_prevResult];
    
    _nextResult = [[UIButton alloc] init];
    _nextResult = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextResult addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    //[_nextResult setTitle:@"Next" forState:UIControlStateNormal];
    [_nextResult setBackgroundImage:[UIImage imageNamed:@"Next.png"] forState:UIControlStateNormal];
    _nextResult.frame = CGRectMake(leftmargin + width* .1566, (SCREEN_HEIGHT * 0.81) + statusBarHeight, width * 0.1066, SCREEN_HEIGHT * 0.06);//nextRecordButtonFrame;
    [self.view addSubview:_nextResult];
    
}
-(void)setUpResultsBox{
    _resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(leftmargin + width * 0.4626, (SCREEN_HEIGHT * 0.8316) + statusBarHeight, width * 0.076, SCREEN_HEIGHT * 0.03765)];//resultImageFrame];
    [_resultImage setImage:[UIImage imageNamed:@"Result.png"]];
    [self.view addSubview:_resultImage];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftmargin + width* 0.025, (SCREEN_HEIGHT * 0.6325) + statusBarHeight, width * 0.95, SCREEN_HEIGHT * 0.1625)];//textBoxFrame];
    [_imageView setImage:[UIImage imageNamed:@"TextBox2.png"]];
    [self.view addSubview:_imageView];
    
    _properQueryImage = [[UIImageView alloc] initWithFrame:CGRectMake(leftmargin + width* 0.025, (SCREEN_HEIGHT * 0.5650) + statusBarHeight, width * 0.95, SCREEN_HEIGHT * 0.0525)];//properQueryImageFrame];
    [_properQueryImage setImage:[UIImage imageNamed:@"properQuery.png"]];
    _properQueryImage.hidden = TRUE;
    [self.view addSubview:_properQueryImage];
    
    _currRec = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.4655, (SCREEN_HEIGHT * 0.851) + statusBarHeight, width * 0.1347, SCREEN_HEIGHT * 0.01818)];
    [_currRec setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _currRec.textColor = [UIColor blackColor];
    [self.view addSubview:_currRec];
    
    _totalRec = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.515, ((SCREEN_HEIGHT * 0.851) + statusBarHeight) - 0.008, width * 0.1347, SCREEN_HEIGHT * 0.01818)];
    [_totalRec setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _totalRec.textColor = [UIColor blackColor];
    //_totalRec.text = @"2";
    [self.view addSubview:_totalRec];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width* 0.0562, (SCREEN_HEIGHT * 0.6655) + statusBarHeight, width * 0.2, SCREEN_HEIGHT * 0.01818)];//dateTextFrame];
    [_dateLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _dateLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_dateLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.0562, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.1347, SCREEN_HEIGHT * 0.01818)];//timeTextFrame];
    [_timeLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _timeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_timeLabel];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.2432, (SCREEN_HEIGHT * 0.6655) + statusBarHeight, width * 0.2746, SCREEN_HEIGHT * 0.01818)];//typeTextFrame];
    [_typeLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _typeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_typeLabel];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.2432, (SCREEN_HEIGHT * 0.7126) + statusBarHeight, width * 0.5941, SCREEN_HEIGHT * 0.01818)];//categoryTextFrame];
    [_categoryLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _categoryLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_categoryLabel];
    
    _regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.5538, (SCREEN_HEIGHT * 0.6655) + statusBarHeight, width * 0.2229, SCREEN_HEIGHT * 0.025)];//regionTextFrame];
    [_regionLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _regionLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_regionLabel];
    
    _attackLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.8168, (SCREEN_HEIGHT * 0.6655) + statusBarHeight, width * 0.15, SCREEN_HEIGHT * 0.025)];//attackOnTextFrame];
    [_attackLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _attackLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_attackLabel];
    
    _friendlyResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.24, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//friendlyTextFrame1];
    [_friendlyResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _friendlyResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_friendlyResultLabel];
    
    _friendlyResultLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.30, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//friendlyTextFrame2];
    [_friendlyResultLabel2 setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _friendlyResultLabel2.textColor = [UIColor blackColor];
    [self.view addSubview:_friendlyResultLabel2];
    
    _civilianResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.43, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//civilianTextFrame1];
    [_civilianResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _civilianResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_civilianResultLabel];
    
    _civilianResultLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(leftmargin + width* 0.49, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//civilianTextFrame2];
    [_civilianResultLabel2 setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _civilianResultLabel2.textColor = [UIColor blackColor];
    [self.view addSubview:_civilianResultLabel2];
    
    _enemyResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.615, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//enemyTextFrame1];
    [_enemyResultLabel setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _enemyResultLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_enemyResultLabel];
    
    _enemyResultLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(leftmargin + width * 0.675, (SCREEN_HEIGHT * 0.761) + statusBarHeight, width * 0.0688, SCREEN_HEIGHT * 0.01818)];//enemyTextFrame2];
    [_enemyResultLabel2 setFont:[UIFont fontWithName:@"TradeGothicLT-CondEighteen" size:typesize]];
    _enemyResultLabel2.textColor = [UIColor blackColor];
    [self.view addSubview:_enemyResultLabel2];

}
-(void) performQuery {
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"wallofwar" ofType:@"sqlite"];
    
    sqlite3 *db;
    sqlite3_stmt *statement;
    
    //[self getUserInput];
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        //NSLog(@"SUCCESSS");
        if (!searchButtonPressed) {
            if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                //NSLog(@"in while..");
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSString *type = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *category = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *region = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    NSString *attackon = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    //check for duplicates
                    //assign attackOn
                    //NOTE: it's overwritten because there should only ever be one result
                    attackOn = attackon;
                    
                    if (![categoryIconArray containsObject:category] && !catIconSelected) {
                        [categoryIconArray addObject:category];
                        if ([category containsString:@"_"]) {
                            category = [category stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                        }
                        [categoryNames addObject:category];
                    }
                    if (![regionIconArray containsObject:region] && (!regionIconSelected && catIconSelected)) {
                        [regionIconArray addObject:region];
                        
                        if ([region containsString:@"_"]) {
                            region = [region stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                        }

                        [regionNames addObject:region];
                    }
                    
                }//while
                
            }//if
            
        }
        else{
            query = [query stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            query = [query stringByReplacingOccurrencesOfString:@"wowIndex" withString:@"wow"];
            query = [NSString stringWithFormat:@"%@ AND region = \"%@\" AND attackon =\"%@\"", query, selectedRegion, attackOn];
            [self checkForWoundedAndKilled];
            
            if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                //NSLog(@"SUCCESSS");
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    //NSLog(@"in while..");
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
                if ([_results count] > 0) {
                    [self formatResults];
                    currIndex = currIndex + 1;
                    [_currRec setText:[NSString stringWithFormat:@"%i", currIndex]];
                    [_totalRec setText:[NSString stringWithFormat:@"%lu", (unsigned long)[_results count]]];
                }
                else{
                    //NSLog(@"NO RESULTS");
                }
            }
        }
    }//if
}//performQuery

-(bool)isValidQuery{
    if (selectedType && selectedCategory && selectedRegion && selectedAttackIcon) {
        return TRUE;
    }
    else{
        _properQueryImage.hidden = NO;
        return FALSE;
    }
}

-(void)checkForWoundedAndKilled{
    if (selectedFwiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedFwiaIcon.tag forWok:@"friendlywia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
        
    }
    if (selectedFkiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedFkiaIcon.tag forWok:@"friendlykia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
    }
    if (selectedCwiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedCwiaIcon.tag forWok:@"civilianwia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
    }
    if (selectedCkiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedCkiaIcon.tag forWok:@"civiliankia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
    }
    if (selectedEwiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedEwiaIcon.tag forWok:@"enemywia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
    }
    if (selectedEkiaIcon.tag > 0) {
        NSString *s = [self getValue:selectedEkiaIcon.tag forWok:@"enemykia"];
        query = [NSString stringWithFormat:@"%@ %@", query, s];
    }
}
-(NSString *)getValue:(int)tag forWok:(NSString *)wok{
    NSString *val;
    
    switch (tag) {
        case 1:
            val = [NSString stringWithFormat:@"AND %@ >=0 and %@ < 11", wok, wok];
            break;
        case 2:
            val = [NSString stringWithFormat:@"AND %@ >10 and %@ < 21", wok, wok];
            break;
        case 3:
            [NSString stringWithFormat:@"AND %@ >20 and %@ < 51", wok, wok];
            break;
        case 4:
            val = [NSString stringWithFormat:@"AND %@ >50 and %@ < 101", wok, wok];
            break;
        case 5:
            val = [NSString stringWithFormat:@"AND %@ >100 and %@ is not ''", wok, wok];
            break;
        default:
            break;
    }
    
    return val;
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
    [_friendlyResultLabel setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:5]]];
    [_friendlyResultLabel2 setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:6]]];
    [_civilianResultLabel setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:7]]];
    [_civilianResultLabel2 setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:8]]];
    [_enemyResultLabel setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:9]]];
    [_enemyResultLabel2 setText:[NSString stringWithFormat:@"%@", [data objectAtIndex:10]]];
}//formatResults

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}//textFieldShould*/

-(IBAction)searchButtonPressed:(id)sender{
    if (!searchButtonPressed && [self isValidQuery]) {
        searchButtonPressed = true;
        [self performQuery];
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
    _friendlyResultLabel2.text = NULL;
    _civilianResultLabel.text = NULL;
    _civilianResultLabel2.text = NULL;
    _enemyResultLabel.text = NULL;
    _enemyResultLabel2.text = NULL;
    _currRec.text = NULL;
    _totalRec.text = NULL;
    _timeLabel.text = NULL;
    _properQueryImage.hidden = TRUE;
    //NSLog(@"TypeExpanded Before: %d",typeExpanded);
    //NSLog(@"TypeIconSelected Before: %d", typeIconSelected);
    typeIconSelected = false;
    catIconSelected = false;
    attackIconSelcted = false;
    regionIconSelected = false;
    [self resetIconTrayFrame];
    [self resetIconTrayColors];
    //NSLog(@"TypeExpanded After: %d",typeExpanded);
    //NSLog(@"TypeIconSelected After: %d", typeIconSelected);
    selectedTypeIcon.hidden = YES;
    selectedCatIcon.hidden = YES;
    selectedAttackIcon.hidden = YES;
    selectedRegionIcon.hidden = YES;
    selectedEkiaIcon.hidden = YES;
    selectedEwiaIcon.hidden = YES;
    selectedFkiaIcon.hidden = YES;
    selectedFwiaIcon.hidden = YES;
    selectedCkiaIcon.hidden = YES;
    selectedCwiaIcon.hidden = YES;
    [self setUpTypeIconArray];
    typeExpanded = false;
    categoryExpanded = false;
    regionExpanded = false;
    fwiaExpanded = false;
    fkiaExpanded = false;
    ckiaExpanded = false;
    cwiaExpanded = false;
    ewiaExpanded = false;
    ekiaExpanded = false;
    
}//clearButtonPressed

-(IBAction)nextButtonPressed:(id)sender{
    if (currIndex < [_results count]){
        [self formatResults];
        //NSLog(@"here");
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
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"TOUCH ENDED");
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    //[self resetIconTrayColors];
    CGRect newFrame;
    if (CGRectContainsPoint(_typeIconTray.frame, touch) && (!categoryExpanded && !regionExpanded && !typeExpanded && !typeIconSelected)) {
        [self changeTypeIconTrayColors];
        [UIView animateWithDuration:0.3
                         animations:^{
                             _typeIconTray.frame = CGRectMake(leftmargin + width * 0.025, (SCREEN_HEIGHT * 0.015) + statusBarHeight, width * 0.95, SCREEN_HEIGHT * stdHeight); //
                             _attackOnIconTray.hidden = YES;
                             _regionIconTray.hidden = YES;
                             typeExpanded = true;
                         }];
        [self displayTypeIcons];
        
    }
    else if (typeExpanded && !typeIconSelected) {
        //NSLog(@"in else if");
        for (int i = 0; i<[typeIconIndex count]; i++) {
           // NSLog(@"in for loop");
            UIImageView *icon = [typeIconDictionary objectForKey:[typeIconIndex objectAtIndex:i]];
            if (CGRectContainsPoint(icon.frame, touch)) {
                //NSLog(@"match!");
                [self selectedIcon:i];
                [self resetIconTrayFrame];
            }//if
        }//for
    }//if
    else if (categoryExpanded && !catIconSelected){
        for (int i = 0; i<[categoryIconArray count]; i++) {
            UIImageView *icon = [categoryIconArray objectAtIndex:i];
            if (CGRectContainsPoint(icon.frame, touch)) {
                [self selectedIcon:i];
                [self resetIconTrayFrame];
            }
        }
    }
    else if (CGRectContainsPoint(_categoryIconTray.frame, touch) && (!catIconSelected && !categoryExpanded && !typeExpanded && !regionExpanded && typeIconSelected)){
        newFrame = _categoryIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.015) + statusBarHeight;
        //newFrame.size.width += (SCREEN_WIDTH * 0.3627);
        //newFrame.size.height += (SCREEN_WIDTH * 0.3627);
        newFrame.size.width += (width * 0.4875);
        newFrame.size.height += (width * 0.4875);
        
        [UIView animateWithDuration:0.3 animations:^{
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
            categoryExpanded = true;
            selectedTypeIcon.hidden = YES;}];
        [self displayCategoryIcons];
    }
    else if (CGRectContainsPoint(_regionIconTray.frame, touch) && (!regionExpanded && !regionIconSelected && !typeExpanded && !categoryExpanded && attackIconSelcted)) {
        newFrame = _regionIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.015) + statusBarHeight;
        newFrame.size.height += (SCREEN_HEIGHT * 0.1375);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             _regionIconTray.frame = newFrame;
                             _attackOnIconTray.hidden = YES;
                             selectedAttackIcon.hidden = YES;
                             regionExpanded = true;
                         }];
        [self displayRegionIcons];
    }
    else if (regionExpanded && !regionIconSelected){
        for (int i = 0; i<[regionIconArray count]; i++) {
            UIImageView *icon = [regionIconArray objectAtIndex:i];
            if (CGRectContainsPoint(icon.frame, touch)) {
                [self selectedIcon:i];
                [self resetIconTrayFrame];
            }//if
        }//for
    }//else if
    else if (CGRectContainsPoint(currWokView.frame,touch)){
        for (int i = 0; i<[currWokArray count]; i++) {
            UIImageView *icon = [currWokArray objectAtIndex:i];
            if (CGRectContainsPoint(icon.frame, touch)) {
                [self selectedIcon:i];
                [self resetIconTrayFrame];
            }
        }
    }
    else if (CGRectContainsPoint(_fwiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _fwiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _fwiaIconTray.frame = newFrame;
                             _cwiaIconTray.hidden = YES;
                             _ewiaIconTray.hidden = YES;
                         }];
        [self displayWoKIcons:_fwiaIconTray];
        wokViewSelected = true;
        currWokView = _fwiaIconTray;
        fwiaExpanded = true;
    }
    else if (CGRectContainsPoint(_fkiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _fkiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _fkiaIconTray.frame = newFrame;
                             _ckiaIconTray.hidden = YES;
                             _ekiaIconTray.hidden = YES;
                         }];
        [self displayWoKIcons:_fkiaIconTray];
        wokViewSelected = true;
        currWokView = _fkiaIconTray;
        fkiaExpanded = true;
    }
    else if (CGRectContainsPoint(_cwiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _cwiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _cwiaIconTray.frame = newFrame;
                             _ewiaIconTray.hidden = YES;
                         }];
        [self displayWoKIcons:_cwiaIconTray];
        wokViewSelected = true;
        currWokView = _cwiaIconTray;
        cwiaExpanded = true;
    }
    else if (CGRectContainsPoint(_ckiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _ckiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _ckiaIconTray.frame = newFrame;
                             _ekiaIconTray.hidden = YES;
                         }];
        [self displayWoKIcons:_ckiaIconTray];
        wokViewSelected = true;
        currWokView = _ckiaIconTray;
        ckiaExpanded = true;
    }
    else if (CGRectContainsPoint(_ewiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _ewiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _ewiaIconTray.frame = newFrame;
                             [self.view bringSubviewToFront:_ewiaIconTray];
                         }];
        [self displayWoKIcons:_ewiaIconTray];
        wokViewSelected = true;
        currWokView = _ewiaIconTray;
        ewiaExpanded = true;
    }
    else if (CGRectContainsPoint(_ekiaIconTray.frame, touch) && (!wokViewSelected && wOkEnabled)){
        newFrame = _ekiaIconTray.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.219;
        [UIView animateWithDuration:0.3
                         animations:^{
                             _ekiaIconTray.frame = newFrame;
                             [self.view bringSubviewToFront:_ekiaIconTray];
                         }];
        [self displayWoKIcons:_ekiaIconTray];
        wokViewSelected = true;
        currWokView = _ekiaIconTray;
        ekiaExpanded = true;
    }

}
-(void)displayWoKIcons:(UIView *)wOkView{
    currWokArray = [[NSMutableArray alloc] init];
    UIImageView *icon;
    for (int i=0; i<5; i++) {
        CGRect iconFrame = CGRectMake(wOkView.frame.origin.x, (wOkView.frame.origin.y - (SCREEN_HEIGHT *0.03) + (SCREEN_HEIGHT * (0.042 * i))) + statusBarHeight, width * 0.173, SCREEN_HEIGHT * 0.042);
        icon = [[UIImageView alloc] initWithFrame:iconFrame];
        [icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Wok%u", i+1]]];
        [self.view addSubview:icon];
        icon.alpha = 0.0;
        [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * i) options:UIViewAnimationOptionCurveEaseIn animations:^{
            icon.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
        icon.userInteractionEnabled = YES;
        [currWokArray addObject:icon];
    }
}
-(void)displayTypeIcons{
    UIImageView *icon;
    for (int i = 0; i<[typeIconIndex count]; i++) {
        if (i<8) {
            //CGRect iconFrame = CGRectMake(((SCREEN_WIDTH * 0.1658) + ((0.0862 * SCREEN_WIDTH) *i)), (SCREEN_HEIGHT* 0.06) + statusBarHeight, SCREEN_WIDTH * 0.0672, SCREEN_HEIGHT * 0.0504);
            //CGRect iconFrame = CGRectMake(((SCREEN_WIDTH * 0.05) + ((0.105 * SCREEN_WIDTH) *i)), (SCREEN_HEIGHT* 0.06) + statusBarHeight, SCREEN_WIDTH * 0.08, SCREEN_HEIGHT * 0.04587);
            CGRect iconFrame = CGRectMake(((leftmargin + width * 0.05) + ((0.105 * width) *i)), (SCREEN_HEIGHT* 0.06) + statusBarHeight, width * 0.08, SCREEN_HEIGHT * 0.04587);
            
            icon = [[UIImageView alloc] initWithFrame:iconFrame];
            //UIImage *img = [typeIconDictionary objectForKey:[typeIconIndex objectAtIndex:i]];
            [icon setImage:[typeIconDictionary objectForKey:[typeIconIndex objectAtIndex:i]]];
            
            [self.view addSubview:icon];
            icon.hidden = NO;
            icon.alpha = 0.0;
            [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * i) options:UIViewAnimationOptionCurveEaseIn animations:^{
                icon.alpha = 1.0;
            } completion:^(BOOL finished) {
            }];
            icon.userInteractionEnabled = YES;
            [typeIconDictionary setObject:icon forKey:[typeIconIndex objectAtIndex:i]];
        }
        else{
            int j = i - 8;
            //CGRect iconFrame = CGRectMake(((SCREEN_WIDTH * 0.1658) + ((0.0862 * SCREEN_WIDTH) *j)), (SCREEN_HEIGHT* 0.06) + (SCREEN_HEIGHT * 0.065) + statusBarHeight, SCREEN_WIDTH * 0.0672, SCREEN_HEIGHT * 0.0504);
            CGRect iconFrame = CGRectMake(((leftmargin + width * 0.05) + ((0.105 * width) *j)), (SCREEN_HEIGHT* 0.06) + (SCREEN_HEIGHT * 0.065) + statusBarHeight, width * 0.08, SCREEN_HEIGHT * 0.04587);
             icon = [[UIImageView alloc] initWithFrame:iconFrame];
             [icon setImage:[typeIconDictionary objectForKey:[typeIconIndex objectAtIndex:i]]];
             [self.view addSubview:icon];
             icon.hidden = NO;
             icon.alpha = 0.0;
             [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * i) options:UIViewAnimationOptionCurveEaseIn animations:^{
             icon.alpha = 1.0;
             } completion:^(BOOL finished) {
             }];
            icon.userInteractionEnabled = YES;
            [typeIconDictionary setObject:icon forKey:[typeIconIndex objectAtIndex:i]];
        }//else
        
    }//for
}
-(void)displayCategoryIcons{
    categoryIconArray = [[NSMutableArray alloc]init];
    categoryNames = [[NSMutableArray alloc] init];
    UIImageView *icon;
    NSString *unfilteredType = [typeIconIndex objectAtIndex:selectedTypeIcon.tag];
    NSString *type = [typeIconIndex objectAtIndex:selectedTypeIcon.tag];
    if ([type containsString:@"_"]) {
        type = [type stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    }
    selectedType = type;
    query = [NSString stringWithFormat:@"SELECT * FROM wowIndex WHERE type = \"%@\"", unfilteredType];
    [self performQuery];
    
    int j = 0;
    int length = [categoryIconArray count];
    if (length > 8) {
        j = floor(length/8);
    }
    //int bound2 = length - (8 * j);
    int row = 0;
    while (row <j+1) {
        for (int i = 0; i<length; i++) {
            if (i>0 && i%8==0) {
                row++;
            }
            //CGFloat x = (((i -(8*row)) * (width * 0.0862)) + (width * 0.1658));
            CGFloat x = (leftmargin + ((i -(8*row)) * (width * 0.105)) + (width * 0.05));
            // CGRect frame = CGRectMake(x, ((SCREEN_HEIGHT* 0.06) * (row + 1)) + statusBarHeight,width * 0.0672,SCREEN_HEIGHT * 0.0504);
            CGRect frame = CGRectMake(x, ((SCREEN_HEIGHT* 0.06) * (row + 1)) + statusBarHeight,width * 0.08,SCREEN_HEIGHT * 0.04587);
            icon = [[UIImageView alloc]initWithFrame:frame];
            NSString *fileName = [categoryIconArray objectAtIndex:(i)];
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", fileName]];
            [icon setImage:img];
            [self.view addSubview:icon];
            icon.alpha = 0.0;
            [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * (i  + (2 * row))) options:UIViewAnimationOptionCurveEaseIn animations:^{
                icon.alpha = 1.0; }
                             completion:^(BOOL finished) {
                             }];
            icon.userInteractionEnabled = YES;
            [categoryIconArray replaceObjectAtIndex:i withObject:icon];
        }
        break;
    }
}
-(void)displayRegionIcons{
    regionIconArray = [[NSMutableArray alloc] init];
    UIImageView *icon;
    regionNames = [[NSMutableArray alloc] init];
    selectedCategory = [selectedCategory stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    query = [NSString stringWithFormat:@"%@ AND category =\"%@\"", query, selectedCategory];
    [self performQuery];
    int length = [regionIconArray count];
    int j = 0;
    if (length > 3) {
        j = floor(length/3);
    }
    int row = 0;
    while (row < j+1) {
        for (int i = 0; i<length; i++) {
            if (i>0 && i%3==0) {
                row++;
            }
            //CGFloat x = (((i -(3*row)) * (width * 0.115)) + (width * 0.5136));
            // CGRect frame = CGRectMake(x, ((SCREEN_HEIGHT* 0.04215) * (row + 1)) + statusBarHeight + (SCREEN_HEIGHT * 0.015), width * 0.1, SCREEN_HEIGHT * 0.0355);
            CGFloat x = (leftmargin + ((i -(3*row)) * (width * 0.1569)) + (width * 0.5125));
            CGRect frame = CGRectMake(x, ((SCREEN_HEIGHT* 0.04215) * (row + 1)) + statusBarHeight + (SCREEN_HEIGHT * 0.015), width * 0.1319, SCREEN_HEIGHT * 0.0355);
            icon = [[UIImageView alloc]initWithFrame:frame];
            NSString *filename = [NSString stringWithFormat:@"%@.png", [regionIconArray objectAtIndex:i]];
            if ([filename containsString:@"SELECTED"]) {
                filename = [filename stringByReplacingOccurrencesOfString:@"SELECTED" withString:@"SELECTEDREGION"];
            }
            UIImage *img = [UIImage imageNamed:filename];
            [icon setImage:img];
            icon.alpha = 0.0;
            [self.view addSubview:icon];
            [UIView animateWithDuration:0.3 delay:0.3 + (0.1 * (i  + (2 * row))) options:UIViewAnimationOptionCurveEaseIn animations:^{
                icon.alpha = 1.0; }
                             completion:^(BOOL finished) {
                             }];
            
            icon.userInteractionEnabled = YES;
            [regionIconArray replaceObjectAtIndex:i withObject:icon];
        }//for
        break;
    }
}
-(void)selectedIcon:(int)i{
    if (typeExpanded) {
        //set selected icon within type icon tray frame
        //CGRect typeFrame = CGRectMake(leftmargin + width * 0.2268, SCREEN_HEIGHT * 0.075 + statusBarHeight, width * 0.18375, SCREEN_HEIGHT * 0.14);
        CGRect typeFrame = CGRectMake(leftmargin + width * 0.125, SCREEN_HEIGHT * 0.075 + statusBarHeight, width * 0.244, SCREEN_HEIGHT * 0.14);
        selectedTypeIcon = [[UIImageView alloc] initWithFrame:typeFrame];
        //UIImageView *img = [typeIconIndex objectAtIndex:i];
        [selectedTypeIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [typeIconIndex objectAtIndex:i]]]];
        selectedTypeIcon.tag = i;
        [self.view addSubview:selectedTypeIcon];
        //[self.view addSubview:img];
        [self changeCatIconTrayColors];
        typeIconSelected = TRUE;
    }
    else if (categoryExpanded) {
        //set selected icon within type icon tray frame
        CGRect typeFrame = CGRectMake(leftmargin + width * 0.125, SCREEN_HEIGHT * 0.3676 + statusBarHeight, width * 0.244, SCREEN_HEIGHT * 0.14);
        selectedCatIcon = [[UIImageView alloc] initWithFrame:typeFrame];
        UIImageView *img = [categoryIconArray objectAtIndex:i];
        selectedCategory = [categoryNames objectAtIndex:i];
        [selectedCatIcon setImage:img.image];
        [self.view addSubview:selectedCatIcon];
        //[self.view addSubview:img];
        [self changeRegionIconTrayColors];
        catIconSelected = TRUE;
    }
    else if(regionExpanded){
        //CGRect frame = CGRectMake(leftmargin + width * 0.5572, SCREEN_HEIGHT * 0.216 + statusBarHeight, width * 0.18375, SCREEN_HEIGHT * 0.0657);
        CGRect frame = CGRectMake(leftmargin + width * 0.62175, SCREEN_HEIGHT * 0.20 + statusBarHeight, width * 0.244, SCREEN_HEIGHT * 0.0657);
        selectedRegionIcon = [[UIImageView alloc] initWithFrame:frame];
        UIImageView *img = [regionIconArray objectAtIndex:i];
        selectedRegion = [regionNames objectAtIndex:i];
        [selectedRegionIcon setImage:img.image];
        [self.view addSubview:selectedRegionIcon];
        regionIconSelected = true;
        wOkEnabled = YES;
        selectedAttackIcon.hidden = NO;
    }
    else if(ekiaExpanded){
        CGRect frame = CGRectMake(leftmargin + width * 0.7975, (SCREEN_HEIGHT * 0.474) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065);//ekiaTrayFrame;
        selectedEkiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedEkiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedEkiaIcon setImage:icon.image];
        [self.view addSubview:selectedEkiaIcon];
        ekiaExpanded = false;
        wOkQuery = true;
    }
    else if (ewiaExpanded){
        CGRect frame = CGRectMake(leftmargin + width* 0.5125, (SCREEN_HEIGHT * 0.474) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065);//ewiaTrayFrame;
        selectedEwiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedEwiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedEwiaIcon setImage:icon.image];
        [self.view addSubview:selectedEwiaIcon];
        ewiaExpanded = false;
        wOkQuery = true;
    }
    else if (cwiaExpanded){
        CGRect frame = CGRectMake(leftmargin + width * 0.5125, (SCREEN_HEIGHT * 0.397) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065);//cwiaTrayFrame;
        selectedCwiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedCwiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedCwiaIcon setImage:icon.image];
        [self.view addSubview:selectedCwiaIcon];
        cwiaExpanded = false;
        wOkQuery = true;
    }
    else if (ckiaExpanded){
        CGRect frame = CGRectMake(leftmargin + width* 0.7975, (SCREEN_HEIGHT * 0.397) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065);//ckiaTrayFrame;
        selectedCkiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedCkiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedCkiaIcon setImage:icon.image];
        [self.view addSubview:selectedCkiaIcon];
        ckiaExpanded = false;
        wOkQuery = true;
    }
    else if (fwiaExpanded){
        CGRect frame = CGRectMake(leftmargin + width* 0.5125, (SCREEN_HEIGHT * 0.32) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065); //fwiaTrayFrame;
        selectedFwiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedFwiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedFwiaIcon setImage:icon.image];
        [self.view addSubview:selectedFwiaIcon];
        fwiaExpanded = false;
        wOkQuery = true;
    }
    else{
        CGRect frame = CGRectMake(leftmargin + width * 0.7975, (SCREEN_HEIGHT * 0.32) + statusBarHeight, width * 0.177, SCREEN_HEIGHT * 0.065); //fkiaTrayFrame;
        selectedFkiaIcon = [[UIImageView alloc] initWithFrame:frame];
        selectedFkiaIcon.tag = i + 1;
        UIImageView *icon = [currWokArray objectAtIndex:i];
        [selectedFkiaIcon setImage:icon.image];
        [self.view addSubview:selectedFkiaIcon];
        fkiaExpanded = false;
        wOkQuery = true;
    }
}
-(void)setAttackIcon{
    //CGRect frame = CGRectMake(leftmargin + width * 0.5572, SCREEN_HEIGHT * 0.0708 + statusBarHeight, width * 0.18375, SCREEN_HEIGHT * 0.0657);
    CGRect frame = CGRectMake(leftmargin + width * 0.68, SCREEN_HEIGHT * 0.0608 + statusBarHeight, width * 0.244, SCREEN_HEIGHT * 0.0657);
    
    selectedAttackIcon = [[UIImageView alloc] initWithFrame:frame];
    [selectedAttackIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Attack_%@.png", attackOn]]];
    [self.view addSubview:selectedAttackIcon];
    attackIconSelcted = TRUE;
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
-(void)changeRegionIconTrayColors{
    _regionIconTray.layer.borderColor = selectedRed.CGColor;
    _regionIconTrayLabel.textColor = selectedRed;
}
-(void)resetIconTrayFrame{
    CGRect newFrame;
    if(typeExpanded){
        //newFrame = _typeIconTray.frame;
        //newFrame.size.width -= (SCREEN_WIDTH * 0.3627);
        
        [UIView animateWithDuration:0.0
                         animations:^{
                             _typeIconTray.frame = CGRectMake(leftmargin + width * 0.025, (SCREEN_HEIGHT * 0.015) + statusBarHeight, width * stdWidth, SCREEN_HEIGHT * stdHeight);//typetrayframe
                             _attackOnIconTray.hidden = NO;
                             _regionIconTray.hidden = NO;
                             typeExpanded = false;
                             //typeIconSelected = false;
                         }];
        
        for (int i = 0; i<[typeIconIndex count]; i++) {
            UIImageView *icon = [typeIconDictionary objectForKey:[typeIconIndex objectAtIndex:i]];
            icon.alpha = 0.0;
            icon.userInteractionEnabled = NO;
            [typeIconDictionary setObject:icon forKey:[typeIconIndex objectAtIndex:i]];
        }

    }
    if (categoryExpanded){
        newFrame = _categoryIconTray.frame;
        newFrame.origin.y = (SCREEN_HEIGHT * 0.29) +statusBarHeight;
        //newFrame.size.width -= (SCREEN_WIDTH * 0.3627);
        //newFrame.size.height -= (SCREEN_WIDTH * 0.3627);
        newFrame.size.width -= (width * 0.4875);
        newFrame.size.height -= (width * 0.4875);
        
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
            selectedTypeIcon.hidden = NO;
            categoryExpanded = false;
            _categoryIconTray.layer.borderColor = iconTrayBorderColor;
            _categoryIconTrayLabel.textColor = iconTrayLabelColor;
        }];
        
        for (int i = 0; i<[categoryIconArray count]; i++) {
            UIImageView *icon = [categoryIconArray objectAtIndex:i];
            icon.alpha = 0.0;
            icon.userInteractionEnabled = NO;
            [categoryIconArray replaceObjectAtIndex:i withObject:icon];
        }
        
        [self setAttackIcon];
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
                             _regionIconTray.layer.borderColor = iconTrayBorderColor;
                             _regionIconTrayLabel.textColor = iconTrayLabelColor;
                         }];
        for (int i = 0; i<[regionIconArray count]; i++) {
            UIImageView *icon = [regionIconArray objectAtIndex:i];
            icon.alpha = 0.0;
            icon.userInteractionEnabled = NO;
            [regionIconArray replaceObjectAtIndex:i withObject:icon];
        }
    }
    if (wokViewSelected) {
        newFrame = currWokView.frame;
        newFrame.size.height = SCREEN_HEIGHT * 0.065;
        [UIView animateWithDuration:0.0
                         animations:^{
                             currWokView.frame = newFrame;
                             //[self.view bringSubviewToFront:_ekiaIconTray];
                             wokViewSelected = false;
                             currWokView = NULL;
                             _cwiaIconTray.hidden = NO;
                             _ckiaIconTray.hidden = NO;
                             _ewiaIconTray.hidden = NO;
                             _ekiaIconTray.hidden = NO;
                         }];
        
        for (int i = 0; i<5; i++) {
            UIImageView *icon = [currWokArray objectAtIndex:i];
            icon.alpha = 0.0;
            icon.userInteractionEnabled = NO;
            [currWokArray replaceObjectAtIndex:i withObject:icon];
        }
    }
    
}

@end

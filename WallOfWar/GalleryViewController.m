//
//  GalleryViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 1/7/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController (){
    NSMutableArray *icons;
    int width;
    int typesize;
    int leftmargin;
    int textsmall;
}

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:(248.0/255.0) green:(244.0/255.0) blue:(219.0/255.0) alpha:1.0]];

    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{

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

    //setup flowlayout
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(width * .16, SCREEN_HEIGHT * .09)];
    [flow setMinimumLineSpacing:10.0f];
    [flow setMinimumInteritemSpacing:SCREEN_WIDTH *0.32];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flow setHeaderReferenceSize:CGSizeMake(320, 50)];
    
    //setup collectionview
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
     _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:_collectionView];
   
    // Build the array from the plist
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Complete" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    icons = [[NSMutableArray alloc] init];
    for (NSString *s in array) {
        //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", s]];
        [icons addObject:s];
    }
    
    int i;
    
}
#pragma mark - UICollectionViewDataSource protocols
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return icons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImage *cellImage = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cellImage];
    cell.backgroundView = imageView;
    cell.backgroundColor = [UIColor clearColor];
    //check for labels
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    NSString *text = [self formatText:[icons objectAtIndex:indexPath.row]];
    
    if ([text length] != 0) {
        [self getLabel:cell forText:text];
    }
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SCREEN_HEIGHT * .05,SCREEN_WIDTH *0.025,0,SCREEN_WIDTH * 0.32);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableView==nil) {
            reusableView=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        }
        
        UIImage *headerImage = [UIImage imageNamed:@"galleryheader.png"];
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, width, SCREEN_HEIGHT * 0.0967)];
        headerView.image = headerImage;
        [reusableView addSubview:headerView];
        return reusableView;
    }
    
    return nil;
}
- (NSString *)formatText:(NSString *)text{
    if ([text containsString:@"_"]) {
        text = [text stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    }
    if ([text containsString:@".png"]) {
        text = [text stringByReplacingOccurrencesOfString:@".png" withString:@""];
    }
    if ([text containsString:@"TITLE"]) {
        text = @"";
    }
    return text;
}

- (UICollectionViewCell *)getLabel:(UICollectionViewCell *)cell forText:(NSString *)text{
    
    //label for cells
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *.185, 0, SCREEN_WIDTH * .2, SCREEN_HEIGHT * 0.1)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.text = text;
    label.font = [label.font fontWithSize:typesize];
    [[cell contentView] addSubview:label];
    
    return cell;
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

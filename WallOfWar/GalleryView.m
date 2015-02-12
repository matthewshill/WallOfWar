//
//  GalleryView.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 2/12/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import "GalleryView.h"

@implementation GalleryView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
-(void)setup{
    NSLog(@"setup");
    //setup flowlayout
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(SCREEN_WIDTH * .16, SCREEN_HEIGHT * .09)];
    [flow setMinimumLineSpacing:10.0f];
    [flow setMinimumInteritemSpacing:SCREEN_WIDTH *0.32];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flow setHeaderReferenceSize:CGSizeMake(320, 50)];
    
    //setup collectionview
    self.collectionView = [[UICollectionView alloc] initWithFrame:[self frame] collectionViewLayout:flow];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self addSubview:_collectionView];
    
    // Build the array from the plist
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Complete" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.icons = [[NSMutableArray alloc] init];
    for (NSString *s in array) {
        //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", s]];
        [self.icons addObject:s];
    }
    
}
#pragma mark - UICollectionViewDataSource protocols
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.icons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"collection");
    UIImage *cellImage = [UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
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
    
    NSString *text = [self formatText:[self.icons objectAtIndex:indexPath.row]];
    
    if ([text length] != 0) {
        [self getLabel:cell forText:text];
    }
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake((SCREEN_HEIGHT * .025) + statusBarHeight,SCREEN_WIDTH *0.025,0,SCREEN_WIDTH * 0.32);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableView==nil) {
            reusableView=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        }
        
        UIImage *headerImage = [UIImage imageNamed:@"galleryheader.png"];
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, statusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT * 0.0967)];
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
    label.font = [label.font fontWithSize:10.8];
    [[cell contentView] addSubview:label];
    
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  GalleryViewController.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 1/7/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController (){
    NSMutableArray *typeIcons;
}
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setup];
    //setup collectionview
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(60, 60)];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    //[self.collectionView initWithFrame:self.view.frame set]
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"TypeIcons" ofType:@"plist"];
    // Build the array from the plist
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    typeIcons = [[NSMutableArray alloc] init];
    for (NSString *s in array) {
        //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", s]];
        [typeIcons addObject:s];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)setup{
    //setup collectionview
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(60, 60)];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    //[self.collectionView initWithFrame:self.view.frame set]
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"TypeIcons" ofType:@"plist"];
    // Build the array from the plist
    NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    typeIcons = [[NSMutableArray alloc] init];
    for (NSString *s in array) {
        //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", s]];
        [typeIcons addObject:s];
    }
}*/
#pragma mark - UICollectionViewDataSource protocols
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return typeIcons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *typeImageView = (UIImageView *)[cell viewWithTag:100];
    typeImageView.image = [UIImage imageNamed:[typeIcons objectAtIndex:indexPath.row]];
    
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

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
    
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    
    //setup collectionview
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(SCREEN_WIDTH * .16, SCREEN_HEIGHT * .09)];
    [flow setMinimumLineSpacing:50.0f];
    [flow setMinimumInteritemSpacing:SCREEN_WIDTH *0.32];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
     _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
   
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
#pragma mark - UICollectionViewDataSource protocols
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return typeIcons.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImage *cellImage = [UIImage imageNamed:[typeIcons objectAtIndex:indexPath.row]];
    UIImageView *typeImageView = [[UIImageView alloc] initWithImage:cellImage];
    cell.backgroundView = typeImageView;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,SCREEN_WIDTH *0.025,0,SCREEN_WIDTH * 0.32);
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

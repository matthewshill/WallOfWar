//
//  GalleryView.h
//  WallOfWar
//
//  Created by Matthew S. Hill on 2/12/15.
//  Copyright (c) 2015 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *icons;
@end

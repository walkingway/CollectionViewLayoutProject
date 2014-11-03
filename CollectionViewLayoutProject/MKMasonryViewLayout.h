//
//  MKMasonryViewLayout.h
//  CollectionViewLayoutProject
//
//  Created by cheng way on 11/2/14.
//  Copyright (c) 2014 walkingway. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMasonryViewLayout;

@protocol MKMasonryViewLayoutDelegate
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MKMasonryViewLayout *)collectionViewLayout  heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MKMasonryViewLayout : UICollectionViewLayout
@property (nonatomic, assign)CGFloat interItemSpacing;
@property (nonatomic, assign)NSInteger numberOfColumns;
//此行代码如何链接到SB中
@property (nonatomic, weak)IBOutlet id<MKMasonryViewLayoutDelegate> delegate;

@end

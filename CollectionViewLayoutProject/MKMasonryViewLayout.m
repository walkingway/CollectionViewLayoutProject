//
//  MKMasonryViewLayout.m
//  CollectionViewLayoutProject
//
//  Created by cheng way on 11/2/14.
//  Copyright (c) 2014 walkingway. All rights reserved.
//

#import "MKMasonryViewLayout.h"
@interface MKMasonryViewLayout ()

@property (nonatomic, strong)NSMutableDictionary *lastYValueForColumn;
@property (nonatomic, strong)NSMutableDictionary *layoutInfo;
@end

@implementation MKMasonryViewLayout

- (void)prepareLayout {
  self.numberOfColumns = 3;
  self.interItemSpacing = 12.5;
  
  self.lastYValueForColumn = [NSMutableDictionary dictionary];
  self.layoutInfo = [NSMutableDictionary dictionary];
  NSInteger currentColumn = 0;
  // 得到单个item的宽度
  CGFloat fullWidth = self.collectionView.frame.size.width;
  NSLog(@"fullWidth is %f", fullWidth);
  CGFloat availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfColumns + 1));
  CGFloat itemWidth = availableSpaceExcludingPadding / self.numberOfColumns;
  //遍历每一个item
  NSInteger numSections = [self.collectionView numberOfSections];
  for (NSInteger section = 0; section < numSections; section++) {
    NSInteger numItem = [self.collectionView numberOfItemsInSection:section];
    for (NSInteger item = 0; item < numItem; item++) {
      //计算每个item的size
      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
      UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
      
      CGFloat X = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
      CGFloat Y = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
      
      CGFloat height = [(id<MKMasonryViewLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
      itemAttributes.frame = CGRectMake(X, Y, itemWidth, height);
      
      //为下一次Y做准备
      Y += height;
      Y += self.interItemSpacing;
      self.lastYValueForColumn[@(currentColumn)] = @(Y);
      currentColumn++;
      if (currentColumn == self.numberOfColumns) {
        currentColumn = 0;
      }
      self.layoutInfo[indexPath] = itemAttributes;
    }
  }
}

- (CGSize)collectionViewContentSize {
  
  NSInteger currentColumn = 0;
  CGFloat maxHeight = 0;
  
  do {
    CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
    if (height > maxHeight) {
      maxHeight = height;
    }
    currentColumn ++;
  } while(currentColumn < self.numberOfColumns);
  
  return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
  
  NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];

  [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
    // 判断rect与取出的attributes是否在同一个位置，CGRectIntersectsRect将位于rect这一位置的attributes筛选出来
    if (CGRectIntersectsRect(rect, attributes.frame)) {
      [allAttributes addObject:attributes];
    }
  }];
  
  return allAttributes;
}
@end

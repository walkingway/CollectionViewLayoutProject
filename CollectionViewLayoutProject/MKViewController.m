//
//  ViewController.m
//  CollectionViewLayoutProject
//
//  Created by cheng way on 11/2/14.
//  Copyright (c) 2014 walkingway. All rights reserved.
//

#import "MKViewController.h"


@interface MKViewController ()

@end

@implementation MKViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  cell.backgroundColor = [UIColor redColor];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat randomHeight = 100 + (arc4random() % 140);
  return CGSizeMake(100, randomHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MKMasonryViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat randomHeight = 100 + (arc4random() % 140);
  return randomHeight;
}

@end

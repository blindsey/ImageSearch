//
//  ViewController.m
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import "SearchViewController.h"
#import "GoogleClient.h"
#import "Image.h"
#import "ImageCell.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *images; // of Image

- (void)fetchImages:(NSUInteger)start;

@end

@implementation SearchViewController

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchBar.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.image = (Image *)self.images[indexPath.row];
    return cell;
}

#pragma mark - Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.images removeAllObjects];
    [self.collectionView reloadData];
    [self fetchImages:0];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [searchBar endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - Private methods

- (void)fetchImages:(NSUInteger)start
{
    if (start == 40) {
        [self.collectionView reloadData];
    } else {
        [GoogleClient imagesWithSearchTerm:self.searchBar.text start:start callback:^(NSError *error, NSHTTPURLResponse *response, NSArray *results) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.images addObjectsFromArray:results];
                [self fetchImages:start + 8];
            }
        }];
    }
}

@end

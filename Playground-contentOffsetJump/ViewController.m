//
//  ViewController.m
//  Playground-contentOffsetJump
//
//  Created by Arkadiusz on 13-10-13.
//  Copyright (c) 2013 Arkadiusz Holko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row < 28) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 76;
}

- (void)updateKeyboardConstraint:(CGFloat)height animationDuration:(NSTimeInterval)duration {
    self.bottomSpaceConstraint.constant = height;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{

        [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, height, 0)];

        CGPoint bottomOffset = CGPointMake(0, self.collectionView.contentSize.height - (self.collectionView.bounds.size.height - height));
        [self.collectionView setContentOffset:bottomOffset animated:YES];
        [self.view layoutIfNeeded];

    } completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif
{
    CGFloat height = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self updateKeyboardConstraint:height animationDuration:0.25];
    NSLog(@"%f", height);
}

@end

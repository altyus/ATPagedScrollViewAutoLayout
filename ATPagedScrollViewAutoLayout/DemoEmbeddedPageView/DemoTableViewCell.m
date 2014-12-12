//
//  DemoTableViewCell.m
//  DemoEmbeddedPageView
//
//  Created by AL TYUS on 12/9/14.
//  Copyright (c) 2014 AL TYUS. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "PagedScrollViewAutoLayout.h"

@interface DemoTableViewCell()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;


@property (nonatomic) NSMutableArray *contentViews;
@property (nonatomic) NSMutableArray *contentViewContainers;
@property (nonatomic) NSDictionary *metrics;

@end

@implementation DemoTableViewCell

- (void)awakeFromNib
{
    [self configureScrollView];
}

- (void)configureScrollView
{
    NSArray *images = @[[UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"]];
    
    NSMutableArray *contentViews = [NSMutableArray new];
    
    for (UIImage *image in images)
    {
        NSUInteger index = [images indexOfObject:image];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:images[index]];
        imageView.contentMode = UIViewContentModeScaleAspectFit; 
        [contentViews addObject:imageView];
    }
    
    PagedScrollViewAutoLayout *scrollView = [[PagedScrollViewAutoLayout alloc] initWithContentViews:contentViews];
    
    scrollView.images = images;
    
    [self.contentView addSubview:scrollView];
    
    
    NSDictionary *views = @{@"contentView" : self.contentView,
                            @"scrollView" : scrollView};
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:views]];
    
    
    [self layoutIfNeeded];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self configureScrollView]; 
    }
    
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
}

//- (void)awakeFromNib {
//    // Initialization code
//    
//    self.images = @[[UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"], [UIImage imageNamed:@"Erica"]];
//    
//    for (UIImage *image in self.images)
//    {
//        NSUInteger index = [self.images indexOfObject:image];
//        [self.contentViews addObject:[[UIImageView alloc] initWithImage:self.images[index]]];
//    }
//    
//    self.scrollView.contentOffset = CGPointMake
//    (self.bounds.size.width, 0);
//    
//    [self updateConstraintsIfNeeded];
//    
//}
//
//
//
//
//
//- (NSMutableArray *)contentViews
//{
//    if (!_contentViews)
//    {
//        _contentViews = [NSMutableArray new];
//    }
//    
//    return _contentViews;
//}
//
//- (NSMutableArray *)contentViewContainers
//{
//    if (!_contentViewContainers)
//    {
//        _contentViewContainers = [NSMutableArray new];
//    }
//    
//    return _contentViewContainers;
//}
//
//- (NSDictionary *)metrics
//{
//    return @{@"screenWidth" : @([UIScreen mainScreen].bounds.size.width)};
//}
//
//- (void)updateConstraints
//{
//    [super updateConstraints];
//    
//    [self setupLayoutsForViewsInViewContainers];
//
//}
//
//- (void)setupLayoutsForViewsInViewContainers
//{
//    [self createViewContainers];
//    
//    for (UIView *viewContainer in self.contentViewContainers)
//    {
//        
//        [self configureConstraintsForViewContainer:viewContainer];
//    }
//    
//    for (UIView *view in self.contentViews) {
//        
//        [self configureConstraintsForEmbeddedCenteredView:view];
//    }
// 
//}
//
//- (void)createViewContainers
//{
//    for (UIView *view in self.contentViews)
//    {
//        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
//        UIView *viewContainer = [[UIView alloc] init];
//        [viewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
//        
//        [viewContainer addSubview:view];
//        
//        
//        [self.contentViewContainers addObject:viewContainer];
//        
//        [self.scrollContentView addSubview:viewContainer];
//    }
//}
//
//- (void)configureConstraintsForEmbeddedCenteredView:(UIView *)view
//{
//    NSUInteger index = [self.contentViews indexOfObject:view];
//    
//    UIView *viewContainer = self.contentViewContainers[index];
//    
//    UIView *leadingSpacer = [[UIView alloc] init];
//    UIView *trailingSpacer = [[UIView alloc] init];
//    [leadingSpacer setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [trailingSpacer setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    [viewContainer addSubview:leadingSpacer];
//    [viewContainer addSubview:trailingSpacer];
//    
//    
//    NSDictionary *views = @{@"view" : view,
//                            @"leadingSpacer" : leadingSpacer,
//                            @"trailingSpacer" : trailingSpacer};
//    
//    [viewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leadingSpacer(==trailingSpacer)][view][trailingSpacer(==leadingSpacer)]|" options:0 metrics:self.metrics views:views]];
//    
//    [viewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:self.metrics views:views]];
//
//}
//
//- (void)configureConstraintsForViewContainer:(UIView *)viewContainer
//{
//    NSDictionary *views = @{@"view" : viewContainer};
//    
//    [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:self.metrics views:views]];
//    
//    if ([self.contentViewContainers indexOfObject:viewContainer] == 0)
//    {
//        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(==screenWidth)]" options:0 metrics:self.metrics views:views]];
//    }
//    
//    else if ([self.contentViewContainers indexOfObject:viewContainer] == [self.contentViewContainers count] - 1)
//    {
//        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==screenWidth)]|" options:0 metrics:self.metrics views:views]];
//    }
//    else
//    {
//        NSUInteger index = [self.contentViewContainers indexOfObject:viewContainer];
//        
//        views = @{@"view" : viewContainer,
//                  @"previousView" : self.contentViewContainers[index - 1],
//                  @"nextView" : self.contentViewContainers[index + 1]};
//        
//        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView(==view)][view(==previousView)][nextView(==view)]" options:0 metrics:self.metrics views:views]];
//    }
//}

@end

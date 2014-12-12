//
//  PagedScrollViewAutoLayout.m
//  DemoEmbeddedPageView
//
//  Created by AL TYUS on 12/11/14.
//  Copyright (c) 2014 AL TYUS. All rights reserved.
//

#import "PagedScrollViewAutoLayout.h"

@interface PagedScrollViewAutoLayout()

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) UIView *scrollContentView;



@property (nonatomic) NSMutableArray *contentViewContainers;
@property (nonatomic) NSDictionary *metrics;
@property (nonatomic) UIView *superView;

@end


@implementation PagedScrollViewAutoLayout

- (instancetype)initWithContentViews:(NSArray *)contentViews
{
    if (self = [super init])
    {
        _contentViews = contentViews;
        self.pagingEnabled = YES;
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
//        [self setupView];
    }
    
    return self;
}
- (void)awakeFromNib
{
//    [self setupView];
}

- (void)setupView
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.scrollContentView = [[UIView alloc] init];
    [self.scrollContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:self.scrollContentView];
    self.contentOffset = CGPointMake
    (self.bounds.size.width, 0);
    NSDictionary *views = @{@"scrollContentView" : self.scrollContentView,
                            @"scrollView" : self};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollContentView]|" options:0 metrics:self.metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollContentView(==scrollView)]|" options:0 metrics:self.metrics views:views]];
    
    [self updateConstraintsIfNeeded];

}

- (NSMutableArray *)contentViewContainers
{
    if (!_contentViewContainers)
    {
        _contentViewContainers = [NSMutableArray new];
    }
    
    return _contentViewContainers;
}

- (NSDictionary *)metrics
{
    return @{@"screenWidth" : @([UIScreen mainScreen].bounds.size.width)};
}

- (void)updateConstraints
{
    [super updateConstraints];
   
    [self setupView];
    [self setupLayoutsForViewsInViewContainers];
    
}

- (void)setupLayoutsForViewsInViewContainers
{
    [self createViewContainers];
    
    for (UIView *viewContainer in self.contentViewContainers)
    {
        
        [self configureConstraintsForViewContainer:viewContainer];
    }
    
    for (UIView *view in self.contentViews) {
        
        [self configureConstraintsForEmbeddedCenteredView:view];
    }
    
}

- (void)createViewContainers
{
    for (UIView *view in self.contentViews)
    {
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        UIView *viewContainer = [[UIView alloc] init];
        [viewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [viewContainer addSubview:view];
        
        
        [self.contentViewContainers addObject:viewContainer];
        
        [self.scrollContentView addSubview:viewContainer];
    }
}

- (void)configureConstraintsForEmbeddedCenteredView:(UIView *)view
{
    NSUInteger index = [self.contentViews indexOfObject:view];
    
    UIView *viewContainer = self.contentViewContainers[index];
    
    UIView *leadingSpacer = [[UIView alloc] init];
    UIView *trailingSpacer = [[UIView alloc] init];
    [leadingSpacer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [trailingSpacer setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [viewContainer addSubview:leadingSpacer];
    [viewContainer addSubview:trailingSpacer];
    
    
    NSDictionary *views = @{@"view" : view,
                            @"leadingSpacer" : leadingSpacer,
                            @"trailingSpacer" : trailingSpacer};
    
    [viewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leadingSpacer(==trailingSpacer)][view][trailingSpacer(==leadingSpacer)]|" options:0 metrics:self.metrics views:views]];
    
    [viewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:self.metrics views:views]];
    
}

- (void)configureConstraintsForViewContainer:(UIView *)viewContainer
{
    NSDictionary *views = @{@"view" : viewContainer};
    
    [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:self.metrics views:views]];
    
    if ([self.contentViewContainers indexOfObject:viewContainer] == 0)
    {
        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(==screenWidth)]" options:0 metrics:self.metrics views:views]];
    }
    
    else if ([self.contentViewContainers indexOfObject:viewContainer] == [self.contentViewContainers count] - 1)
    {
        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==screenWidth)]|" options:0 metrics:self.metrics views:views]];
    }
    else
    {
        NSUInteger index = [self.contentViewContainers indexOfObject:viewContainer];
        
        views = @{@"view" : viewContainer,
                  @"previousView" : self.contentViewContainers[index - 1],
                  @"nextView" : self.contentViewContainers[index + 1]};
        
        [self.scrollContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView(==view)][view(==previousView)][nextView(==view)]" options:0 metrics:self.metrics views:views]];
    }
}

@end

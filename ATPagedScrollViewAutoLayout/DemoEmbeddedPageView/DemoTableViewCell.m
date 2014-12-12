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

@end

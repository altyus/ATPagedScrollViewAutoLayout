//
//  PagedScrollViewAutoLayout.h
//  DemoEmbeddedPageView
//
//  Created by AL TYUS on 12/11/14.
//  Copyright (c) 2014 AL TYUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedScrollViewAutoLayout : UIScrollView

@property (nonatomic) NSArray *images;

@property (nonatomic) NSArray *contentViews;

- (instancetype)initWithContentViews:(NSArray *)contentViews; 
@end

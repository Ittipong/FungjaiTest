//
//  LoadingView.m
//  OriginNiti
//
//  Created by Ittipong on 9/19/2558 BE.
//  Copyright (c) 2558 Tanapong Borrirakwisitsak. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadView];
        return self;
    }
    return nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.view.frame = frame;
}
-(void)loadView{
    
    NSString *className = NSStringFromClass([self class]);
    self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
    self.view.frame = self.bounds;
    self.activityIndicatorView.frame = CGRectMake(0,0, 35, 35);
    [self.indicatorContainer addSubview:self.activityIndicatorView];
    [self addSubview:self.view];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loading_v2" withExtension:@"gif"];
//  self.image.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
}

- (UIActivityIndicatorView *)activityIndicatorView{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView startAnimating];
        _activityIndicatorView.tintColor = [UIColor whiteColor];
        
    }
    return _activityIndicatorView;
}

@end

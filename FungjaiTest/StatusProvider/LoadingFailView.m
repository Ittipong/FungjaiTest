//
//  LoadingFailView.m
//  OriginNiti
//
//  Created by Pheonec's MacMiNi on 9/21/15.
//  Copyright (c) 2015 Tanapong Borrirakwisitsak. All rights reserved.
//

#import "LoadingFailView.h"

@implementation LoadingFailView

- (void)setError:(NSString *)error {
    _error = error;
    self.titleError.text = error;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleNoDataLB.text = title;
}

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
    [self addSubview:self.view];
    
}


- (IBAction)reloadAction:(id)sender {
    
    if (self.reloadHandle){
        self.reloadHandle();
    }
    
}



@end

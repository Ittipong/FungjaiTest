//
//  LoadingView.h
//  OriginNiti
//
//  Created by Ittipong on 9/19/2558 BE.
//  Copyright (c) 2558 Tanapong Borrirakwisitsak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLoading;
@property (weak, nonatomic) IBOutlet UIView *indicatorContainer;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

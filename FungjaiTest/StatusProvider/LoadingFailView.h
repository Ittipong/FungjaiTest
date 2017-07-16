//
//  LoadingFailView.h
//  OriginNiti
//
//  Created by Pheonec's MacMiNi on 9/21/15.
//  Copyright (c) 2015 Tanapong Borrirakwisitsak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingFailView : UIView

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleError;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleNoDataLB;

@property (weak,nonatomic) UIImage *logoImage;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *error;

@property (nonatomic, copy) void (^reloadHandle)(void);



@end

//
//  MViewController.h
//  FuelSation
//
//  Created by Tom on 2016/4/14.
//  Copyright © 2016年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MViewController : UIViewController
{
    AppDelegate *appDelegate;
    UIButton *sidebarcloseBtn;
    UIView *circleview;
    UIView *circle2view;
    //Global Array
    
}

@property (strong,nonatomic) AppDelegate *appDelegate;
@property (nonatomic) float imgScale;
@property (strong,nonatomic) UIColor *textColor;
@property (strong,nonatomic) UIColor *standerColor;
@property (nonatomic,retain) UIButton *sidebarcloseBtn;
@property (nonatomic,retain) UIView *circleview;

-(void)SidebarBtn;
-(void)sidebarClose;

-(UIImage *)resizeImage:(UIImage *)image;

-(UIImage *)snapShotView:(UIView *)inputView;

@end

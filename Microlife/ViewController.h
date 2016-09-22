//
//  ViewController.h
//  facebooklogin
//
//  Created by Ideabus on 2016/8/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookLoginViewController.h"

@interface ViewController : FacebookLoginViewController <UITextFieldDelegate>{
    UITextField  *passwordTextField;
    UIButton *connectFacebookBtn;
    UITextField  *emailTextField;
    UIButton *loginBtn;
    UIButton *loginGooglePlusBtn;
}

@property (nonatomic,retain)  UITextField  *passwordTextField;
@property (nonatomic,retain)  UIButton  *connectFacebookBtn;
@property (nonatomic,retain)  UITextField  *emailTextField;
@property (nonatomic,retain)  UIButton  *loginBtn;
@property (nonatomic,retain)  UIButton  *loginGooglePlusBtn;

@end


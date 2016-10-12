//
//  UserLoginViewController.h
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MViewController.h"
#import <Accounts/Accounts.h>  //授權認證機制
#import "FBSDKLoginKit/FBSDKLoginKit.h"

@interface UserLoginViewController : MViewController<UITextFieldDelegate>{
    
    UITextField  *passwordTextField;
    UIButton *connectFacebookBtn;
    UITextField  *emailTextField;
    UIButton *loginBtn;
    UIButton *loginGooglePlusBtn;
    
}

@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) ACAccount *facebookAccount;

@property (nonatomic,retain)  UITextField  *passwordTextField;
@property (nonatomic,retain)  UIButton  *connectFacebookBtn;
@property (nonatomic,retain)  UITextField  *emailTextField;
@property (nonatomic,retain)  UIButton  *loginBtn;
@property (nonatomic,retain)  UIButton  *loginGooglePlusBtn;


-(void) connectFacebook;

@end

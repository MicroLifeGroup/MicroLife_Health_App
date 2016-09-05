//
//  RegisterViewController.h
//  facebooklogin
//
//  Created by Ideabus on 2016/8/9.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookLoginViewController.h"
#import "ViewController.h"

@interface RegisterViewController : ViewController{
   
    UITextField  *confirmPasswordTextField;
    
    UIButton *agreeBtn;
    UIButton *registerBtn;
    
}

-(BOOL)validateEmail:(NSString*)email;

@property (nonatomic,retain)  UITextField  *confirmPasswordTextField;

@property (nonatomic,retain)  UIButton  *agreeBtn;
@property (nonatomic,retain)  UIButton  *registerBtn;

@end

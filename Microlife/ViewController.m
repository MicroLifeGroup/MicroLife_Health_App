//
//  ViewController.m
//  facebooklogin
//
//  Created by Ideabus on 2016/8/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController ()<GIDSignInUIDelegate>



@end

@implementation ViewController

@synthesize  passwordTextField;
@synthesize  connectFacebookBtn;
@synthesize  emailTextField;
@synthesize  loginBtn;
@synthesize  loginGooglePlusBtn;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loginVC];
    
    [GIDSignIn sharedInstance].clientID = kClientID;
    
    NSLog(@"[GIDSignIn sharedInstance].clientID = %@",[GIDSignIn sharedInstance].clientID);
}

-(void)loginVC{
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.8)];
    [loginView setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:0.95]];
    
    loginView.backgroundColor = [UIColor redColor];
    [self.view addSubview:loginView];
    
    
    
    float btnwidth = self.view.frame.size.width*0.41;
    float btnheight = btnwidth*100/298 ;
    
    //臉書
    connectFacebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    connectFacebookBtn.frame = CGRectMake(self.view.frame.size.width*0.08 , self.view.frame.size.height/7-10, btnwidth, btnheight);
    connectFacebookBtn.backgroundColor = [UIColor clearColor];
    
    [connectFacebookBtn setImage:[UIImage imageNamed:@"all_btn_a_fb"] forState:UIControlStateNormal];
    [connectFacebookBtn addTarget:self action:@selector(connectFacebookClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:connectFacebookBtn];
    
    
    //google
    loginGooglePlusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginGooglePlusBtn.frame = CGRectMake(self.view.frame.size.width*0.92-btnwidth , self.view.frame.size.height/7-10, btnwidth, btnheight);
    loginGooglePlusBtn.backgroundColor = [UIColor clearColor];
    
    [loginGooglePlusBtn setImage:[UIImage imageNamed:@"all_btn_a_gp"] forState:UIControlStateNormal];
    [loginGooglePlusBtn addTarget:self action:@selector(loginGooglePlusClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginGooglePlusBtn];
    
    //分隔線
    UIView *loginline1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.28, self.view.frame.size.height*0.26, self.view.frame.size.width*0.17, 2.6)];
    [loginline1 setBackgroundColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0]];
    
    [self.view addSubview:loginline1];
    
    UIView *loginline2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.55, self.view.frame.size.height*0.26, self.view.frame.size.width*0.17, 2.6)];
    [loginline2 setBackgroundColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0]];
    
    [self.view addSubview:loginline2];
    
    
    //or
    UILabel *orl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.45, self.view.frame.size.height*0.23, self.view.frame.size.width*0.1, self.view.frame.size.width*0.1)];
    orl.textColor = [UIColor blackColor];
    orl.alpha = 0.9;
    orl.font = [UIFont systemFontOfSize:22];
    orl.textAlignment = NSTextAlignmentCenter;
    orl.text = @"Or";
    [self.view addSubview:orl];
    
    
    //login
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0 , self.view.frame.size.height*0.46, self.view.frame.size.width, self.view.frame.size.height/11);
    loginBtn.backgroundColor = [UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:165.0/255.0 alpha:0.4];
    [loginBtn setTitle:@"Log in" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.9] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:26];
    loginBtn.userInteractionEnabled = NO;
    
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.userInteractionEnabled = YES;
    
    [self.view addSubview:loginBtn];
    
    
    //忘記密碼
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(0 , self.view.frame.size.height*0.55, self.view.frame.size.width, btnheight);
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forgetBtn];
    
    
    
    float emailY = self.view.frame.size.height*0.3;
    float textH = self.view.frame.size.height/13;
    
    UIView *emailview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY, self.view.frame.size.width*0.2, textH)];
    emailview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:emailview];
    
    UIImageView *emailImgV = [[UIImageView alloc] initWithFrame:CGRectMake(textH*0.2, emailY+textH*0.2, textH*0.6, textH*0.6)];
    UIImage *emailImg= [UIImage imageNamed:@"all_icon_a_email"];
    emailImgV.image = emailImg;
    
    emailImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :emailImgV];
    
    UIView *passwordview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY+textH+2.5 , self.view.frame.size.width*0.2, textH)];
    passwordview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordview];
    
    UIImageView *passwordImgV = [[UIImageView alloc] initWithFrame:CGRectMake(textH*0.2, emailY+textH+2.5+textH*0.2, textH*0.6, textH*0.6)];
    UIImage *passwordImg= [UIImage imageNamed:@"all_icon_a_password"];
    passwordImgV.image = passwordImg;
    
    passwordImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :passwordImgV];
    
        
    // UITextField初始化
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2 , emailY, self.view.frame.size.width, self.view.frame.size.height/13)];
    // 設定預設文字內容
    emailTextField.placeholder = @"E-mail";
    //emailTextField.text = @"";
    NSString * str = emailTextField.text;
    // 設定文字顏色
    emailTextField.textColor = [UIColor blackColor];
    // Delegate
    emailTextField.delegate = self;
    // 設定輸入框背景顏色
    emailTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    emailTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    emailTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    emailTextField.font = [UIFont systemFontOfSize:26];
    //emailTextField.font = [UIFont fontWithName:@"wawati sc" size:50];
    //设置编辑框中删除按钮的出现模式
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // 判断textField是否处于编辑模式
//    BOOL ret = emailTextField.isEditing;
//    emailTextField.clearsOnBeginEditing = YES;
    
    
    // UITextField初始化
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2 , emailY+textH+2.5, self.view.frame.size.width, self.view.frame.size.height/13)];
    // 設定預設文字內容
    passwordTextField.placeholder = @"Password";
    //emailTextField.text = @"";
    NSString * str1 = passwordTextField.text;
    passwordTextField.secureTextEntry = YES;
    // 設定文字顏色
    passwordTextField.textColor = [UIColor blackColor];
    // Delegate
    passwordTextField.delegate = self;
    // 設定輸入框背景顏色
    passwordTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    passwordTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    passwordTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    passwordTextField.font = [UIFont systemFontOfSize:26];
    //emailTextField.font = [UIFont fontWithName:@"wawati sc" size:50];
    //设置编辑框中删除按钮的出现模式
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // 判断textField是否处于编辑模式
//    BOOL ret1 = passwordTextField.isEditing;
//    passwordTextField.clearsOnBeginEditing = YES;
    
    
    
    
    // 將TextField加入View
    [self.view addSubview:emailTextField];
    [self.view addSubview:passwordTextField];
    
    
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    
    [emailTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    //    [UITextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
     NSLog(@"ok");
    

}

-(void)connectFacebookClick{
    [self connectFacebook];
    NSLog(@"fb");
}

-(void)loginGooglePlusClick{
    
    NSLog(@"loginGoogle");
    
    if (![CheckNetwork isExistenceNetwork]) {
        [self showAlert:NSLocalizedString(@"Connect fail", nil) message:NSLocalizedString(@"Please check your wifi", nil)];
        
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoogleLogin" object:nil];
    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    
    
    [[GIDSignIn sharedInstance] signIn];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    NSLog(@"userId = %@",userId);
    NSLog(@"idToken = %@",idToken);
    NSLog(@"fullName = %@",fullName);
    NSLog(@"givenName = %@",givenName);
    NSLog(@"familyName = %@",familyName);
    NSLog(@"email = %@",email);
    
    
    // [START_EXCLUDE]
    NSDictionary *statusText = @{@"statusText":
                                     [NSString stringWithFormat:@"Signed in user: %@",
                                      fullName]};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ToggleAuthUINotification"
     object:nil
     userInfo:statusText];
    // [END_EXCLUDE]
    
    
    //[cloudClass postDataSync:sendParam APIName:kAPI_commlogin EventId:CloudAPIEvent_commlogin];
    
}



-(void)loginBtnClicked{
    
    NSLog(@"loginBtn");
}

-(void)forgetBtnClick{
    UIViewController *ForgotPasswordVC = [[UIViewController alloc ]init];
    ForgotPasswordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    ForgotPasswordVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:ForgotPasswordVC animated:true completion:nil];

    NSLog(@"forgetBtn");
}

//限制输入字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (passwordTextField == textField)//这个 if 判断是在多个输入框的时候,只限制一个输入框的时候用的,如果全部限制,则不加 if 判断即可,这里是只判断输入用户名的输入框
    {
        if ([aString length] > 12) {
            textField.text = [aString substringToIndex:12];
            
            
            return NO;
        }
    }
    return YES;
}


-(void)textFieldChanged :(UITextField *) textField{
    
}

// 設定delegate 為self後，可以自行增加delegate protocol
// 開始進入編輯狀態
- (void) textFieldDidBeginEditing:(UITextField*)textField {
    NSLog(@"textFieldDidBeginEditing:%@",textField.text);
}

// 可能進入結束編輯狀態
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing:%@",textField.text);
    return true;
}

// 結束編輯狀態(意指完成輸入或離開焦點)
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing:%@",textField.text);
    
    if (emailTextField.text.length != 0 && passwordTextField.text.length != 0) {
        loginBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.625 alpha:1.0];
        loginBtn.userInteractionEnabled = YES;
        
        NSLog(@"o");
        //    }else{
        //
        //        NSLog(@"n");
        
    }
    

    
}

// 按下Return後會反應的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
    [textField resignFirstResponder];
    NSLog(@"按下Return");
    return false;
}


-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

-(void)showAlert:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
    
    [alertView addAction:okAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

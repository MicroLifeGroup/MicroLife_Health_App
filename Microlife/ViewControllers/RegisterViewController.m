//
//  RegisterViewController.m
//  facebooklogin
//
//  Created by Ideabus on 2016/8/9.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "RegisterViewController.h"



@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize confirmPasswordTextField;
@synthesize agreeBtn;
@synthesize registerBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loginVC];
 
}

-(void)loginVC{
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [loginView setBackgroundColor:[UIColor colorWithRed:241/255.0 green:242/255.0 blue:245/255.0 alpha:0.95]];
    [self.view addSubview:loginView];
    
    
    
    float btnwidth = self.view.frame.size.width*0.41;
    float btnheight = btnwidth*100/298 ;
    
    //臉書
    connectFacebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    connectFacebookBtn.frame = CGRectMake(self.view.frame.size.width*0.08 , self.view.frame.size.height*0.11, btnwidth, btnheight);
    connectFacebookBtn.backgroundColor = [UIColor clearColor];
    
    [connectFacebookBtn setImage:[UIImage imageNamed:@"all_btn_a_fb"] forState:UIControlStateNormal];
    [connectFacebookBtn addTarget:self action:@selector(connectFacebookAlert) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:connectFacebookBtn];
    
    
    //google
    loginGooglePlusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginGooglePlusBtn.frame = CGRectMake(self.view.frame.size.width*0.92-btnwidth , self.view.frame.size.height*0.11, btnwidth, btnheight);
    loginGooglePlusBtn.backgroundColor = [UIColor clearColor];
    
    [loginGooglePlusBtn setImage:[UIImage imageNamed:@"all_btn_a_gp"] forState:UIControlStateNormal];
    [loginGooglePlusBtn addTarget:self action:@selector(alertAgree) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginGooglePlusBtn];
    
    //分隔線
    
    
    UIView *loginline1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.28, self.view.frame.size.height*0.21, self.view.frame.size.width*0.17, 1.7)];
    [loginline1 setBackgroundColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0]];
    
    [self.view addSubview:loginline1];
    
    UIView *loginline2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.55, self.view.frame.size.height*0.21, self.view.frame.size.width*0.17, 1.7)];
    [loginline2 setBackgroundColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0]];
    
    [self.view addSubview:loginline2];
    
   
    
    //or
    UILabel *orl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.45, self.view.frame.size.height*0.18, self.view.frame.size.width*0.1, self.view.frame.size.width*0.1)];
    orl.textColor = [UIColor blackColor];
    orl.alpha = 0.9;
    orl.font = [UIFont systemFontOfSize:22];
    orl.textAlignment = NSTextAlignmentCenter;
    orl.text = @"Or";
    [self.view addSubview:orl];

    
    float emailY = self.view.frame.size.height*0.24;
    float textH = self.view.frame.size.height/13;
    
    
    UIView *loginline11 = [[UIView alloc] initWithFrame:CGRectMake(0, emailY-2.5, self.view.frame.size.width, 2.5)];
    [loginline11 setBackgroundColor:[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:0.26]];
    
    [self.view addSubview:loginline11];
    
    
    //帳密
    UIView *emailview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY, self.view.frame.size.width*0.2, textH)];
    emailview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:emailview];
    
    UIImageView *emailImgV = [[UIImageView alloc] initWithFrame:CGRectMake(textH*0.2, emailY+textH*0.2, textH*0.6, textH*0.6)];
    UIImage *emailImg= [UIImage imageNamed:@"all_icon_a_email"];
    emailImgV.image = emailImg;
    //emailImgV.contentMode =
    emailImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :emailImgV];
    
    UIView *passwordview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY+textH+2.5 , self.view.frame.size.width*0.2, textH)];
    passwordview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordview];
    
    UIImageView *passwordImgV = [[UIImageView alloc] initWithFrame:CGRectMake(textH*0.2, emailY+textH+2.5+textH*0.2, textH*0.6, textH*0.6)];
    UIImage *passwordImg= [UIImage imageNamed:@"all_icon_a_password"];
    passwordImgV.image = passwordImg;
    passwordImgV.contentMode =
    passwordImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :passwordImgV];
    
    UIView *confirmpwview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY+textH*2+5, self.view.frame.size.width*0.2, textH)];
    confirmpwview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:confirmpwview];
    
    UIImageView *confirmpwImgV = [[UIImageView alloc] initWithFrame:CGRectMake(textH*0.2, emailY+textH*2+5+textH*0.2, textH*0.6, textH*0.6)];
    UIImage *confirmpwImg= [UIImage imageNamed:@"all_icon_a_password"];
    confirmpwImgV.image = confirmpwImg;
    confirmpwImgV.contentMode =
    confirmpwImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :confirmpwImgV];

    
    
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
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress] ;
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
    
    // UITextField初始化
    confirmPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2 , emailY+textH*2+5, self.view.frame.size.width, self.view.frame.size.height/13)];
    // 設定預設文字內容
    confirmPasswordTextField.placeholder = @"Confirm password";
    //emailTextField.text = @"";
    NSString * str2 = confirmPasswordTextField.text;
    confirmPasswordTextField.secureTextEntry = YES;
    // 設定文字顏色
    confirmPasswordTextField.textColor = [UIColor blackColor];
    // Delegate
    confirmPasswordTextField.delegate = self;
    // 設定輸入框背景顏色
    confirmPasswordTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    confirmPasswordTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    confirmPasswordTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    confirmPasswordTextField.font = [UIFont systemFontOfSize:26];
        //设置编辑框中删除按钮的出现模式
    confirmPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //設置鍵盤格式
     [confirmPasswordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    //設置首字不大寫
    confirmPasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // 判断textField是否处于编辑模式
//    BOOL ret1 = passwordTextField.isEditing;
//    passwordTextField.clearsOnBeginEditing = YES;
    
//    BOOL ret2 = confirmPasswordTextField.isEditing;
//    confirmPasswordTextField.clearsOnBeginEditing = YES;
    // 將TextField加入View
    [self.view addSubview:emailTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:confirmPasswordTextField];
    
    
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    confirmPasswordTextField.delegate = self;
    
    [emailTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [passwordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [confirmPasswordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //    [UITextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UIView *agreeview = [[UIView alloc] initWithFrame:CGRectMake(0, emailY+textH*3+7.5, self.view.frame.size.width, textH)];
    agreeview.backgroundColor = [UIColor whiteColor];
    agreeview.alpha = 0.5;
    [self.view addSubview:agreeview];
    
    
    UILabel *agreeL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2, emailY+textH*3+7.5, self.view.frame.size.width*0.75, textH)];
    agreeL.textColor = [UIColor colorWithRed:168/255 green:168/255 blue:165/255 alpha:0.4];
    
    agreeL.font = [UIFont systemFontOfSize:14];
    agreeL.textAlignment = NSTextAlignmentLeft;
    //自動換行設置
//    agreeL.lineBreakMode = NSLineBreakByCharWrapping;
//    agreeL.numberOfLines = 0;
    //改變字母的間距自適應label的寬度
    agreeL.adjustsFontSizeToFitWidth = NO;
    
    agreeL.text = @"You agree to our Terms and Privacy Policy and to receive notice on event and services.";
    agreeL.numberOfLines = 2 ; //[agreeL.text length];
    
    [self.view addSubview:agreeL];

    agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(textH*0.5, emailY+textH*3+7.5+textH*0.2, textH*0.6, textH*0.6);
    
    agreeBtn.backgroundColor = [UIColor whiteColor];
    agreeBtn.layer.borderWidth = 2;
    agreeBtn.layer.borderColor = [UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:0.2].CGColor;
    agreeBtn.layer.cornerRadius = 2.0;
    [agreeBtn setSelected:NO];//設置按鈕的狀態是否為選中(可在此根據具體情況來設置按鈕的初始狀態)
    
    [agreeBtn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:agreeBtn];

    
    //註冊
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(0 , self.view.frame.size.height*0.56, self.view.frame.size.width, self.view.frame.size.height/11);
    
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.9] forState:UIControlStateNormal];
    registerBtn.userInteractionEnabled = NO;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:26];
    
    registerBtn.backgroundColor = [UIColor colorWithRed:168/255 green:168/255 blue:165/255 alpha:0.4];
    
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerBtn];
    
    
    

    
    
    NSLog(@"ok");
    
    
}

-(void)connectFacebookClick{
    [self connectFacebook];
    NSLog(@"fb");
}
-(void)loginGooglePlusClick{
    NSLog(@"google");
}

-(void)connectFacebookAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please agree Terms of Service and Privacy Policy before registration." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
}

-(void)loginGooglePlusAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please agree Terms of Service and Privacy Policy before registration." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
}

-(void)loginBtnClick{
    
    NSLog(@"loginBtn");
}

-(void)registerBtnClick{
    
    
    if(passwordTextField.text.length<6 ||passwordTextField.text.length>12){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Error password! Please enter between 6-12 numbers or letters." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSLog(@"password ok");
    }
    
//    //檢查e-mail是否符合這個格式xxx@xxx.xxx xxx@xxx.xxx.xxx
//    //   NSString * emailToChecked = @"abc@gamil.com";
//    //使用正規表達式去檢查
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@ [A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    //emailTextField.text = emailRegex;
//    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
//    //下一個if去判斷 如果合法顯示isValid 不合法則顯示isInValid
//    if([emailCheck evaluateWithObject:emailCheck]
//       
//       ){
//        NSLog(@"Email is valid");
//    }else{
//        NSLog(@"Email is Invalid");
//    }

    
    [self validateEmail:emailTextField.text];
    
    NSLog(@"registerBtnClick");
}

-(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy] ;
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        /*
         *使用compare option 来设定比较规则，如
         *NSCaseInsensitiveSearch是不区分大小写
         *NSLiteralSearch 进行完全比较,区分大小写
         *NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
         */
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
               
                return NO;
            
        }
        NSLog(@"sucess");
        return YES;
    }
    else {
        [self errorEmailAlert];
         NSLog(@"email格式不正確");
        return NO;
       
    }
}


-(void)agreeClick{
    agreeBtn.selected = !agreeBtn.selected;
    //每次點擊都會改變按鈕的狀態
    
    if (agreeBtn.selected) {
        //在此實現打勾時的方法
        [agreeBtn setImage:[UIImage imageNamed:@"reminder_icon_a_tick"] forState:UIControlStateSelected];
        [connectFacebookBtn removeTarget:self action:@selector(connectFacebookAlert) forControlEvents:UIControlEventTouchUpInside];
        [connectFacebookBtn addTarget:self action:@selector(connectFacebookClick) forControlEvents:UIControlEventTouchUpInside];
        [loginGooglePlusBtn removeTarget:self action:@selector(alertAgree) forControlEvents:UIControlEventTouchUpInside];
        [loginGooglePlusBtn addTarget:self action:@selector(loginGooglePlusClick) forControlEvents:UIControlEventTouchUpInside];

        if (emailTextField.text.length != 0 && passwordTextField.text.length != 0 &&confirmPasswordTextField.text.length !=0) {
            
            
            registerBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.625 alpha:1.0];
            registerBtn.userInteractionEnabled = YES;

        }
        
        
    }else{
        //在此實現不打勾時的方法
        [agreeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        connectFacebookBtn.userInteractionEnabled = NO;
        registerBtn.backgroundColor = [UIColor colorWithRed:168/255 green:168/255 blue:165/255 alpha:0.4];
        registerBtn.userInteractionEnabled = NO;
        [connectFacebookBtn removeTarget:self action:@selector(connectFacebookClick) forControlEvents:UIControlEventTouchUpInside];
        [connectFacebookBtn addTarget:self action:@selector(connectFacebookAlert) forControlEvents:UIControlEventTouchUpInside];
        [loginGooglePlusBtn removeTarget:self action:@selector(loginGooglePlusClick) forControlEvents:UIControlEventTouchUpInside];
         [loginGooglePlusBtn addTarget:self action:@selector(alertAgree) forControlEvents:UIControlEventTouchUpInside];
    }
   
    
}

-(void)alertAgree{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please agree Terms of Service and Privacy Policy before registration." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)errorEmailAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Error Email! Please enter again." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


//限制輸入字數
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
    
    if (confirmPasswordTextField == textField) {
        if ([aString length] >12 ) {
            textField.text = [aString substringToIndex:12];
            return NO;
        }
    }
    
    return YES;
}

-(void)registerBtnClickDisable{
    
    registerBtn.backgroundColor = [UIColor colorWithRed:168/255 green:168/255 blue:165/255 alpha:0.4];
    registerBtn.userInteractionEnabled = NO;
}

-(void)registerBtnClickEnable{
    registerBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.625 alpha:1.0];
    registerBtn.userInteractionEnabled = YES;
}

-(void)registerbtnable{
    if (emailTextField.text.length != 0 && passwordTextField.text.length != 0 &&confirmPasswordTextField.text.length !=0) {
        
        
        if ((agreeBtn.selected == YES)){
            [self registerBtnClickEnable];
            
            NSLog(@"111");
        }
        
        else if (agreeBtn.selected == NO){
            [self registerBtnClickDisable];
            NSLog(@"222");
        }
        
    }else{
        [self registerBtnClickDisable];
        NSLog(@"333");
        return;
        
        
    }

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
   
    NSString *password =  passwordTextField.text;
    NSString *confirmpassword = confirmPasswordTextField.text;
    
    if ( passwordTextField.text.length > 0 && confirmPasswordTextField.text.length >0) {
                if (password != confirmpassword) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Password is not the same." preferredStyle:UIAlertControllerStyleAlert];
        
        
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                    [alertController addAction:cancelAction];
        
                    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"Reset" style:UIAlertActionStyleDestructive handler:nil];
                    [alertController addAction:resetAction];
        
        
                    [self presentViewController:alertController animated:YES completion:nil];
                    NSLog(@"密碼不同");
                }
    }
    
    
    
    [self registerbtnable];


    
}

// 按下Return後會反應的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
    [textField resignFirstResponder];
    NSLog(@"按下Return");
    
    [self registerbtnable];
    
    return false;
}





-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

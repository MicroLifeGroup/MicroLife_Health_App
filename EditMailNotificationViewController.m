//
//  EditMailNotificationViewController.m
//  Setting
//
//  Created by Ideabus on 2016/8/18.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "EditMailNotificationViewController.h"

@interface EditMailNotificationViewController ()

@end

@implementation EditMailNotificationViewController

@synthesize editEmailTextField;
@synthesize editNameTextField;
@synthesize editNameStr,editEmailStr;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editV];
    

    
    [self editMnav];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editMnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Edit Mail Notification";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal ];
        navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [navbackBtn addTarget:self action:@selector(gobackMailNotification) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navbackBtn];
    
    UIButton *navsaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navsaveBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.02, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navsaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [navsaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navsaveBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    navsaveBtn.backgroundColor = [UIColor clearColor];
    navsaveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [navsaveBtn addTarget:self action:@selector(saveEdit) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navsaveBtn];
    
    
    
}

-(void)saveEdit{
    
    if (editNameTextField.text.length < 1 || editEmailTextField.text.length < 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"The name can not be null! " message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:ConfirmAction];
        
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:closeAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{

    
    [self validateEmail:editEmailTextField.text];
   
        
    }
}


-(void)saveEditData{
    
    //Save
    
    editNameStr = editNameTextField.text;
    editEmailStr = editEmailTextField.text;
    
    NSDictionary *memberDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                editNameStr,@"name",
                                editEmailStr,@"email",nil];
    
    [[LocalData sharedInstance] editMemberProfile:memberDict atIndexPath:self.editIndex];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
        
        
        [self saveEditData];
        
        
        return YES;
    }
    else {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Error Email! Please enter again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        NSLog(@"email格式不正確");
        return NO;
        
    }
}






-(void)gobackMailNotification{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)editV{
    
    float addH = self.view.frame.size.height*0.09;
    float addY = self.view.frame.size.height*0.16;
    
    self.view.backgroundColor = TABLE_BACKGROUND;
    
    UIView *addview = [[UIView alloc]initWithFrame:CGRectMake(-1, addY, self.view.frame.size.width+2, addH*2+1)];
    addview.backgroundColor = [UIColor whiteColor];
    addview.layer.borderWidth = 1;
    addview.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0].CGColor;
    
    [self.view addSubview:addview];
    
    UIView *aline = [[UIView alloc]initWithFrame:CGRectMake(0, addY+addH, self.view.frame.size.width, 1)];
    
    aline.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1];
    [self.view addSubview:aline];
    
    
    // UITextField初始化
    editNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.25 , addY+1, self.view.frame.size.width, addH-1)];
    // 設定預設文字內容
    editNameTextField.placeholder = @"";
    editNameTextField.text = editNameStr;
    editNameTextField.secureTextEntry = NO;
    // 設定文字顏色
    editNameTextField.textColor = [UIColor blackColor];
    // Delegate
    editNameTextField.delegate = self;
    // 設定輸入框背景顏色
    editNameTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    editNameTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    editNameTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    editNameTextField.font = [UIFont systemFontOfSize:26];
    //设置编辑框中删除按钮的出现模式
    editNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    //設置鍵盤格式
    [editNameTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    //設置首字不大寫
    editNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:editNameTextField];
    
    [editNameTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    // UITextField初始化
    editEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.25 , addY+addH+1, self.view.frame.size.width, addH-1)];
    // 設定預設文字內容
    editEmailTextField.placeholder = @"";
    editEmailTextField.text = editEmailStr;
    editEmailTextField.secureTextEntry = NO;
    // 設定文字顏色
    editEmailTextField.textColor = [UIColor blackColor];
    // Delegate
    editEmailTextField.delegate = self;
    // 設定輸入框背景顏色
    editEmailTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    editEmailTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    editEmailTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    editEmailTextField.font = [UIFont systemFontOfSize:26];
    //设置编辑框中删除按钮的出现模式
    editEmailTextField.clearButtonMode = UITextFieldViewModeAlways;
    //設置鍵盤格式
    [editEmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //設置首字不大寫
    editEmailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:editEmailTextField];
    
    [editEmailTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, addY+1, self.view.frame.size.width*0.25, addH-1)];
    [nameLabel setTextColor:[UIColor blackColor ]];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"Name";
    nameLabel.font = [UIFont systemFontOfSize:22];
    nameLabel.alpha = 1.0;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:nameLabel];
    
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, addY+addH+1, self.view.frame.size.width*0.25, addH-1)];
    [emailLabel setTextColor:[UIColor blackColor ]];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email";
    emailLabel.font = [UIFont systemFontOfSize:22];
    emailLabel.alpha = 1.0;
    emailLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:emailLabel];
    
    
}

#pragma mark - 返回上一頁的方法
-(void)backPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 點擊空白處隱藏鍵盤的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textInfo resignFirstResponder];
}

#pragma mark - 點擊 return 返回的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
        [textField resignFirstResponder];
    }
    
    if (self.delegate) {
        [self.delegate postValue:self.textInfo.text];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    return YES;
    
    
    
}




//限制輸入字數
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (editNameTextField == textField)//这个 if 判断是在多个输入框的时候,只限制一个输入框的时候用的,如果全部限制,则不加 if 判断即可,这里是只判断输入用户名的输入框
    {
        if ([aString length] > 50) {
            textField.text = [aString substringToIndex:50];
            
            return NO;
        }
    }
    
    
    return YES;
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
    
    
    
}



-(void)textFieldChanged :(UITextField *) textField{
    
}



-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}








@end

//
//  ProfileViewController.m
//  Setting
//
//  Created by Ideabus on 2016/8/12.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize  profileScrollview;
@synthesize nameTextField;
@synthesize birthdayLabel;
@synthesize birDatepicker;
@synthesize allPickerView;
@synthesize pickerB;
@synthesize birthdaydate;
@synthesize heightLabel;
@synthesize weightLabel;
@synthesize heightPickerView;
@synthesize topView;
@synthesize weightPickerView;
@synthesize h_unit;
@synthesize w_unit;
@synthesize kgLabel;
@synthesize sysPickerView;
@synthesize diaPickerView;
@synthesize spLabel;
@synthesize dpLabel;
@synthesize wLabel;
@synthesize bmiLabel;
@synthesize bfLabel;
@synthesize wPickerView;
@synthesize bfPickerView;
@synthesize bmiPickerView;
@synthesize pickRow;
@synthesize csPickerView;
@synthesize maPickerView;
@synthesize CuffSizeArr;
@synthesize MeaArmArr;
@synthesize thresholdcount;
@synthesize cmLabel;
@synthesize height1PickerView;
@synthesize height2PickerView;
@synthesize incharray;
@synthesize h_ft_unit,h_in_unit;
@synthesize dateformatBool;
@synthesize unitBooL,pressureBooL;
@synthesize inch_Str;
@synthesize height_value,weight_value,goalweight_value,sys_pressure_value,dia_pressure_value,BMI_value,BF_value;
@synthesize genderBooL;
@synthesize profile_name;
@synthesize cuffsize_row,measureArm_row;
@synthesize birth_date;

- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.675 alpha:1];
    
   
    
//    //滾輪單位轉換除數
//    mmHg_kPa_c = 1;
//    kg_lb_c = 1;
//    cm_ft_c = 1;
    
    [self initParameter];
    
    [self profileSV];
    [self ProfilePicture];
    [self profileEmail];
    [self profilenav];
    //[self allpickerView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initParameter{
    
    CuffSizeArr = @[@"S",@"M",@"M-L",@"L",@"L-X"];
    
    MeaArmArr = @[@"Left",@"Right"];
    
    //spStr
    
    //dpStr
    
    nameTextField.text = [LocalData sharedInstance].name;
    
    birthDateString = [LocalData sharedInstance].birthday;
    
    //birthdayLabel.text = [LocalData sharedInstance].birthday;
    
    measureArm_row = [LocalData sharedInstance].bp_measurement_arm;;
    
    cuffsize_row = [LocalData sharedInstance].cuff_size;
    
    height_value = [LocalData sharedInstance].UserHeight;
    
    weight_value = [LocalData sharedInstance].UserWeight;
    
    goalweight_value = [LocalData sharedInstance].targetWeight;
    
    sys_pressure_value = [LocalData sharedInstance].targetSYS;
    
    
    
    dia_pressure_value = [LocalData sharedInstance].targetDIA;
    
    BMI_value = [LocalData sharedInstance].targetBMI;
    
    BF_value = [LocalData sharedInstance].targetFat;
    
    dateformatBool = [LocalData sharedInstance].date_format;
    
    unitBooL = [LocalData sharedInstance].metric;
    
    
    
    pressureBooL = [LocalData sharedInstance].BPUnit;
    
    genderBooL = [LocalData sharedInstance].UserGender;
    
    sysAtive = [LocalData sharedInstance].showTargetSYS;
    
    diaAtive = [LocalData sharedInstance].showTargetDIA;
    
    goalWeightAtive = [LocalData sharedInstance].showTargetWeight;
    
    BMIAtive = [LocalData sharedInstance].showTargetBMI;
    
    bodyFatAtive = [LocalData sharedInstance].showTargetFat;
    
    thresholdActive = [LocalData sharedInstance].threshold;
    
    
    
    /*
     if (height_value == 0) {
     
     height_value = 175;
     
     }
     if (weight_value == 0) {
     
     weight_value = 75.0;
     
     }
    
     if (goalweight_value == 0) {
     
     goalweight_value = 75.0;
     
     }
     if (sys_pressure_value == 0) {
     
     sys_pressure_value = 120;
     
     }

     if (dia_pressure_value == 0) {
     dia_pressure_value = 80;
     
     }
     if (BMI_value == 0) {
     BMI_value = 25.0;
     
     }
     if (BF_value == 0) {
     BF_value = 25.0;
     
     }
     //
     
     if (cuffsize_row == -1) {
     cuffsize_row = 1;
     }
     if (measureArm_row == -1) {
     measureArm_row = 0;
     }
     //從資料庫取得日期格式設定
     //    if () {
     dateformatBool = 0;
     //    }
     //判斷資料庫的公英制設定
     */

    if (unitBooL == 1) {
        
        //身高轉字串
        
        //double hei2value = [heiStr doubleValue];
        
        //公分轉英呎
        
        NSString *ft_1Str = [NSString stringWithFormat:@"%.2f", height_value*cm_ft];
        
        ft_Str = [ft_1Str substringWithRange:NSMakeRange(0, 1)];
        
        //公分轉英呎
        
        NSString *hei2222str = [NSString stringWithFormat:@"%f",height_value*cm_ft];
        
        int ft_value = [ft_Str intValue];
        
        double hei2222value = [hei2222str doubleValue];
        
        
        
        //英呎扣掉整數位後剩餘部分轉英吋
        
        inch_Str = [NSString stringWithFormat:@"%.1f",(hei2222value-ft_value)*12];
    }
    
    //判斷資料庫中血壓單位的設定

    //單位轉換
    
    mmHg_kPa = 0.13332237;
    
    kg_lb = 2.20462;
    
    cm_ft = 0.03306878;
    
}

-(void)ProfilePicture{
    float ProfileimgRadius = self.view.frame.size.width *0.3;
    
    UIImageView *personalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-ProfileimgRadius/2, self.view.frame.size.height*3/26, ProfileimgRadius, ProfileimgRadius)];
    UIImage *personImage = [UIImage imageNamed:@"personal"];
    personalImageView.image = personImage;
    personalImageView.contentMode = UIViewContentModeScaleAspectFit;
    //personalImageView = [[UIImageView alloc] initWithImage:personImage];
    //设置图片的Frame
    //[personalImageView setFrame:CGRectMake(80.0f,80.0f, imageRadius, imageRadius)];
    [personalImageView.layer setMasksToBounds:YES];
    personalImageView.layer.cornerRadius = ProfileimgRadius/2+2;
    personalImageView.layer.borderColor = [UIColor colorWithRed:217.0f/255.0f green:215.0f/255.0f blue:208.0f/255.0f alpha:0.84].CGColor;
    personalImageView.layer.borderWidth = 1;
    
    //self.view.backgroundColor = [UIColor clearColor];
    [self.profileScrollview addSubview:personalImageView];
    
    UIButton *takepictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takepictureBtn.frame = CGRectMake(self.view.frame.size.width/2-ProfileimgRadius/2+ProfileimgRadius/1.412 , self.view.frame.size.height*3/26+ProfileimgRadius/1.412, ProfileimgRadius*1.1/4, ProfileimgRadius*1.1/4);
    takepictureBtn.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1];
    takepictureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    takepictureBtn.layer.borderWidth = 2;
    takepictureBtn.layer.cornerRadius = ProfileimgRadius/8;
    
    
    [takepictureBtn setImage:[UIImage imageNamed:@"all_btn_a_camera"] forState:UIControlStateNormal];
    [takepictureBtn addTarget:self action:@selector(uploadProfilePicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileScrollview addSubview:takepictureBtn];

    
    

}

-(void)uploadProfilePicture{
    
    NSLog(@"Picture");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload your profile picture" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"From Camera" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
        
        
       
        
        
    }];
    
    [alertController addAction:cameraAction];
    
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Form Album" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertController addAction:albumAction];
    
    
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:closeAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)profileEmail{
    
    CGRect emaillabelFrame = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*0.13+self.view.frame.size.width*0.3 , self.view.frame.size.width/2 , 22);
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:emaillabelFrame];
    [emailLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    emailLabel.text = @"ideabus@gmail.com";
    emailLabel.font = [UIFont systemFontOfSize:17];
    emailLabel.alpha = 0.9;
    //emailLabel.backgroundColor = [UIColor yellowColor];
    emailLabel.textAlignment = NSTextAlignmentCenter;
    [self.profileScrollview addSubview:emailLabel];
    
}

-(void)profilenav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];

    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Profile";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
   
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal ];
        navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
     [navbackBtn addTarget:self action:@selector(gobackSetting) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navbackBtn];
    
    UIButton *navsaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navsaveBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.02, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navsaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [navsaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navsaveBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    navsaveBtn.backgroundColor = [UIColor clearColor];
    navsaveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [navsaveBtn addTarget:self action:@selector(saveProfile) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navsaveBtn];

    
    
    
    
}

-(void)gobackSetting{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  
}

-(void)profileSV{
    
    float profileY1 = self.view.frame.size.height*0.37;
    float profileY2 = self.view.frame.size.height*1.15;
    float profileH = self.view.frame.size.height/13;
    float profileX = self.view.frame.size.width*0.48;
    float profileX1 = self.view.frame.size.width*0.59;
    
    
    profileScrollview.frame = self.view.bounds;
    profileScrollview.delegate = self;
    profileScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    profileScrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2.08);
    profileScrollview.showsVerticalScrollIndicator = false;
    
    profileScrollview.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0];
    
    [self.view addSubview:profileScrollview];
    
    
    
    NSDate *currentDate=[NSDate date];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    if (dateformatBool == 0) {
        [formatter setDateFormat:@"YYYY/MM/dd"];
    }else if (dateformatBool == 1){
        [formatter setDateFormat:@"MM/dd/YYYY"];
    }
    
    currentDateString = [formatter stringFromDate:currentDate];
    NSLog(@"currentDate=%@", currentDateString);
    birthDateString  = [formatter stringFromDate:currentDate];
    
    
    //<<<<<<<<<<<<<<  第一區塊 >>>>>>>>>>>>>>>>
    
    
    UIView *profileview = [[UIView alloc] initWithFrame:CGRectMake(-1, profileY1, self.view.frame.size.width+2, profileH*10+9)];
    profileview.backgroundColor = [UIColor whiteColor];
    profileview.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f  blue:217.0f/255.0f  alpha:0.9].CGColor;
    profileview.layer.borderWidth = 1;
    [self.profileScrollview addSubview:profileview];
    
   // NSArray *ary_line = ["1","2","3","4"];
    
    for (int i=1; i<10; i++) {

        UIView *pline = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*i, self.view.frame.size.width*0.95, 1)];
        
        pline.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0];
        [self.profileScrollview addSubview:pline];
    }
    
    
    
    UIView *pline1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1, self.view.frame.size.width*0.95, 1)];
    pline1.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0];
    [self.profileScrollview addSubview:pline1];
    
    
    //性別選擇
    NSArray *sexitemArray = [NSArray arrayWithObjects: @"Male", @"Female", nil];
    sexsegmentedControl = [[UISegmentedControl alloc] initWithItems:sexitemArray];
    sexsegmentedControl.frame = CGRectMake(self.view.frame.size.width*0.37, (profileH-self.view.frame.size.height/22)/2+profileH*2+profileY1, self.view.frame.size.width*0.6, self.view.frame.size.height/22);
    [sexsegmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    sexsegmentedControl.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [sexsegmentedControl setTitleTextAttributes:attributes
                               forState:UIControlStateNormal];
    sexsegmentedControl.tintColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1];
    sexsegmentedControl.selectedSegmentIndex = genderBooL;
    [profileScrollview addSubview:sexsegmentedControl];
   
    
    
    
    //公英制轉換
    NSArray *unititemArray = [NSArray arrayWithObjects: @"Metric", @"Imperial", nil];
    unitsegmentedControl = [[UISegmentedControl alloc] initWithItems:unititemArray];
    unitsegmentedControl.frame = CGRectMake(self.view.frame.size.width*0.37, (profileH-self.view.frame.size.height/22)/2+profileH*8+profileY1, self.view.frame.size.width*0.6, self.view.frame.size.height/22);
    [unitsegmentedControl addTarget:self action:@selector(unitSegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    unitsegmentedControl.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIFont *unitfont = [UIFont boldSystemFontOfSize:17.0f];
    NSDictionary *unitattributes = [NSDictionary dictionaryWithObject:unitfont forKey:NSFontAttributeName];
    [unitsegmentedControl setTitleTextAttributes:unitattributes
                                       forState:UIControlStateNormal];
    unitsegmentedControl.tintColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1];
    
    if (unitBooL == 0) {
        unitsegmentedControl.selectedSegmentIndex = 0;
    }else if (unitBooL == 1){
        unitsegmentedControl.selectedSegmentIndex = 1;
    }
    
    [profileScrollview addSubview:unitsegmentedControl];
    

    
    
    //血壓單位轉換
    NSArray *pressureitemArray = [NSArray arrayWithObjects: @"mmHg", @"kpa", nil];
    pressuresegmentedControl = [[UISegmentedControl alloc] initWithItems:pressureitemArray];
    pressuresegmentedControl.frame = CGRectMake(self.view.frame.size.width*0.37, (profileH-self.view.frame.size.height/22)/2+profileH*9+profileY1, self.view.frame.size.width*0.6, self.view.frame.size.height/22);
    [pressuresegmentedControl addTarget:self action:@selector(pressureSegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    pressuresegmentedControl.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIFont *pressurefont = [UIFont boldSystemFontOfSize:17.0f];
    NSDictionary *pressureattributes = [NSDictionary dictionaryWithObject:pressurefont forKey:NSFontAttributeName];
    [pressuresegmentedControl setTitleTextAttributes:pressureattributes
                                        forState:UIControlStateNormal];
    pressuresegmentedControl.tintColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1];
    if (pressureBooL == 0) {
        pressuresegmentedControl.selectedSegmentIndex = 0;

    }else if (pressureBooL == 1){
        pressuresegmentedControl.selectedSegmentIndex = 1;

        
    }
    
    
        [profileScrollview addSubview:pressuresegmentedControl];
   
    
    
    
    
    
    //Name
    // UITextField初始化
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(profileX , profileY1+1, self.view.frame.size.width*0.6, profileH) ];
    // 設定預設文字內容
    nameTextField.placeholder = @"Name";
    //emailTextField.text = @"";
    // 設定文字顏色
    nameTextField.textColor = [UIColor blackColor];
    // Delegate
    nameTextField.delegate = self;
    // 設定輸入框背景顏色
    nameTextField.backgroundColor = [UIColor clearColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    nameTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    nameTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    nameTextField.font = [UIFont systemFontOfSize:17];
    //emailTextField.font = [UIFont fontWithName:@"wawati sc" size:50];
    //设置编辑框中删除按钮的出现模式
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameTextField setKeyboardType:UIKeyboardTypeDefault] ;
    //首字不大寫
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.profileScrollview addSubview:nameTextField];

    //Change Password
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(0, profileY1+profileH+1, self.view.frame.size.width, profileH);
    changeBtn.backgroundColor = [UIColor clearColor];
    changeBtn.layer.cornerRadius = 0;
    [changeBtn addTarget:self action:@selector(gochangepasswordClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileScrollview addSubview:changeBtn];
    
    UIButton *gochangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gochangeBtn.frame = CGRectMake(self.view.frame.size.width-profileH*0.37-5, profileY1+profileH*1.315+1, profileH*0.37, profileH*0.37);
    [gochangeBtn setImage:[UIImage imageNamed:@"all_icon_a_arrow_r"] forState:UIControlStateNormal ];
    gochangeBtn.backgroundColor = [UIColor clearColor];
    gochangeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [gochangeBtn addTarget:self action:@selector(gochangepasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.profileScrollview addSubview:gochangeBtn];

    
    
    
    
    
    //生日
    CGRect birthdaylabelFrame = CGRectMake(profileX, profileY1+profileH*3 , self.view.frame.size.width*0.6 , profileH);
    birthdayLabel = [[UILabel alloc] initWithFrame:birthdaylabelFrame];
    [birthdayLabel setTextColor:[UIColor blackColor]];
    birthdayLabel.text = birthDateString;
    birthdayLabel.font = [UIFont systemFontOfSize:17];
    birthdayLabel.alpha = 1.0;
    
    //讓label可點擊產生事件
    birtapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(birthdayPicker)];
    birtapGestureRecognizer.numberOfTapsRequired = 1;
    [birthdayLabel addGestureRecognizer:birtapGestureRecognizer];
    birthdayLabel.userInteractionEnabled = YES;
    //pLabel.backgroundColor = [UIColor yellowColor];
    birthdayLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:birthdayLabel];

    
    //身高
    CGRect cmlabelFrame = CGRectMake(profileX1, profileY1+profileH*4 , self.view.frame.size.width/3 , profileH);
    cmLabel = [[UILabel alloc] initWithFrame:cmlabelFrame];
    [cmLabel setTextColor:[UIColor grayColor]];
    cmLabel.text = @"cm";
    cmLabel.font = [UIFont systemFontOfSize:14];
    cmLabel.alpha = 1.0;
    cmLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:cmLabel];
    
    cm1Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX+25, profileY1+profileH*4, self.view.frame.size.width/3, profileH)];
    [cm1Label setTextColor:[UIColor grayColor]];
    cm1Label.text = @"ft";
    cm1Label.font = [UIFont systemFontOfSize:14];
    cm1Label.alpha = 1.0;
    cm1Label.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:cm1Label];
    
    
    cm2Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX+85, profileY1+profileH*4, self.view.frame.size.width/3, profileH)];
    [cm2Label setTextColor:[UIColor grayColor]];
    cm2Label.text = @"inch";
    cm2Label.font = [UIFont systemFontOfSize:14];
    cm2Label.alpha = 1.0;
    cm2Label.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:cm2Label];
    
    
    
    
    CGRect heightlabelFrame = CGRectMake(profileX, profileY1+profileH*4 ,profileX1-profileX , profileH);
    heightLabel = [[UILabel alloc] initWithFrame:heightlabelFrame];
    [heightLabel setTextColor:[UIColor blackColor]];
    heightLabel.text = [NSString stringWithFormat:@"%d",height_value];
    //heightLabel.text = @"175";
    heightLabel.font = [UIFont systemFontOfSize:17];
    heightLabel.alpha = 1.0;
    heightLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:heightLabel];
    
    height1Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY1+profileH*4, profileX1-profileX, profileH)];
    [height1Label setTextColor:[UIColor blackColor]];
    height1Label.text = ft_Str;
    height1Label.font = [UIFont systemFontOfSize:17];
    height1Label.alpha = 1.0;
    
    height1Label.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:height1Label];
    
    
    height2Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX+50, profileY1+profileH*4, profileX1-profileX, profileH)];
    [height2Label setTextColor:[UIColor blackColor]];
    height2Label.text = inch_Str;
    height2Label.font = [UIFont systemFontOfSize:17];
    height2Label.alpha = 1.0;
    
    height2Label.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:height2Label];
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *heighttapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heightselect)];
    heighttapGestureRecognizer.numberOfTapsRequired = 1;
    [heightLabel addGestureRecognizer:heighttapGestureRecognizer];
    heightLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *height1tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imperheightselect)];
    height1tapGestureRecognizer.numberOfTapsRequired = 1;
    [height1Label addGestureRecognizer:height1tapGestureRecognizer];
    height1Label.userInteractionEnabled = YES;
   
    UITapGestureRecognizer *height2tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imperheightselect)];
    height2tapGestureRecognizer.numberOfTapsRequired = 1;
    [height2Label addGestureRecognizer:height2tapGestureRecognizer];
    height2Label.userInteractionEnabled = YES;
    
    
    //體重
    
    CGRect kglabelFrame = CGRectMake(profileX1, profileY1+profileH*5 , self.view.frame.size.width/3 , profileH);
    kgLabel = [[UILabel alloc] initWithFrame:kglabelFrame];
    [kgLabel setTextColor:[UIColor grayColor]];
    kgLabel.text = @"kg";
    kgLabel.font = [UIFont systemFontOfSize:14];
    kgLabel.alpha = 1.0;
    kgLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:kgLabel];
    
    CGRect weightlabelFrame = CGRectMake(profileX, profileY1+profileH*5 , profileX1-profileX , profileH);
    weightLabel = [[UILabel alloc] initWithFrame:weightlabelFrame];
    [weightLabel setTextColor:[UIColor blackColor]];
    weightLabel.text = @"75.0";
    weightLabel.font = [UIFont systemFontOfSize:17];
    weightLabel.alpha = 1.0;
    weightLabel.textAlignment = NSTextAlignmentLeft;
  
    //讓label可點擊產生事件
    UITapGestureRecognizer *weighttapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weightselect)];
    weighttapGestureRecognizer.numberOfTapsRequired = 1;
    [weightLabel addGestureRecognizer:weighttapGestureRecognizer];
    weightLabel.userInteractionEnabled = YES;
    [self.profileScrollview addSubview:weightLabel];
    
    
    
    CuffSizeLabel = [[UILabel alloc] init];
    CuffSizeLabel.frame = CGRectMake(profileX, profileY1+profileH*6 , self.view.frame.size.width*0.6 , profileH);
    [CuffSizeLabel setTextColor:[UIColor blackColor]];
    CuffSizeLabel.text = CuffSizeArr[cuffsize_row];
    //CuffSizeLabel.text = @"M";
    CuffSizeLabel.font = [UIFont systemFontOfSize:17];
    CuffSizeLabel.alpha = 1.0;
    CuffSizeLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *CuffSizetapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CuffSizeselect)];
    CuffSizetapGestureRecognizer.numberOfTapsRequired = 1;
    [CuffSizeLabel addGestureRecognizer:CuffSizetapGestureRecognizer];
    CuffSizeLabel.userInteractionEnabled = YES;
    [self.profileScrollview addSubview:CuffSizeLabel];
    
    
    
    MeaArmLabel = [[UILabel alloc] init];
    MeaArmLabel.frame = CGRectMake(profileX, profileY1+profileH*7 , self.view.frame.size.width*0.6 , profileH);
    [MeaArmLabel setTextColor:[UIColor blackColor]];
    MeaArmLabel.text = MeaArmArr[measureArm_row];
    //MeaArmLabel.text = @"Left";
    MeaArmLabel.font = [UIFont systemFontOfSize:17];
    MeaArmLabel.alpha = 1.0;
    MeaArmLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *MeaArmtapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MeaArmselect)];
    MeaArmtapGestureRecognizer.numberOfTapsRequired = 1;
    [MeaArmLabel addGestureRecognizer:MeaArmtapGestureRecognizer];
    MeaArmLabel.userInteractionEnabled = YES;
    
    [self.profileScrollview addSubview:MeaArmLabel];

    

    UILabel *ArmLabel = [[UILabel alloc] init];
    ArmLabel.frame = CGRectMake(profileX+45, profileY1+profileH*7 , self.view.frame.size.width*0.6 , profileH);
    [ArmLabel setTextColor:[UIColor blackColor]];
    ArmLabel.text = @"arm";
    ArmLabel.font = [UIFont systemFontOfSize:17];
    ArmLabel.alpha = 1.0;
    ArmLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:ArmLabel];
    
    
    
    
    //<<<<<<<<<<<<<<  第二區塊 >>>>>>>>>>>>>>>>
    
    
    UIView *goalview = [[UIView alloc] initWithFrame:CGRectMake(-1, profileY2+profileH+22, self.view.frame.size.width+2, profileH*5+5)];
    goalview.backgroundColor = [UIColor whiteColor];
    goalview.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f  blue:217.0f/255.0f  alpha:0.9].CGColor;
    goalview.layer.borderWidth = 1;
    [self.profileScrollview addSubview:goalview];
    
    //分隔線
    for (int j=2; j<6; j++) {
        
        UIView *gline = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+22+profileH*j, self.view.frame.size.width*0.95, 1)];
        
        gline.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0];
        [self.profileScrollview addSubview:gline];
    }
    

    
    CGRect accountlabelFrame = CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH-2 , self.view.frame.size.width , 22);
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:accountlabelFrame];
    [accountLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    accountLabel.text = @"My Goals";
    accountLabel.font = [UIFont systemFontOfSize:22];
    accountLabel.alpha = 1.0;
    accountLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:accountLabel];
    

    
    
    UIButton *thresholdbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thresholdbBtn.frame = CGRectMake(-1, self.view.frame.size.height*1.69, self.view.frame.size.width+2, profileH);
    thresholdbBtn.backgroundColor = [UIColor whiteColor];
    thresholdbBtn.layer.borderWidth = 1;
    thresholdbBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    thresholdbBtn.layer.cornerRadius = 0;
 
    
    [self.profileScrollview addSubview:thresholdbBtn];
    
    UIButton *thresholdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thresholdBtn.frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*1.69, self.view.frame.size.width, profileH);
    [thresholdBtn setTitle:@"Threshold" forState:UIControlStateNormal];
    [thresholdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    thresholdBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    thresholdBtn.backgroundColor = [UIColor clearColor];
    thresholdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.profileScrollview addSubview:thresholdBtn];

    
    UIButton *riskbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    riskbBtn.frame = CGRectMake(-1, self.view.frame.size.height*1.8, self.view.frame.size.width+2, profileH);
    riskbBtn.backgroundColor = [UIColor whiteColor];
    riskbBtn.layer.borderWidth = 1;
    riskbBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    riskbBtn.layer.cornerRadius = 0;
    
    [riskbBtn addTarget:self action:@selector(goRFClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileScrollview addSubview:riskbBtn];
    
    UIButton *riskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    riskBtn.frame = CGRectMake(self.view.frame.size.width*0.05, 0, self.view.frame.size.width, profileH);
    [riskBtn setTitle:@"Risk Factor" forState:UIControlStateNormal];
    [riskBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    riskBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    riskBtn.backgroundColor = [UIColor clearColor];
    riskBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [riskBtn addTarget:self action:@selector(goRFClick) forControlEvents:UIControlEventTouchUpInside];
    
    [riskbBtn addSubview:riskBtn];
    
    UIButton *goriskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goriskBtn.frame = CGRectMake(self.view.frame.size.width*0.9, 0+profileH*0.315, profileH*0.37, profileH*0.37);
    [goriskBtn setImage:[UIImage imageNamed:@"all_icon_a_arrow_r"] forState:UIControlStateNormal ];
    goriskBtn.backgroundColor = [UIColor clearColor];
    goriskBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [goriskBtn addTarget:self action:@selector(goRFClick) forControlEvents:UIControlEventTouchUpInside];
    [riskbBtn addSubview:goriskBtn];

    
    UIButton *riskfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    riskfBtn.frame = CGRectMake(self.view.frame.size.width*0.53, 0, self.view.frame.size.width*0.35, profileH);
    [riskfBtn setTitle:@"Diabetes、Heart Faulure" forState:UIControlStateNormal];
    [riskfBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    riskfBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    riskfBtn.backgroundColor = [UIColor clearColor];
    riskfBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [riskfBtn addTarget:self action:@selector(goRFClick) forControlEvents:UIControlEventTouchUpInside];
    
    [riskbBtn addSubview:riskfBtn];

    
    
    
    UIButton *dateformatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateformatBtn.frame = CGRectMake(-1, self.view.frame.size.height*1.9, self.view.frame.size.width+2, profileH);
    dateformatBtn.backgroundColor = [UIColor whiteColor];
    dateformatBtn.layer.borderWidth = 1;
    dateformatBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    dateformatBtn.layer.cornerRadius = 0;
    
    [dateformatBtn addTarget:self action:@selector(changedateformat) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileScrollview addSubview:dateformatBtn];

    UILabel *dateformatLabel = [[UILabel alloc] init];
    dateformatLabel.frame = CGRectMake(self.view.frame.size.width*0.05, 2, self.view.frame.size.width, profileH/2);
    [dateformatLabel setTextColor:[UIColor blackColor]];
    dateformatLabel.text = @"Select the date format";
    dateformatLabel.font = [UIFont systemFontOfSize:20];
    dateformatLabel.alpha = 1.0;
    dateformatLabel.textAlignment = NSTextAlignmentLeft;
    [dateformatBtn addSubview:dateformatLabel];
    
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.frame = CGRectMake(self.view.frame.size.width*0.05, profileH/2, self.view.frame.size.width, profileH/2);
    [dateLabel setTextColor:[UIColor blackColor]];
    dateLabel.text = currentDateString;
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.alpha = 1.0;
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [dateformatBtn addSubview:dateLabel];
    
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(-1, self.view.frame.size.height*2, self.view.frame.size.width+2, profileH);
    deleteBtn.backgroundColor = [UIColor whiteColor];
    [deleteBtn setTitle:@"Delete Account" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:CIRCEL_RED forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    deleteBtn.layer.borderWidth = 1;
    deleteBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    deleteBtn.layer.cornerRadius = 0;
    
    [deleteBtn addTarget:self action:@selector(deleteAccount) forControlEvents:UIControlEventTouchUpInside];
    
    [self.profileScrollview addSubview:deleteBtn];

    
    
    
    
    
    
    //<<<<<<<<<<<<<<  標題 >>>>>>>>>>>>>>>>
    
   
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*0, self.view.frame.size.width/2, profileH)];
    [nameLabel setTextColor:[UIColor blackColor ]];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"Name";
    nameLabel.font = [UIFont systemFontOfSize:17];
       nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:nameLabel];
    
    UILabel *changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*1, self.view.frame.size.width/2, profileH)];
    [changeLabel setTextColor:[UIColor blackColor ]];
    changeLabel.backgroundColor = [UIColor clearColor];
    changeLabel.text = @"Change Password";
    changeLabel.font = [UIFont systemFontOfSize:17];
    changeLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:changeLabel];
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*2, self.view.frame.size.width/2, profileH)];
    [genderLabel setTextColor:[UIColor blackColor ]];
    genderLabel.backgroundColor = [UIColor clearColor];
    genderLabel.text = @"Gender";
    genderLabel.font = [UIFont systemFontOfSize:17];
    genderLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:genderLabel];
    
    UILabel *birdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*3, self.view.frame.size.width/2, profileH)];
    [birdateLabel setTextColor:[UIColor blackColor ]];
    birdateLabel.backgroundColor = [UIColor clearColor];
    birdateLabel.text = @"Date of Birth";
    birdateLabel.font = [UIFont systemFontOfSize:17];
    birdateLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:birdateLabel];
    
    UILabel *heightL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*4, self.view.frame.size.width/2, profileH)];
    [heightL setTextColor:[UIColor blackColor ]];
    heightL.backgroundColor = [UIColor clearColor];
    heightL.text = @"Height";
    heightL.font = [UIFont systemFontOfSize:17];
    heightL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:heightL];
    
    UILabel *weightL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*5, self.view.frame.size.width/2, profileH)];
    [weightL setTextColor:[UIColor blackColor ]];
    weightL.backgroundColor = [UIColor clearColor];
    weightL.text = @"Weight";
    weightL.font = [UIFont systemFontOfSize:17];
    weightL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:weightL];
    
    CGRect cufLFrame = CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*6 , self.view.frame.size.width/2 , profileH);
    UILabel *cufL = [[UILabel alloc] initWithFrame:cufLFrame];
    [cufL setTextColor:[UIColor blackColor]];
    cufL.text = @"Cuff Size";
    cufL.font = [UIFont systemFontOfSize:17];
    cufL.alpha = 1.0;
    
    cufL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview addSubview:cufL];
    
    UILabel *MeaArmL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*7, self.view.frame.size.width/2, profileH)];
    [MeaArmL setTextColor:[UIColor blackColor ]];
    MeaArmL.backgroundColor = [UIColor clearColor];
    MeaArmL.text = @"Measurement Arm";
    MeaArmL.font = [UIFont systemFontOfSize:17];
    MeaArmL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:MeaArmL];
    
    UILabel *TapL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*8, self.view.frame.size.width/2, profileH)];
    [TapL setTextColor:[UIColor blackColor ]];
    TapL.backgroundColor = [UIColor clearColor];
    TapL.text = @"Tap the unit";
    TapL.font = [UIFont systemFontOfSize:17];
    TapL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:TapL];
    
    
    UILabel *pressureL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY1+profileH*9, self.view.frame.size.width/2, profileH)];
    [pressureL setTextColor:[UIColor blackColor ]];
    pressureL.backgroundColor = [UIColor clearColor];
    pressureL.text = @"Pressure unit";
    pressureL.font = [UIFont systemFontOfSize:17];
    pressureL.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:pressureL];

    
    UILabel *systolicLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH+22, self.view.frame.size.width/2, profileH)];
    [systolicLabel setTextColor:[UIColor blackColor ]];
    systolicLabel.backgroundColor = [UIColor clearColor];
    systolicLabel.text = @"Systolic Pressure";
    systolicLabel.font = [UIFont systemFontOfSize:17];
    systolicLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:systolicLabel];
    
    UILabel *diastolicLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH*2+22, self.view.frame.size.width/2, profileH)];
    [diastolicLabel setTextColor:[UIColor blackColor ]];
    diastolicLabel.backgroundColor = [UIColor clearColor];
    diastolicLabel.text = @"Diastolic Pressure";
    diastolicLabel.font = [UIFont systemFontOfSize:17];
    diastolicLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:diastolicLabel];
    
    UILabel *goalWeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH*3+22, self.view.frame.size.width/2, profileH)];
    [goalWeightLabel setTextColor:[UIColor blackColor ]];
    goalWeightLabel.backgroundColor = [UIColor clearColor];
    goalWeightLabel.text = @"Weight";
    goalWeightLabel.font = [UIFont systemFontOfSize:17];
    goalWeightLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:goalWeightLabel];
    
    UILabel *BMILabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH*4+22, self.view.frame.size.width/2, profileH)];
    [BMILabel setTextColor:[UIColor blackColor ]];
    BMILabel.backgroundColor = [UIColor clearColor];
    BMILabel.text = @"BMI";
    BMILabel.font = [UIFont systemFontOfSize:17];
    BMILabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:BMILabel];
    //BMILabel.hidden = true;
    
    UILabel *BodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, profileY2+profileH*5+22, self.view.frame.size.width/2, profileH)];
    [BodyLabel setTextColor:[UIColor blackColor ]];
    BodyLabel.backgroundColor = [UIColor clearColor];
    BodyLabel.text = @"Body Fat";
    BodyLabel.font = [UIFont systemFontOfSize:17];
    BodyLabel.textAlignment = NSTextAlignmentLeft;
    [self.profileScrollview  addSubview:BodyLabel];
    
    
    mmHg1Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX1, profileY2+22+profileH*1 , self.view.frame.size.width/3 , profileH)];
    [mmHg1Label setTextColor:[UIColor grayColor]];
    mmHg1Label.text = @"mmHg";
    mmHg1Label.font = [UIFont systemFontOfSize:14];
    mmHg1Label.alpha = 1.0;
    mmHg1Label.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:mmHg1Label];
    
    mmHg2Label = [[UILabel alloc] initWithFrame:CGRectMake(profileX1, profileY2+22+profileH*2 , self.view.frame.size.width/3 , profileH)];
    [mmHg2Label setTextColor:[UIColor grayColor]];
    mmHg2Label.text = @"mmHg";
    mmHg2Label.font = [UIFont systemFontOfSize:14];
    mmHg2Label.alpha = 1.0;
    mmHg2Label.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:mmHg2Label];
    
    
    
    goalkgLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX1, profileY2+22+profileH*3 , self.view.frame.size.width/3 , profileH)];
    [goalkgLabel setTextColor:[UIColor grayColor]];
    goalkgLabel.text = @"kg";
    goalkgLabel.font = [UIFont systemFontOfSize:14];
    goalkgLabel.alpha = 1.0;
    goalkgLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:goalkgLabel];
    
    UILabel *percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX1, profileY2+22+profileH*5 , self.view.frame.size.width/3 , profileH)];
    [percentLabel setTextColor:[UIColor grayColor]];
    percentLabel.text = @"%";
    percentLabel.font = [UIFont systemFontOfSize:14];
    percentLabel.alpha = 1.0;
    percentLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:percentLabel];
    
    
    
    
    
    
    //<<<<<<<<<<<<<<  數值 >>>>>>>>>>>>>>>>
    
    
    
    spLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY2+22+profileH , profileX1-profileX , profileH)];
    [spLabel setTextColor:[UIColor blackColor]];
    spStr = [NSString stringWithFormat:@"%.0f",sys_pressure_value];
    spLabel.text = spStr;
    spLabel.font = [UIFont systemFontOfSize:17];
    spLabel.alpha = 1.0;
    spLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *sptapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SystolicPressureselect)];
    sptapGestureRecognizer.numberOfTapsRequired = 1;
    [spLabel addGestureRecognizer:sptapGestureRecognizer];
    spLabel.userInteractionEnabled = YES;
    
    [self.profileScrollview addSubview:spLabel];

    dpLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY2+22+profileH*2 , profileX1-profileX , profileH)];
    [dpLabel setTextColor:[UIColor blackColor]];
    dpStr = [NSString stringWithFormat:@"%.0f",dia_pressure_value];
    dpLabel.text = dpStr;
    dpLabel.font = [UIFont systemFontOfSize:17];
    dpLabel.alpha = 1.0;
    dpLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *dptapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DiastolicPressureselect)];
    dptapGestureRecognizer.numberOfTapsRequired = 1;
    [dpLabel addGestureRecognizer:dptapGestureRecognizer];
    dpLabel.userInteractionEnabled = YES;
    
    [self.profileScrollview addSubview:dpLabel];
    
    wLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY2+22+profileH*3 , profileX1-profileX , profileH)];
    [wLabel setTextColor:[UIColor blackColor]];
    wLabel.text = @"75.0";
    wLabel.font = [UIFont systemFontOfSize:17];
    wLabel.alpha = 1.0;
    wLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *wtapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Wselect)];
    wtapGestureRecognizer.numberOfTapsRequired = 1;
    [wLabel addGestureRecognizer:wtapGestureRecognizer];
    wLabel.userInteractionEnabled = YES;
    
    [self.profileScrollview addSubview:wLabel];
    
    bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY2+22+profileH*4 , self.view.frame.size.width/3 , profileH)];
    [bmiLabel setTextColor:[UIColor blackColor]];
    bmiLabel.text = @"25.0";
    bmiLabel.font = [UIFont systemFontOfSize:17];
    bmiLabel.alpha = 1.0;
    bmiLabel.textAlignment = NSTextAlignmentLeft;
    
    //讓label可點擊產生事件
    UITapGestureRecognizer *bmitapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BMIselect)];
    bmitapGestureRecognizer.numberOfTapsRequired = 1;
    [bmiLabel addGestureRecognizer:bmitapGestureRecognizer];
    [self.profileScrollview addSubview:bmiLabel];
    //bmiLabel.hidden = true;
    
    
    bfLabel = [[UILabel alloc] initWithFrame:CGRectMake(profileX, profileY2+22+profileH*5 , self.view.frame.size.width/3 , profileH)];
    [bfLabel setTextColor:[UIColor blackColor]];
    bfLabel.text = @"25.0";
    bfLabel.font = [UIFont systemFontOfSize:17];
    bfLabel.alpha = 1.0;
    bfLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.profileScrollview addSubview:bfLabel];
   

    
    
    
    
    
    
    //<<<<<<<<<<<<<<  Switch >>>>>>>>>>>>>>>>
    
    
    float switch_x = self.view.frame.size.width*0.84;
    float switch_w = profileH*1.5;
    float switch_h = switch_w*31/51;
    
    NSLog(@"h===%f",switch_h);
    NSLog(@"w===%f",switch_w);
    NSLog(@"pH===%f",profileH);
    NSLog(@"yy===%f",profileY2);
    
    UISwitch *systolicswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, profileY2+profileH+22+(profileH-31)/2, switch_w, switch_h)];
    [systolicswitch setOn:sysAtive];
    [systolicswitch addTarget:self action:@selector(systolicswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:systolicswitch];
    
    UISwitch *diastolicswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, profileY2+22+profileH*2+(profileH-31)/2, switch_w, switch_h)];
    [diastolicswitch setOn:diaAtive];
    [diastolicswitch addTarget:self action:@selector(diastolicswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:diastolicswitch];
    
    UISwitch *goalWeightswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, profileY2+22+profileH*3+(profileH-31)/2, switch_w, switch_h)];
    [goalWeightswitch setOn:goalWeightAtive];
    [goalWeightswitch addTarget:self action:@selector(goalWeightswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:goalWeightswitch];
    
    UISwitch *BMIswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, profileY2+22+profileH*4+(profileH-31)/2, switch_w, switch_h)];
    [BMIswitch setOn:BMIAtive];
    [BMIswitch addTarget:self action:@selector(BMIswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:BMIswitch];
   // BMIswitch.hidden = true;
    
    UISwitch *Bodyswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, profileY2+22+profileH*5+(profileH-31)/2, switch_w, switch_h)];
    [Bodyswitch setOn:bodyFatAtive];
    [Bodyswitch addTarget:self action:@selector(BodyswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:Bodyswitch];
    
    
    UISwitch *thresholdswitch = [[UISwitch alloc] initWithFrame:CGRectMake(switch_x, self.view.frame.size.height*1.69+(profileH-31)/2, switch_w, switch_h)];
    [thresholdswitch setOn:thresholdActive];
    [thresholdswitch addTarget:self action:@selector(thresholdswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.profileScrollview addSubview:thresholdswitch];
    
    thresholdcount = 0;  //threshold點擊次數
    
    
    
    
    if (unitBooL == 0) {
        heightLabel.hidden = NO;
        height1Label.hidden = YES;
        height2Label.hidden = YES;
        cmLabel.hidden = NO;
        cm1Label.hidden = YES;
        cm2Label.hidden = YES;
        
    }else if (unitBooL == 1){
        heightLabel.hidden = YES;
        height1Label.hidden = NO;
        height2Label.hidden = NO;
        cmLabel.hidden = YES;
        cm1Label.hidden = NO;
        cm2Label.hidden = NO;
    }
    
    
}


#pragma mark - 日期格式

-(void)changedateformat{
    
    
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *ymdformatter = [[NSDateFormatter alloc] init];
    [ymdformatter setDateStyle:NSDateFormatterShortStyle];
    [ymdformatter setTimeStyle:NSDateFormatterMediumStyle];
    [ymdformatter setDateFormat:@"YYYY/MM/dd"];
    NSString *ymdDateString = [ymdformatter stringFromDate:currentDate];
    
    NSDateFormatter *mdyformatter = [[NSDateFormatter alloc] init];
    [mdyformatter setDateStyle:NSDateFormatterShortStyle];
    [mdyformatter setTimeStyle:NSDateFormatterMediumStyle];
    [mdyformatter setDateFormat:@"MM/dd/YYYY"];
    NSString *mdyDateString = [mdyformatter stringFromDate:currentDate];
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Select the Date Format" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *yyyymmddAction = [UIAlertAction actionWithTitle:ymdDateString style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
        
        if (dateformatBool == 1) {
            
            [self YYYYMMdd];
            dateformatBool = 0;
            
        }else if (dateformatBool == 0){
            
            dateformatBool = 0;
        }
        
        
    }];
    
    [alertController addAction:yyyymmddAction];
    
    
    UIAlertAction *mmddyyyyAction = [UIAlertAction actionWithTitle:mdyDateString style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
        
        
        
        if (dateformatBool == 1) {
            
            dateformatBool = 1;
            
        }else if (dateformatBool == 0){
            
            [self MMddYYYY];
            dateformatBool = 1;
        }
        

        
        
        
    }];
    
    [alertController addAction:mmddyyyyAction];
    
    
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:closeAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
}



-(void)YYYYMMdd{
    
    NSDate *currentDate=[NSDate date];
    //取得生日label字串並轉成日期
    NSDateFormatter *birdateFormatter = [[NSDateFormatter alloc] init];
    [birdateFormatter setDateFormat:@"MM/dd/YYYY"];
    //NSDate *birthDate=[birdateFormatter dateFromString:birthdayLabel.text];
    
    if (birth_date != nil) {
         birth_date = [birdateFormatter dateFromString:birthdaydate];
    }else{
        birth_date = [birdateFormatter dateFromString:birthdayLabel.text];
    }
    
        
    NSDateFormatter *ymdformatter = [[NSDateFormatter alloc] init];
    [ymdformatter setDateStyle:NSDateFormatterShortStyle];
    [ymdformatter setTimeStyle:NSDateFormatterMediumStyle];
    [ymdformatter setDateFormat:@"YYYY/MM/dd"];
    NSString  *birthString = [ymdformatter stringFromDate:birth_date];
    
    
    currentDateString = [ymdformatter stringFromDate:currentDate];
    NSLog(@"birth_Date === %@",birth_date);
    NSLog(@"birthDateString === %@",birthString);
    NSLog(@"currentDateString === %@",currentDateString);
    NSLog(@"birthdaydate === %@",birthdaydate);
    
    
    dateLabel.text = currentDateString;
    birthdayLabel.text = birthString;
    
    
}

-(void)changetoYYYYMMdd{
    
   
    
}


-(void)MMddYYYY{
    
    NSDate *currentDate=[NSDate date];
    
    //取得生日label字串並轉成日期
    NSDateFormatter *birdateFormatter = [[NSDateFormatter alloc] init];
    [birdateFormatter setDateFormat:@"YYYY/MM/dd"];
    //NSDate *birthDate=[birdateFormatter dateFromString:birthdayLabel.text];
    

    if (birth_date != nil) {
        birth_date = [birdateFormatter dateFromString:birthdaydate];
    }else{
        birth_date = [birdateFormatter dateFromString:birthdayLabel.text];
    }
    
    
    NSDateFormatter *mdyformatter = [[NSDateFormatter alloc] init];
    [mdyformatter setDateStyle:NSDateFormatterShortStyle];
    [mdyformatter setTimeStyle:NSDateFormatterMediumStyle];
    [mdyformatter setDateFormat:@"MM/dd/YYYY"];
    
    //日期再轉成格式為MM/dd/YYYY的生日字串
    NSString *birthString = [mdyformatter stringFromDate:birth_date];
    
    
    currentDateString = [mdyformatter stringFromDate:currentDate];
    
    NSLog(@"birth_Date === %@",birth_date);
    NSLog(@"birthDateString === %@",birthString);
    NSLog(@"currentDateString === %@",currentDateString);
    NSLog(@"birthdaydate === %@",birthdaydate);
    
    dateLabel.text = currentDateString;
    birthdayLabel.text = birthString;
    
}

-(void)changetoMMddYYYY{
    
//    [self MMddYYYY];
    
    
}

#pragma mark switch
-(void)thresholdswitchAction:(id)sender{
    UISwitch *thresholdswitch = (UISwitch*)sender;
    BOOL isButtonOn = [thresholdswitch isOn];
    thresholdcount ++;
    
    
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        
        if (thresholdcount < 2) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"OPEN the Threshold & Target value displayed on the graph." message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:confirmAction];
            
            thresholdActive = YES;
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
        
        
        
        
        NSLog(@"threshold on");
    }else {
        //showSwitchValue.text = @"否";
        thresholdActive = NO;
        
        NSLog(@"threshold off");
    }
    
    NSLog(@"%d",thresholdcount);
    
}

-(void)systolicswitchAction:(id)sender{
    UISwitch *systolicswitch = (UISwitch*)sender;
    BOOL isButtonOn = [systolicswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        
        
        spLabel.userInteractionEnabled = YES;
        
        sysAtive = YES;
        
        NSLog(@"systolic on");
    }else {
        //showSwitchValue.text = @"否";
        
        spLabel.userInteractionEnabled = NO;
        
        sysAtive = NO;
        
        NSLog(@"systolic off");
    }
}

-(void)diastolicswitchAction:(id)sender{
    UISwitch *diastolicswitch = (UISwitch*)sender;
    BOOL isButtonOn = [diastolicswitch isOn];
    if (isButtonOn) {
        
        
        dpLabel.userInteractionEnabled = YES;
        
        diaAtive = YES;
        //showSwitchValue.text = @"是";
        NSLog(@"diastolic on");
    }else {
        //showSwitchValue.text = @"否";
        diaAtive = NO;
        dpLabel.userInteractionEnabled = NO;
        NSLog(@"diastolic off");
    }
}

-(void)goalWeightswitchAction:(id)sender{
    UISwitch *goalWeightswitch = (UISwitch*)sender;
    BOOL isButtonOn = [goalWeightswitch isOn];
    if (isButtonOn) {
        
        
        wLabel.userInteractionEnabled = YES;
        
        goalWeightAtive = YES;
        //showSwitchValue.text = @"是";
        NSLog(@"goalWeight on");
    }else {
        goalWeightAtive = NO;
        wLabel.userInteractionEnabled = NO;
        //showSwitchValue.text = @"否";
        NSLog(@"goalWeight off");
    }
}

-(void)BMIswitchAction:(id)sender{
    UISwitch *BMIswitch = (UISwitch*)sender;
    BOOL isButtonOn = [BMIswitch isOn];
    if (isButtonOn) {
        
         bmiLabel.userInteractionEnabled = YES;
        
        BMIAtive = YES;
        
        //showSwitchValue.text = @"是";
        NSLog(@"BMI on");
    }else {
        //showSwitchValue.text = @"否";
        BMIAtive = NO;
        bmiLabel.userInteractionEnabled = NO;
        NSLog(@"BMI off");
    }
}


-(void)BodyswitchAction:(id)sender{
    UISwitch *Bodyswitch = (UISwitch*)sender;
    BOOL isButtonOn = [Bodyswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        
        //讓label可點擊產生事件
        UITapGestureRecognizer *btapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BodyFatselect)];
        btapGestureRecognizer.numberOfTapsRequired = 1;
        [bfLabel addGestureRecognizer:btapGestureRecognizer];
        bfLabel.userInteractionEnabled = YES;
        bodyFatAtive = YES;
        NSLog(@"Body on");
    }else {
        //showSwitchValue.text = @"否";
        bodyFatAtive = NO;
        bfLabel.userInteractionEnabled = NO;
        
        NSLog(@"Body off");
    }
}


#pragma mark - 刪除帳號資料
-(void)deleteAccount{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure to delete your account and all records in APP?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler: ^(UIAlertAction * _Nonnull action) {
        UIViewController *LoginVC = [[UIViewController alloc ]init];
        LoginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        
        LoginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:LoginVC animated:true completion:nil];
    }];
    
    
    //LoginVC
    
    [alertController addAction:resetAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)threshold{
    NSLog(@"threshold");
    
    
    
}


#pragma mark - PickerView 方法處理
-(void)heightselect{
    
    [self allpickerView];
  //  [self pickertopView];
    
    
    
    heightPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.3,30, self.view.frame.size.width*0.4, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //身高
    Height = [[NSMutableArray alloc] init];
    //设置pickerView的代理和数据源
    heightPickerView.dataSource = self;
    heightPickerView.delegate = self;
    
    
    int hvalue = [heightLabel.text intValue];
    
    
    
    for(int h=91; h<=242; h++)     //91~242    100~200
    {
        [Height addObject:[NSString stringWithFormat:@"%d",h]];
    }
    [heightPickerView selectRow:hvalue-91 inComponent:0 animated:NO];
    
    
    
    
    self.height = Height;
    
    h_unit = @[@"cm"];
    
//    ,@"1",@"2",@"3",@"4",@"5"
//    [heightPickerView selectRow:5 inComponent:1 animated:NO];
    
    
    CGRect hlabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *hLabel = [[UILabel alloc] initWithFrame:hlabelFrame];
    [hLabel setTextColor:[UIColor blackColor]];
    hLabel.text = @"Height";
    hLabel.font = [UIFont systemFontOfSize:22];
    hLabel.alpha = 1.0;
    hLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.allPickerView addSubview:heightPickerView];
    
    
    [self.topView addSubview:hLabel];
    
  
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveheightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    
}

-(void)imperheightselect{
    
    [self allpickerView];
    //  [self pickertopView];
    
    
    height1PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.1,30, self.view.frame.size.width*0.4, self.view.frame.size.height*0.3)];
    
    height2PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5,30, self.view.frame.size.width*0.4, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //身高
    ftArr = [[NSMutableArray alloc] init];
    inchArr = [[NSMutableArray alloc] init];
    
    //设置pickerView的代理和数据源
    height1PickerView.dataSource = self;
    height1PickerView.delegate = self;
    
    height2PickerView.dataSource = self;
    height2PickerView.delegate = self;
    
    
    int hvalue = [height1Label.text intValue];
    //double h1value = [height2Label.text doubleValue];
    
    
    for(int h=3; h<=7; h++)
        {
            [ftArr addObject:[NSString stringWithFormat:@"%d",h]];
            
//            if (h==3) {
//                for(float n=3.4; n<12.0; n = n+0.1 )
//                {
//                    [inchArr addObject:[NSString stringWithFormat:@"%.1f",n]];
//                    
//                }
//
//            }else if (h==7){
//                
//                for(float n=0.0; n<2.6; n = n+0.1 )
//                {
//                    [inchArr addObject:[NSString stringWithFormat:@"%.1f",n]];
//                    
//                }
//                
//
//            }else{
            
            
            }
            
            
       // }
        [height1PickerView selectRow:hvalue-3 inComponent:0 animated:NO];
    
    for(float n=0.0; n<12.0; n = n+0.1 )
    {
        [inchArr addObject:[NSString stringWithFormat:@"%.1f",n]];
        
    }

    
    
    for (int i=0; i<inchArr.count; i++) {
        NSString *HinchStr = [NSString stringWithFormat:@"%@",[inchArr objectAtIndex:i]];
        
        if ([height2Label.text isEqualToString:HinchStr]) {
            NSLog(@"HinchStr===%@",HinchStr);
            NSLog(@"inch === %@",height2Label.text);
            [height2PickerView selectRow:i inComponent:0 animated:NO];
            NSLog(@"pickerview i:%d",i);
        }
        
    }
    
    
    //3 3.37
    //7 2.61
    
    
    
    
   NSLog(@"inchArr.count === %lu",(unsigned long)inchArr.count);
    
    self.ftarray = ftArr;
    self.incharray = inchArr;
    h_ft_unit = @[@"ft"];
    h_in_unit = @[@"inch"];
    
    
    
    
    CGRect hlabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *hLabel = [[UILabel alloc] initWithFrame:hlabelFrame];
    [hLabel setTextColor:[UIColor blackColor]];
    hLabel.text = @"Height";
    hLabel.font = [UIFont systemFontOfSize:22];
    hLabel.alpha = 1.0;
    hLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.allPickerView addSubview:height1PickerView];
    [self.allPickerView addSubview:height2PickerView];
    
    [self.topView addSubview:hLabel];
    
    
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveheight1Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    
}

-(void)saveheight1Click{
    
    [self closePickerviewfunc];
    
    [self saveft];
    [self saveinch];
    
    if (stringHft != nil && stringHin != nil) {
        double hei1value = [stringHft doubleValue];
        double hei2value = [stringHin doubleValue];
        NSString *im_to_me_heiStr = [NSString stringWithFormat:@"%.0f",((hei1value+hei2value/12)/cm_ft)];
        height_value = [im_to_me_heiStr intValue];

    }else if (stringHft != nil && stringHin == nil){
        
        double hei1value = [stringHft doubleValue];
        double hei2value = [height2Label.text doubleValue];
        NSString *im_to_me_heiStr = [NSString stringWithFormat:@"%.0f",((hei1value+hei2value/12)/cm_ft)];
        height_value = [im_to_me_heiStr intValue];
        
        
    }else if (stringHft == nil && stringHin != nil){
        
        double hei1value = [height1Label.text doubleValue];
        double hei2value = [stringHin doubleValue];
        NSString *im_to_me_heiStr = [NSString stringWithFormat:@"%.0f",((hei1value+hei2value/12)/cm_ft)];
        height_value = [im_to_me_heiStr intValue];
        
        
    
    }else{
        
        double hei1value = [height1Label.text doubleValue];
        double hei2value = [height2Label.text doubleValue];
        NSString *im_to_me_heiStr = [NSString stringWithFormat:@"%.0f",((hei1value+hei2value/12)/cm_ft)];
        height_value = [im_to_me_heiStr intValue];
        
    }
    
    
    NSLog(@"英制儲存身高的時候轉公制%d",height_value);
    
}

-(void)saveft{
    if (stringHft!=nil) {
        height1Label.text = stringHft;
    }

}

-(void)saveinch{
    if (stringHin!=nil) {
        height2Label.text = stringHin;
    }
    
    
}

-(void)weightselect{
    
    [self allpickerView];
   // [self pickertopView];
    
    weightPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.3,30, self.view.frame.size.width*0.4, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    Weight = [[NSMutableArray alloc] init];
    //設置pickerView的代理和数据源
    weightPickerView.dataSource = self;
    weightPickerView.delegate = self;
    
    int wvalue = [weightLabel.text intValue];
    
    if (unitsegmentedControl.selectedSegmentIndex == 0) {
        
        for(float w=5.0 ; w <= 150.0; w+=0.1)
        {
            [Weight addObject:[NSString stringWithFormat:@"%.1f",w]];

        }
        [weightPickerView selectRow:wvalue-5 inComponent:0 animated:NO];
        w_unit = @[@"kg"];
        for (int i = 0; i<Weight.count; i++) {
            NSString *wwStr = [NSString stringWithFormat:@"%@",[Weight objectAtIndex:i]];
            
            if ([weightLabel.text isEqualToString:wwStr]) {
                NSLog(@" wwStr == %@",wwStr);
                
                [weightPickerView selectRow:i inComponent:0 animated:NO];
            }
            
        }

        
    }else if (unitsegmentedControl.selectedSegmentIndex == 1){
        
        for(float w=11.0 ; w <= 331.0; w+=0.1)
        {
            [Weight addObject:[NSString stringWithFormat:@"%.1f",w]];
            
        }
        
        for (int i=0; i<Weight.count; i++) {
            NSString *wStr = [NSString stringWithFormat:@"%@",[Weight objectAtIndex:i]];
            
            if ([weightLabel.text isEqualToString:wStr]) {
                [weightPickerView selectRow:i inComponent:0 animated:NO];
            }
            
        }
        w_unit = @[@"lb"];
        
    }

    self.weight = Weight;
    
    
    
    
    CGRect weilabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *weiLabel = [[UILabel alloc] initWithFrame:weilabelFrame];
    [weiLabel setTextColor:[UIColor blackColor]];
    weiLabel.text = @"Weight";
    weiLabel.font = [UIFont systemFontOfSize:22];
    weiLabel
    .alpha = 1.0;
    weiLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.allPickerView addSubview:weightPickerView];
    
    

    [self.topView addSubview:weiLabel];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [saveBtn addTarget:self action:@selector(saveweightClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:saveBtn];
}


//
-(void)CuffSizeselect{
    
  
    
    [self allpickerView];
    
    csPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    //设置pickerView的代理和數據源
    csPickerView.dataSource = self;
    csPickerView.delegate = self;
    [self.allPickerView addSubview:csPickerView];
    
    if ([CuffSizeLabel.text  isEqual: @"S"] ) {
        [csPickerView selectRow:0 inComponent:0 animated:NO];
    }else if ([CuffSizeLabel.text  isEqual: @"M-L"]){
        [csPickerView selectRow:2 inComponent:0 animated:NO];
    }else if ([CuffSizeLabel.text  isEqual: @"L"]){
        [csPickerView selectRow:3 inComponent:0 animated:NO];
    }else if ([CuffSizeLabel.text  isEqual: @"L-X"]){
        [csPickerView selectRow:4 inComponent:0 animated:NO];
    }else{
        [csPickerView selectRow:1 inComponent:0 animated:NO];
    }
    
    
    
    
    CGRect clabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *cLabel = [[UILabel alloc] initWithFrame:clabelFrame];
    [cLabel setTextColor:[UIColor blackColor]];
    cLabel.text = @"Cuff Size";
    cLabel.font = [UIFont systemFontOfSize:22];
    cLabel.alpha = 1.0;
    cLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:cLabel];
    
 
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveCuffSizeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:savehBtn];

    
}

-(void)saveCuffSizeClick{
    
    [self closePickerviewfunc];
    
    if (stringCSize != nil) {
        CuffSizeLabel.text = stringCSize;
    }
    
}


-(void)MeaArmselect{
    
    
    
    [self allpickerView];
    
    maPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.3,30, self.view.frame.size.width*0.4, self.view.frame.size.height*0.3)];
    //设置pickerView的代理和数据源
    maPickerView.dataSource = self;
    maPickerView.delegate = self;
    [self.allPickerView addSubview:maPickerView];
    
    if ([MeaArmLabel.text isEqual:@"Right"]) {
        [maPickerView selectRow:1 inComponent:0 animated:NO];
    }else{
        [maPickerView selectRow:0 inComponent:0 animated:NO];
    }
    
    
    
    CGRect clabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *cLabel = [[UILabel alloc] initWithFrame:clabelFrame];
    [cLabel setTextColor:[UIColor blackColor]];
    cLabel.text = @"Measurement Arm";
    cLabel.font = [UIFont systemFontOfSize:22];
    cLabel.alpha = 1.0;
    cLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:cLabel];
    
    
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveMeaArmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:savehBtn];
    
    
}

-(void)saveMeaArmClick{
    
    [self closePickerviewfunc];
    
    if (stringArm != nil) {
        MeaArmLabel.text = stringArm;
    }
    
    
}



-(void)SystolicPressureselect{
    [self allpickerView];
    
    sysPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //血壓
    Sys = [[NSMutableArray alloc] init];
    //设置pickerView的代理和数据源
    sysPickerView.dataSource = self;
    sysPickerView.delegate = self;
    
    double sysvalue = [spLabel.text doubleValue];
    
    if (pressuresegmentedControl.selectedSegmentIndex == 0) {
        for(int s=20 ; s <= 280; s++)
        {
            [Sys addObject:[NSString stringWithFormat:@"%d",s]];
            
            
        }
        
        [sysPickerView selectRow:sysvalue-20 inComponent:0 animated:NO];

    }else if (pressuresegmentedControl.selectedSegmentIndex == 1){
        
        for (double s=2.6; s<=37.3; s = s+0.1 ) {
            [Sys addObject:[NSString stringWithFormat:@"%.1f",s]];
        }
        
        for (int i=0; i<Sys.count; i++) {
            NSString *SysStr = [NSString stringWithFormat:@"%@",[Sys objectAtIndex:i]];
            
            if ([spLabel.text isEqualToString:SysStr]) {
                [sysPickerView selectRow:i inComponent:0 animated:NO];
            }
            
        }
        
        
    }
    
    
    self.sys = Sys;
    
    
    
    CGRect slabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *sLabel = [[UILabel alloc] initWithFrame:slabelFrame];
    [sLabel setTextColor:[UIColor blackColor]];
    sLabel.text = @"Systolic Pressure";
    sLabel.font = [UIFont systemFontOfSize:22];
    sLabel.alpha = 1.0;
    sLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.allPickerView addSubview:sysPickerView];
    
    
    [self.topView addSubview:sLabel];
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveSysClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    

}

//讓label顯示Pickerview的內容
-(void)saveSysClick{
    
    [self closePickerviewfunc];
    
    if (stringS != nil) {
        spLabel.text = stringS;
        
        if (pressureBooL == 0) {
            sys_pressure_value = [stringS floatValue];
        }else if (pressureBooL == 1){
            
            double sp1value = [stringS doubleValue];
            NSString *savesysStr = [NSString stringWithFormat:@"%.0f",sp1value/mmHg_kPa];
            sys_pressure_value = [savesysStr floatValue];

            
        }
        
        
    }
    
    
    
}


-(void)DiastolicPressureselect{
    [self allpickerView];
    
    diaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    
    //初始化数据
       //血壓
    Dia = [[NSMutableArray alloc] init];
    //设置pickerView的代理和数据源
    diaPickerView.dataSource = self;
    diaPickerView.delegate = self;
    
    
    double diavalue = [dpLabel.text doubleValue];
    
    if (pressuresegmentedControl.selectedSegmentIndex == 0) {
        
        for(double d = 20 ; d <= 280; d++){
            
            [Dia addObject:[NSString stringWithFormat:@"%.0f",d]];
            
        }
        
        [diaPickerView selectRow:diavalue-20 inComponent:0 animated:NO];
        
    }else if (pressuresegmentedControl.selectedSegmentIndex == 1){
        
        for(double d = 2.6 ; d <= 37.3; d = d+0.1 ){
        
        [Dia addObject:[NSString stringWithFormat:@"%.1f",d]];
            
        }
        
        for (int i=0; i < Dia.count; i++) {
            NSString *DiaStr = [NSString stringWithFormat:@"%@",[Dia objectAtIndex:i]];
            
            if ([dpLabel.text isEqualToString:DiaStr]) {
                NSLog(@"DiaStr = %@",DiaStr);
                [diaPickerView selectRow:i inComponent:0 animated:NO];
            }
        }
        
        
        //[diaPickerView selectRow:(diavalue-2.6)*10 inComponent:0 animated:NO];
        
    }
    
    
    
    self.dia = Dia;
    
    
   
     [self.allPickerView addSubview:diaPickerView];
    
    CGRect dlabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *dLabel = [[UILabel alloc] initWithFrame:dlabelFrame];
    [dLabel setTextColor:[UIColor blackColor]];
    dLabel.text = @"Diastolic Pressure";
    dLabel.font = [UIFont systemFontOfSize:22];
    dLabel.alpha = 1.0;
    dLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.topView addSubview:dLabel];
    

    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveDiaClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    

}

-(void)saveDiaClick{
    
    [self closePickerviewfunc];
    
    if (stringD != nil) {
        dpLabel.text = stringD;
        
        if (pressureBooL == 0) {
            dia_pressure_value = [stringD floatValue];
            
        }else if (pressureBooL == 1){
            
            double dp1value = [stringD doubleValue];
            NSString *diaString = [NSString stringWithFormat:@"%.0f",dp1value/mmHg_kPa];
            dia_pressure_value = [diaString floatValue];
            
        }
        
        
    }
    
    
}

-(void)Wselect{
    [self allpickerView];
    
    wPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //體重
    Ww = [[NSMutableArray alloc] init];
    
    //设置pickerView的代理和数据源
    wPickerView.dataSource = self;
    wPickerView.delegate = self;
    
    //double wwvalue = [wLabel.text doubleValue];
    
    if (unitsegmentedControl.selectedSegmentIndex == 0) {
        for(double w=5.0 ; w <= 150.0; w+=0.1)
        {
            [Ww addObject:[NSString stringWithFormat:@"%.1f",w]];
            //NSLog(@"%d",i);
        }
        
        for (int i = 0; i<Ww.count; i++) {
            NSString *wwStr = [NSString stringWithFormat:@"%@",[Ww objectAtIndex:i]];
            
            if ([wLabel.text isEqualToString:wwStr]) {
                NSLog(@" wwStr == %@",wwStr);
                
                [wPickerView selectRow:i inComponent:0 animated:NO];
            }
            
        }

        
        
    }else if (unitsegmentedControl.selectedSegmentIndex == 1){
        
        for(double w=11.0 ; w <= 331.0; w+=0.1)
        {
            [Ww addObject:[NSString stringWithFormat:@"%.1f",w]];
        }
        
        for (int i = 0; i<Ww.count; i++) {
            NSString *wwStr = [NSString stringWithFormat:@"%@",[Ww objectAtIndex:i]];
            
            if ([wLabel.text isEqualToString:wwStr]) {
                NSLog(@" wwStr == %@",wwStr);
                
                [wPickerView selectRow:i inComponent:0 animated:NO];
            }
            
        }

        
    }
    
    
    self.ww = Ww;
    
    NSLog(@"%@",Ww);
    
    
    CGRect slabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *sLabel = [[UILabel alloc] initWithFrame:slabelFrame];
    [sLabel setTextColor:[UIColor blackColor]];
    sLabel.text = @"Weight";
    sLabel.font = [UIFont systemFontOfSize:22];
    sLabel.alpha = 1.0;
    sLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.allPickerView addSubview:wPickerView];
    
    
    [self.topView addSubview:sLabel];
    

    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveWeiClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    

    
}

-(void)saveWeiClick{
    
    [self closePickerviewfunc];
    
    if (stringWei != nil) {
        self.wLabel.text = stringWei;
        
        if (unitBooL == 0) {
            goalweight_value = [stringWei floatValue];
            NSLog(@"儲存的公制目標體重%.1f",goalweight_value);
            
        }else if (unitBooL == 1){
            double goalwei1value = [stringWei doubleValue];
            NSString *im_to_me_goalweiStr = [NSString stringWithFormat:@"%.1f",goalwei1value/kg_lb];
            goalweight_value = [im_to_me_goalweiStr floatValue];
            NSLog(@"儲存的英制轉公制目標體重%.1f",goalweight_value);
            
        }
        
        
    }
    
    
    

    NSLog(@"%@",stringWei);
    
}



-(void)BMIselect{
    
    [self allpickerView];
    
    bmiPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //BMI
    BMI = [[NSMutableArray alloc] init];
    
    //设置pickerView的代理和数据源
    bmiPickerView.dataSource = self;
    bmiPickerView.delegate = self;
    
    
    for(float s=10.0 ; s <= 90.0; s+=0.1)
    {
        [BMI addObject:[NSString stringWithFormat:@"%.1f",s]];
        //NSLog(@"%d",i);
    }
    
    self.bMI = BMI;
    
    for (int i = 0; i<BMI.count; i++) {
        NSString *bmiStr = [NSString stringWithFormat:@"%@",[BMI objectAtIndex:i]];
        
        if ([bmiLabel.text isEqualToString:bmiStr]) {
            NSLog(@" bmiStr == %@",bmiStr);
            
            [bmiPickerView selectRow:i inComponent:0 animated:NO];
        }
        
    }

    
//    float bmivalue = [bmiLabel.text floatValue];
//    [bmiPickerView selectRow:(bmivalue-10.0)*10 inComponent:0 animated:NO];
    
    
    CGRect slabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *sLabel = [[UILabel alloc] initWithFrame:slabelFrame];
    [sLabel setTextColor:[UIColor blackColor]];
    sLabel.text = @"BMI";
    sLabel.font = [UIFont systemFontOfSize:22];
    sLabel.alpha = 1.0;
    sLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    [self.allPickerView addSubview:bmiPickerView];
        [self.topView addSubview:sLabel];
    
    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveBMIClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    
}

//讓label顯示Pickerview的內容
-(void)saveBMIClick{
    
    [self closePickerviewfunc];
    
    if (stringBMI != nil) {
        bmiLabel.text = stringBMI;
    }
    
    
}



-(void)BodyFatselect{
    
    [self allpickerView];
    
    bfPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.35,30, self.view.frame.size.width*0.33, self.view.frame.size.height*0.3)];
    
    //初始化数据
    
    //體脂
    BF = [[NSMutableArray alloc] init];
    
    
    //设置pickerView的代理和数据源
    bfPickerView.dataSource = self;
    bfPickerView.delegate = self;
    
    for(float s=5.0 ; s <= 60.0; s+=0.1)
    {
        [BF addObject:[NSString stringWithFormat:@"%.1f",s]];
        //NSLog(@"%d",i);
    }
    
    for (int i = 0; i<BF.count; i++) {
        NSString *bfStr = [NSString stringWithFormat:@"%@",[BF objectAtIndex:i]];
        
        if ([bfLabel.text isEqualToString:bfStr]) {
            NSLog(@" bfStr == %@",bfStr);
            
            [bfPickerView selectRow:i inComponent:0 animated:NO];
        }
        
    }

    
    
    self.bF = BF;
    float bfvalue = [bfLabel.text floatValue];
    [bfPickerView selectRow:(bfvalue-5.0)*10 inComponent:0 animated:NO];

    
    
    CGRect slabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *sLabel = [[UILabel alloc] initWithFrame:slabelFrame];
    [sLabel setTextColor:[UIColor blackColor]];
    sLabel.text = @"Body Fat";
    sLabel.font = [UIFont systemFontOfSize:22];
    sLabel.alpha = 1.0;
    sLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.allPickerView addSubview:bfPickerView];
    [self.topView addSubview:sLabel];
    

    
    UIButton *savehBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savehBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savehBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savehBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savehBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savehBtn addTarget:self action:@selector(saveBFClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savehBtn];
    

}

//讓label顯示Pickerview的內容
-(void)saveBFClick{
    
    [self closePickerviewfunc];
    
    if ( stringBF != nil) {
        bfLabel.text = stringBF;
    }
    
    
}




// returns the number of 'columns' to display.返回列數
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.heightPickerView || pickerView == self.weightPickerView  || pickerView == self.height1PickerView || pickerView == self.height2PickerView) {
        return 2;
//    }else if (pickerView == self.height1PickerView){
//        return 4;
    
    }else{
        return 1;
    }
    
    
}
// returns the # of rows in each component..返回第component列第row行的個數
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
   
    
    if ( thePickerView == self.heightPickerView ){
        
        switch (component)
        {
            case 0:
                return [Height count];
                break;
            case 1:
                return  h_unit.count;
                break;
            default:
                return 0;
                break;
        }
    }else if( thePickerView == self.weightPickerView ){
        
        switch (component)
        {
            case 0:
                return [Weight count];
                break;
            case 1:
                return  w_unit.count;
                break;
            default:
                return 0;
                break;
        }
    }else if( thePickerView == self.height1PickerView ){
       
        switch (component)
        {
            case 0:
                return [ftArr count];
                break;
            case 1:
                return h_ft_unit.count;
                break;
//            case 2:
//                return [inchArr count];
//                break;
//            case 3:
//                return h_in_unit.count;
//                break;
            default:
                return 0;
                break;
        }
        
    }else if( thePickerView == self.height2PickerView ){
        
        switch (component)
        {
                
            case 0:
                return [inchArr count];
                break;
            case 1:
                return h_in_unit.count;
                break;
            default:
                return 0;
                break;
        }
        
        
        
    }else if( thePickerView == self.sysPickerView ){
        NSLog(@"sys");
        switch (component)
        {
            case 0:
                return [Sys count];
                break;
            case 1:
                return 0;
                break;
            default:
                return 0;
                break;
        }
    }else if( thePickerView == self.diaPickerView ){
        NSLog(@"dia");
        switch (component)
        {
            case 0:
                
                return [Dia count];
                
                
            case 1:
                return 0;
                
            default:
                return 0;
                break;
        }
        
    }else if( thePickerView == self.wPickerView ){
   
        
        return [Ww count];
        
    }else if( thePickerView == self.bmiPickerView ){
       
        
        return [BMI count];
        
    }else if( thePickerView == self.bfPickerView ){
       
        
        return [BF count];
        
        
    }else if( thePickerView == self.csPickerView){
        
        return CuffSizeArr.count;
        
    }else if ( thePickerView == self.maPickerView){
        
        return MeaArmArr.count;
    }else{
        return 0;
    }
    
    
}




//返回文字數據
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
    
    if ( thePickerView == self.heightPickerView ){
        switch (component)
        {
            case 0:
                return[Height objectAtIndex:row];
                break;
            case 1:
                return[h_unit objectAtIndex:row];
                break;
                
            default:
                return 0;
                break;
        }
    }else if( thePickerView == self.weightPickerView ){
        switch (component)
        {
            case 0:
                return[Weight objectAtIndex:row];
                break;
            case 1:
                return[w_unit objectAtIndex:row];
                break;
                
            default:
                return 0;
                break;
        }
    }else if ( thePickerView == self.height1PickerView ){
        
        switch (component)
        {
            case 0:
                return [ftArr objectAtIndex:row];
                break;
            case 1:
                return [h_ft_unit objectAtIndex:row] ;
                break;
                
//            case 2:
//                return [inchArr objectAtIndex:row];
//                break;
//             
//            case 3:
//                return [h_in_unit objectAtIndex:row];
//                break;
//                
            default:
                return 0;
                break;
        }
        
    }else if ( thePickerView == self.height2PickerView ){
        
        switch (component)
        {
                
            case 0:
                return [inchArr objectAtIndex:row];
                break;
                
            case 1:
                return [h_in_unit objectAtIndex:row];
                break;
                
            default:
                return 0;
                break;
        }
        
        
    }else if ( thePickerView == self.sysPickerView ){
        
        switch (component)
        {
            case 0:
                return [Sys objectAtIndex:row];
                break;
            case 1:
                return 0 ;
                break;
                
            default:
                return 0;
                break;
        }
    }else if ( thePickerView == self.diaPickerView ){
        
        switch (component)
        {
            case 0:
                return [Dia objectAtIndex:row];
                
                break;
            case 1:
                return 0 ;
                break;
                
            default:
                return 0;
                break;
        }
    }else if ( thePickerView == self.wPickerView ){
        
        return [Ww objectAtIndex:row];
        
    }else if ( thePickerView == self.bmiPickerView ){
        
        return [BMI objectAtIndex:row];
        
    }else if ( thePickerView == self.bfPickerView ){
        
        return [BF objectAtIndex:row];
        
    }else if ( thePickerView == self.csPickerView ){
        
        return [CuffSizeArr objectAtIndex:row];
        
    }else if ( thePickerView == self.maPickerView ){
        
        return [MeaArmArr objectAtIndex:row];
        
    }else{
        return 0;
    }
}




//判断选择的某一列,顯示對應的文字數據到label
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if ( pickerView == self.heightPickerView ){
        
        
        switch (component) {
            case 0:
                stringH  = [Height objectAtIndex:row];
                break;
            case 1:
                self.cmLabel.text = [h_unit objectAtIndex:row];
                break;
        }
    }else if( pickerView == self.weightPickerView ){
        switch (component) {
            case 0:
                stringW = [Weight objectAtIndex:row];
                break;
            case 1:
                self.kgLabel.text = [w_unit objectAtIndex:row];
                break;
        }
    }else if( pickerView == self.sysPickerView ){
        switch (component) {
            case 0:
                stringS = [Sys objectAtIndex:row];
                break;
            case 1:
                
                break;
        }
        
    }else if( pickerView == self.diaPickerView ){
        switch (component) {
            case 0:
                stringD = [Dia objectAtIndex:row];
                break;
            case 1:
                
                break;
        }
    }else if( pickerView == self.height1PickerView ){
        
          
        
        switch (component) {
            case 0:
                 stringHft = [ftArr objectAtIndex:row];
                break;
            case 1:
                break;
            default:
                break;
        }
       
        
    }else if( pickerView == self.height2PickerView ){
        
        
        
        switch (component) {
            case 0:
                stringHin = [inchArr objectAtIndex:row];
                
                break;
            case 1:
                break;
            default:
                break;
        }
        

        
        
    }else if( pickerView == self.wPickerView ){
        stringWei = [Ww objectAtIndex:row];
        
    }else if( pickerView == self.bmiPickerView ){
        stringBMI = [BMI objectAtIndex:row];
        
    }else if( pickerView == self.bfPickerView ){
        
        stringBF = [BF objectAtIndex:row];
        
    }else if ( pickerView == self.csPickerView ){
        
        stringCSize = [CuffSizeArr objectAtIndex:row];
        cuffsize_row = row;
        
    }else if ( pickerView == self.maPickerView ){
        
        stringArm = [MeaArmArr objectAtIndex:row];
        measureArm_row = row;
        
    }else{
        NSLog(@"123");
    }
   
}




//設置每一列的寬度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = 0.0f;
    switch (component)
    {
        case 0:
            width = 70;
            break;
        case 1:
            width = 60;
            break;
        case 2:
            width = 70;
            break;
        case 3:
            width = 60;
            break;
            }
    return width;
}

-(void)allpickerViewShow{
 
    pickerB.hidden = false;
    allPickerView.hidden = false;
    topView.hidden = false;
    
    }



-(void)allpickerView{
    
    pickerB = [UIButton buttonWithType:UIButtonTypeCustom];
    pickerB.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    pickerB.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    //[bpmbBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pickerB];
    
    //pickerB.hidden = true;
    
    allPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.66, self.view.frame.size.width, self.view.frame.size.height)];
    allPickerView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    [self.view addSubview:allPickerView];
    
    //allPickerView.hidden = true;
    
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.66, self.view.frame.size.width, self.view.frame.size.height/17)];
    topView.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0];
    [self.view addSubview:topView];
    
    //topView.hidden = true;
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [closeBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [closeBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [closeBtn addTarget:self action:@selector(cancelpickerClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:closeBtn];
    
    
    


    
}

-(void)birthdayPickerShow{
    
    birDatepicker.hidden = NO;
    
}

-(void)birthdayPicker{
    
    [self allpickerView];
    
    
    
    //[birtapGestureRecognizer addTarget:self action:@selector(birthdayPickerShow) ];
    
    //日期選擇器
    birDatepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.66+33, self.view.frame.size.width, self.view.frame.size.height*0.3)];
    birDatepicker.hidden = NO;
    //NSDate *date = [[NSDate alloc] initWithString:@""];
   // birDatepicker.date = [NSDate date];  // 設置初始時間
    
    
    birDatepicker.datePickerMode = UIDatePickerModeDate;  //設置日期樣式
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if (dateformatBool == 0) {
        [dateFormat setDateFormat:@"YYYY/MM/dd"];
        NSDate *anyDate = [dateFormat dateFromString:birthdayLabel.text];
        [birDatepicker setDate:anyDate];
    }else if (dateformatBool == 1){
        [dateFormat setDateFormat:@"MM/dd/YYYY"];
        NSDate *anyDate = [dateFormat dateFromString:birthdayLabel.text];
        [birDatepicker setDate:anyDate];
    }
    
    
    [birDatepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    
    //NSString *datepicker = [dateFormat stringFromDate:birDatepicker.date];
    
    
    
    [self.view addSubview:birDatepicker]; // 添加到View上
    
    
    CGRect blabelFrame = CGRectMake(self.view.frame.size.width/4, 0 , self.view.frame.size.width/2 , self.view.frame.size.height/17);
    UILabel *bLabel = [[UILabel alloc] initWithFrame:blabelFrame];
    [bLabel setTextColor:[UIColor blackColor]];
    bLabel.text = @"Birthday";
    bLabel
    .font = [UIFont systemFontOfSize:22];
    bLabel.alpha = 1.0;
    bLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.topView addSubview:bLabel];

    UIButton *savebirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebirBtn.frame = CGRectMake(self.view.frame.size.width*0.8, 0, self.view.frame.size.width*0.2, self.view.frame.size.height/17);
    [savebirBtn setTitle:@"Save" forState:UIControlStateNormal];
    [savebirBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    savebirBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [savebirBtn addTarget:self action:@selector(savebirClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.topView addSubview:savebirBtn];
    
    
    NSLog(@"birthdayPicker");
}




-(void)savebirClick{
    
    if (birthdaydate != nil) {
        [self.birthdayLabel setText:birthdaydate];
    }
    
    
  //  [self.birDatepicker removeFromSuperview];
    
//    allPickerView.hidden = true;
//    pickerB.hidden = true;
//    topView.hidden = true;
    
    [self.allPickerView removeFromSuperview];
    [self.pickerB removeFromSuperview];
    [self.topView removeFromSuperview];
    [self.birDatepicker removeFromSuperview];
//    birDatepicker.hidden = YES;
    
    
}

-(void)saveheightClick{
    [self closePickerviewfunc];
    
    if (stringH != nil) {
        heightLabel.text = stringH;
        height_value = [stringH floatValue];
    }
    
    
}

-(void)saveweightClick{
    
    [self closePickerviewfunc];
    
    if (stringW != nil) {
        weightLabel.text = stringW;
        
        //判斷公英制
        if (unitBooL == 0) {
            weight_value = [stringW floatValue];
            
        }else if (unitBooL == 1){
            double wei1value = [stringW doubleValue];
            NSString *saveWeiStr = [NSString stringWithFormat:@"%.1f",wei1value/kg_lb];
            weight_value = [saveWeiStr floatValue];
            
        }
        
    
    }
    
    
  
    
    
}


-(void)cancelpickerClick{
    
    //[self.heightPickerView removeFromSuperview];
    [self.birDatepicker removeFromSuperview];
    [self closePickerviewfunc];

}


-(void)closePickerviewfunc{
    
//    allPickerView.hidden = true;
//    pickerB.hidden = true;
//    topView.hidden = true;
    
    [self.allPickerView removeFromSuperview];
    [self.pickerB removeFromSuperview];
    [self.topView removeFromSuperview];
    birDatepicker.hidden = YES;
    
    
}


-(void)dateChanged:(id)sender{
    
    NSDate *select = [sender date]; // 獲取被選中的時間
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    if (dateformatBool == 0) {
        selectDateFormatter.dateFormat = @"YYYY/MM/dd"; // 設置時間和日期的格式
    }else if (dateformatBool == 1){
        selectDateFormatter.dateFormat = @"MM/dd/YYYY"; // 設置時間和日期的格式
    }
    
    birthdaydate = [selectDateFormatter stringFromDate:select]; // 把date類型轉為設置好格式的string類型
    
    //透過UIDatePicker的date屬性取得使用者選取的日期, 並透過NSDateFormatter轉換成字串
//    NSString *date = [NSDateFormatter stringFromDate:picker.date];
    
    //設定標籤的文字為選取日期的文字
   
    
    NSLog(@"生日為 %@",birthdaydate);
    
    NSLog(@"%@",[sender date]);

    

}


- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        genderBooL = 0;
        
    }else{
        genderBooL = 1;
        
    }
}

-(void)unitSegmentControlAction:(UISegmentedControl *)segment{
    
    heiStr = heightLabel.text;
    weiStr = weightLabel.text;
    goalweiStr = wLabel.text;
    
    
    if (segment.selectedSegmentIndex == 0) {
        
        
        heightLabel.hidden = NO;
        height1Label.hidden = YES;
        height2Label.hidden = YES;
        cmLabel.hidden = NO;
        cm1Label.hidden = YES;
        cm2Label.hidden = YES;
        
        unitBooL = 0;
        
        kgLabel.text = @"kg";
        goalkgLabel.text = @"kg";
        
        kg_lb_c = 1;
        cm_ft_c = 1;
       
        
        
        if (stringH != nil) {
            
             heightLabel.text = [NSString stringWithFormat:@"%d",height_value];
        }else{
           
            double hei1value = [height1Label.text doubleValue];
            double hei2value = [height2Label.text doubleValue];
            NSString *im_to_me_heiStr = [NSString stringWithFormat:@"%.0f",((hei1value+hei2value/12)/cm_ft)];
            heightLabel.text = im_to_me_heiStr;
            stringH = im_to_me_heiStr;
            
        }
        
        
        if (stringW != nil) {
            
            weightLabel.text = [NSString stringWithFormat:@"%.1f",weight_value];
            
            
        }else{
            
            double wei1value = [weiStr doubleValue];
            NSString *im_to_me_weiStr = [NSString stringWithFormat:@"%.1f",wei1value/kg_lb];
            weightLabel.text = im_to_me_weiStr;
            stringW = im_to_me_weiStr;
        }
        
        
        if (stringWei !=nil ) {
            
            wLabel.text = [NSString stringWithFormat:@"%.1f",goalweight_value];
        }else{
            
            double goalwei1value = [goalweiStr doubleValue];
            NSString *im_to_me_goalweiStr = [NSString stringWithFormat:@"%.1f",goalwei1value/kg_lb];
            wLabel.text = im_to_me_goalweiStr;
            stringWei = im_to_me_goalweiStr;
        }
        
        
        
        
        
    }else{
        
        heightLabel.hidden = YES;
        height1Label.hidden = NO;
        height2Label.hidden = NO;
        cmLabel.hidden = YES;
        cm1Label.hidden = NO;
        cm2Label.hidden = NO;
        
        unitBooL = 1;
        
        kgLabel.text = @"lb";
        goalkgLabel.text = @"lb";
        
        kg_lb_c = 2.20462;
        cm_ft_c = 0.03306878;
        
        
        //身高轉字串
//        double hei2value = [heiStr doubleValue];
        //公分轉英呎
        NSString *ft_1Str = [NSString stringWithFormat:@"%.2f", height_value*cm_ft];
        NSString *ft_2Str = [ft_1Str substringWithRange:NSMakeRange(0, 1)];
        //公分轉英呎
        NSString *hei2222str = [NSString stringWithFormat:@"%f",height_value*cm_ft];
        int ft_value = [ft_2Str intValue];
        double hei2222value = [hei2222str doubleValue];
        
        
        
        //英呎扣掉整數位後剩餘部分轉英吋
        NSString *inch_1Str = [NSString stringWithFormat:@"%.1f",(hei2222value-ft_value)*12];
        
        NSLog(@"ft====== %@",ft_2Str);
        NSLog(@"ft====== %@",ft_1Str);
        NSLog(@"inch=====%@",hei2222str);
        
        height1Label.text = ft_2Str;     //英呎
        height2Label.text = inch_1Str;    //英吋
        
        
        
        //double wei2value = [weiStr doubleValue];
        NSString *me_to_im_weiStr = [NSString stringWithFormat:@"%.1f",weight_value*kg_lb];
        weightLabel.text = me_to_im_weiStr;
        
        //double goalwei2value = [goalweiStr doubleValue];
        NSString *me_to_im_goalweiStr = [NSString stringWithFormat:@"%.1f",goalweight_value*kg_lb];
        wLabel.text = me_to_im_goalweiStr;
        
        
        
        
    }
    
    
}



-(void)pressureSegmentControlAction:(UISegmentedControl *)segment{
    
    spStr = spLabel.text;
    dpStr = dpLabel.text;
    
    
    if (segment.selectedSegmentIndex == 0) {
        mmHg1Label.text = @"mmHg";
        mmHg2Label.text = @"mmHg";
        
        mmHg_kPa_c = 1;
        pressureBooL = 0;
        
        if (stringS != nil) {
            spLabel.text = [NSString stringWithFormat:@"%.0f",sys_pressure_value];
        }else{
            double sp1value = [spStr doubleValue];
            NSString *syspreStr = [NSString stringWithFormat:@"%.0f",sp1value/mmHg_kPa];
            spLabel.text = syspreStr;
        }
        
        if (stringD != nil) {
            dpLabel.text = [NSString stringWithFormat:@"%.0f",dia_pressure_value];
        }else{
            
            double dp1value = [dpStr doubleValue];
            dpStr = [NSString stringWithFormat:@"%.0f",dp1value/mmHg_kPa];
            dpLabel.text = dpStr;
            
        }
        
        
        
    }else{
        mmHg1Label.text = @"kpa";
        mmHg2Label.text = @"kpa";
        
        mmHg_kPa_c = 0.13332237;
        pressureBooL = 1;
        
        double sp2value = [spStr doubleValue];
        spStr = [NSString stringWithFormat:@"%.1f",sp2value*mmHg_kPa];
        spLabel.text = spStr;
        double dp2value = [dpStr doubleValue];
        dpStr = [NSString stringWithFormat:@"%.1f",dp2value*mmHg_kPa];
        dpLabel.text = dpStr;
        
    }
    
    
}



//限制輸入字數
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (nameTextField == textField)//这个 if 判断是在多个输入框的时候,只限制一个输入框的时候用的,如果全部限制,则不加 if 判断即可,这里是只判断输入用户名的输入框
    {
        if ([aString length] > 50) {
            textField.text = [aString substringToIndex:50];
            
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





-(void)goRFClick{
    UIViewController *RiskFactors = [[UIViewController alloc ]init];
    RiskFactors = [self.storyboard instantiateViewControllerWithIdentifier:@"RiskFactors"];
    
    RiskFactors.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:RiskFactors animated:true completion:nil];

}

-(void)gochangepasswordClick{
    UIViewController *ChangePassword = [[UIViewController alloc ]init];
    ChangePassword = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePassword"];
    
    ChangePassword.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:ChangePassword animated:true completion:nil];
    
}

#pragma mark - 儲存帳戶資料

-(void)saveProfile{
    
    profile_name = nameTextField.text;   //使用者姓名
    
    [ProfileClass sharedInstance].name = nameTextField.text;
    [ProfileClass sharedInstance].birthday = birthDateString;
    [ProfileClass sharedInstance].bp_measurement_arm = measureArm_row;
    [ProfileClass sharedInstance].cuff_size = cuffsize_row;
    [ProfileClass sharedInstance].userHeight = height_value;
    [ProfileClass sharedInstance].userWeight = weight_value;
    [ProfileClass sharedInstance].goal_weight = goalweight_value;
    [ProfileClass sharedInstance].sys = sys_pressure_value;
    [ProfileClass sharedInstance].dia = dia_pressure_value;
    [ProfileClass sharedInstance].bmi = BMI_value;
    [ProfileClass sharedInstance].body_fat = BF_value;
    [ProfileClass sharedInstance].userGender = genderBooL;
    [ProfileClass sharedInstance].sys_unit = pressureBooL;
    [ProfileClass sharedInstance].unit_type = unitBooL;
    [ProfileClass sharedInstance].sys_activity = sysAtive;
    [ProfileClass sharedInstance].dia_activity = diaAtive;
    [ProfileClass sharedInstance].weight_activity = goalWeightAtive;
    [ProfileClass sharedInstance].bmi_activity = BMIAtive;
    [ProfileClass sharedInstance].body_fat_activity = bodyFatAtive;
    [ProfileClass sharedInstance].threshold = thresholdActive;

    [[ProfileClass sharedInstance] updateData];
    
    //BMI_value = [bmiLabel.text floatValue];     //BMI
    //BF_value =  [bfLabel.text floatValue];    //體脂
    
    
    //cuffsize_row;          //袖口尺寸
    //measureArm_row;        //手臂尺寸
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}
@end

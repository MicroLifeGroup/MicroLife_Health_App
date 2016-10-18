//
//  MainSettingViewController.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MainSettingViewController.h"

@interface MainSettingViewController (){
    
    NSMutableArray *Devicearray ;
    NSUInteger iDevice;
    CGRect deviceTVOriFrame;
    UIView *settingV;
    UILabel *DMLabel;
    
}

@end

@implementation MainSettingViewController
@synthesize settingSV;
@synthesize syncview;
@synthesize bpmbBtn;
@synthesize DeviceManagementTV;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    Devicearray = [[NSMutableArray alloc]init];
    [Devicearray addObject:@"Microlife1"];
    [Devicearray addObject:@"Microlife2"];
    [Devicearray addObject:@"Microlife3"];
    [Devicearray addObject:@"Microlife4"];
    [Devicearray addObject:@"Microlife5"];
    
    iDevice = Devicearray.count;
    
    [DeviceManagementTV reloadData];
    
    [self settingView];
    [self dataswitchBtn];
    [self healthswitchBtn];
    [self microsoftswitchBtn];
    NSLog(@"finish");
    
    
    //改變self.title 的字體顏色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //改變 navigationBar 的底色
    self.navigationController.navigationBar.barTintColor = STANDER_COLOR;
    
    //改變 statusBarStyle(字體變白色)
    //先將 info.plist 中的 View controller-based status bar appearance 設為 NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //設定leftBarButtonItem(profileBt)
    UIButton *leftItemBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    
    [leftItemBt setImage:[UIImage imageNamed:@"all_btn_a_menu"] forState:UIControlStateNormal];
    
    [leftItemBt addTarget:self action:@selector(profileBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemBt];
    
    //設定 titleView
    UIView *theTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width/3, self.navigationController.navigationBar.frame.size.height)];
    
    theTitleView.backgroundColor = [UIColor clearColor];
//    
//    //titleLabel
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theTitleView.frame.size.width, theTitleView.frame.size.height/3*2)];
//    
//    titleLabel.text = @"Setting";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.adjustsFontSizeToFitWidth = YES;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [theTitleView addSubview:titleLabel];
//    titleLabel.font = [UIFont systemFontOfSize:17];
//    
//    self.navigationItem.titleView = theTitleView;
    
    self.title = @"Setting";
}




#pragma mark - profileBtAction (導覽列左邊按鍵方法)
//----------------------------------------------
-(void)profileBtAction {
    
    [self SidebarBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)settingView{
    
    [DeviceManagementTV reloadData];
    
    float setH = self.view.frame.size.height*0.09;
    
    
    float setAY = self.view.frame.size.height*0.05;
    
    float DMTV_Y = self.view.frame.size.height*0.4;
    
    NSInteger d = Devicearray.count;
    
    float DMTV_H = setH*d;
    
    float setY = self.view.frame.size.height*0.39+DMTV_H*1.04;
    
    
    settingSV.frame = self.view.bounds;
    settingSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    settingSV.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0];
    settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+DMTV_H);
    settingSV.delegate = self;
    //settingSV.pagingEnabled = false;
    settingSV.showsVerticalScrollIndicator = false;
    
    [self.view addSubview:settingSV];
    
    
    
    
    
    CGRect DMlabelFrame = CGRectMake(self.view.frame.size.width*0.05,DMTV_Y-22, self.view.frame.size.width , 17);
    DMLabel = [[UILabel alloc] initWithFrame:DMlabelFrame];
    [DMLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    DMLabel.text = @"Device management...";
    DMLabel.font = [UIFont systemFontOfSize:17];
    DMLabel.alpha = 1.0;
    DMLabel.textAlignment = NSTextAlignmentLeft;
    [self.settingSV addSubview:DMLabel];
    
    
    
    self.DeviceManagementTV = [[UITableView alloc]initWithFrame:CGRectMake(-1, DMTV_Y, self.view.frame.size.width+2, DMTV_H)];
    
    self.DeviceManagementTV.delegate = self;
    self.DeviceManagementTV.dataSource = self;
    DeviceManagementTV.layer.borderWidth = 1;
    DeviceManagementTV.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    [self.settingSV addSubview:self.DeviceManagementTV];
    
    //紀錄原 deviceTV 的 frame
    deviceTVOriFrame = DeviceManagementTV.frame;
    
    
    [self.DeviceManagementTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"devieccell_ID"];
    
    
    
    CGRect accountlabelFrame = CGRectMake(self.view.frame.size.width*0.05,setAY, self.view.frame.size.width , 22);
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:accountlabelFrame];
    [accountLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    accountLabel.text = @"Account";
    accountLabel.font = [UIFont systemFontOfSize:22];
    accountLabel.alpha = 1.0;
    accountLabel.textAlignment = NSTextAlignmentLeft;
    [self.settingSV addSubview:accountLabel];
    
    UIButton *profilebBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    profilebBtn.frame = CGRectMake(-1, setAY+self.view.frame.size.height*0.04, self.view.frame.size.width+2, setH);
    profilebBtn.backgroundColor = [UIColor whiteColor];
    profilebBtn.layer.borderWidth = 1;
    profilebBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    profilebBtn.layer.cornerRadius = 0;
    [profilebBtn setSelected:NO];//設置按鈕的狀態是否為選中(可在此根據具體情況來設置按鈕的初始狀態)
    
    [profilebBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.settingSV addSubview:profilebBtn];
    
    UIButton *profileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    profileBtn.frame = CGRectMake(self.view.frame.size.width*0.05, setAY+self.view.frame.size.height*0.04, self.view.frame.size.width, setH);
    [profileBtn setTitle:@"My Profile" forState:UIControlStateNormal];
    [profileBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    profileBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    profileBtn.backgroundColor = [UIColor clearColor];
    profileBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //設置按鈕的字樣距離邊界
    //[profileBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, self.view.frame.size.width*0.05, 0, self.view.frame.size.width*0.7)];
    [profileBtn setSelected:NO];//設置按鈕的狀態是否為選中(可在此根據具體情況來設置按鈕的初始狀態)
    
    [profileBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.settingSV addSubview:profileBtn];
    
    CGRect mydevicelabelFrame = CGRectMake(self.view.frame.size.width*0.05, setAY+self.view.frame.size.height*0.17 , self.view.frame.size.width , 22);
    UILabel *mydeviceLabel = [[UILabel alloc] initWithFrame:mydevicelabelFrame];
    [mydeviceLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    mydeviceLabel.text = @"My Device";
    mydeviceLabel.font = [UIFont systemFontOfSize:22];
    mydeviceLabel.alpha = 1.0;
    mydeviceLabel.textAlignment = NSTextAlignmentLeft;
    [self.settingSV addSubview:mydeviceLabel];
    
    UIButton *mydeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mydeviceBtn.frame = CGRectMake(-1, setAY+self.view.frame.size.height*0.21, self.view.frame.size.width+2, setH);
    mydeviceBtn.backgroundColor = [UIColor whiteColor];
    mydeviceBtn.layer.borderWidth = 1;
    mydeviceBtn.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
    mydeviceBtn.layer.cornerRadius = 0;
    [mydeviceBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    [mydeviceBtn setEnabled:NO];
    
    [self.settingSV addSubview:mydeviceBtn];
    
    
    CGRect microlifelabelFrame = CGRectMake(self.view.frame.size.width*0.26, setAY+self.view.frame.size.height*0.21 , self.view.frame.size.width/2 , setH);
    UILabel *microlifeLabel = [[UILabel alloc] initWithFrame:microlifelabelFrame];
    [microlifeLabel setTextColor:[UIColor blackColor ]];
    microlifeLabel.text = @"Microlife 001";
    microlifeLabel.font = [UIFont systemFontOfSize:17];
    microlifeLabel.alpha = 1.0;
    microlifeLabel.textAlignment = NSTextAlignmentLeft;
    [self.settingSV addSubview:microlifeLabel];
    
    
    UIImageView *setproductImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, setAY+self.view.frame.size.height*0.215 , setH*0.9 , setH*0.9)];
    UIImage *setproductImage = [UIImage imageNamed:@"setting_icon_a_product"];
  //  UIImage *setproductImage = [UIImage imageNamed:@"reminder_icon_a_tick"];
    setproductImageView.image = setproductImage;
    setproductImageView.contentMode = UIViewContentModeScaleAspectFit;
    //personalImageView = [[UIImageView alloc] initWithImage:personImage];
    //设置图片的Frame
    //[personalImageView setFrame:CGRectMake(80.0f,80.0f, imageRadius, imageRadius)];
    
    //self.view.backgroundColor = [UIColor clearColor];
    [self.settingSV addSubview:setproductImageView];
    
    
    settingV = [[UIView alloc] initWithFrame:CGRectMake(0, setY, self.view.frame.size.width, setH*5.3+4+self.view.frame.size.height*0.12)];
    settingV.backgroundColor = [UIColor clearColor];
    [self.settingSV addSubview:settingV];
    
    
    
    CGRect synclabelFrame = CGRectMake(self.view.frame.size.width*0.05, 0 , self.view.frame.size.width/2 , 22);
    UILabel *syncLabel = [[UILabel alloc] initWithFrame:synclabelFrame];
    [syncLabel setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:1.0 ]];
    syncLabel.text = @"Sync";
    syncLabel.font = [UIFont systemFontOfSize:22];
    syncLabel.alpha = 1.0;
    syncLabel.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:syncLabel];
    
    syncview = [[UIView alloc] initWithFrame:CGRectMake(-1, self.view.frame.size.height*0.04, self.view.frame.size.width+2, setH*3.3+4)];
    syncview.backgroundColor = [UIColor whiteColor];
    syncview.layer.borderWidth = 1;
    syncview.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0].CGColor;
    [settingV addSubview:syncview];
    
    CGRect data1Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+2 , self.view.frame.size.width*0.3 , setH*0.45);
    UILabel *data1Label = [[UILabel alloc] initWithFrame:data1Frame];
    [data1Label setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0 ]];
    //  data1Label.backgroundColor = [UIColor blueColor];
    data1Label.text = @"Data Sync";
    data1Label.font = [UIFont systemFontOfSize:21];
    data1Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:data1Label];
    
    CGRect data2Frame = CGRectMake(self.view.frame.size.width*0.33, self.view.frame.size.height*0.04+2.5 , self.view.frame.size.width*3/4 , setH*0.45);
    UILabel *data2Label = [[UILabel alloc] initWithFrame:data2Frame];
    [data2Label setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0 ]];
    data2Label.text = @"@ 2016/04/08 14:30";
    data2Label.font = [UIFont systemFontOfSize:14];
    data2Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:data2Label];
    
    CGRect data3Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+setH/2 , self.view.frame.size.width*3/4 , setH*0.55);
    UILabel *data3Label = [[UILabel alloc] initWithFrame:data3Frame];
    [data3Label setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:0.9 ]];
    data3Label.text = @"Uploading your measure datas to \nMicrolife Connected Health + automatically.";
    data3Label.numberOfLines = 2 ;
    // data3Label.backgroundColor = [UIColor blueColor];
    data3Label.font = [UIFont systemFontOfSize:13];
    data3Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:data3Label];
    
    
    
    UIView *syncline1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, setH*1.1+1+self.view.frame.size.height*0.04, self.view.frame.size.width*0.95, 1)];
    syncline1.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0];
    [settingV addSubview:syncline1];
    
    //=====================================================
    
    CGRect health1Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+4+setH*1.1 , self.view.frame.size.width*0.3 , setH*0.45);
    UILabel *health1Label = [[UILabel alloc] initWithFrame:health1Frame];
    [health1Label setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0 ]];
    //  data1Label.backgroundColor = [UIColor blueColor];
    health1Label.text = @"Health Kit";
    health1Label.font = [UIFont systemFontOfSize:21];
    health1Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:health1Label];
    
    CGRect health2Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+setH*3.3/2 , self.view.frame.size.width*3/4 , setH*0.55);
    UILabel *health2Label = [[UILabel alloc] initWithFrame:health2Frame];
    [health2Label setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:0.9 ]];
    health2Label.text = @"Sync Health Kit infomation with Microlife Connected Health + automatically.";
    health2Label.numberOfLines = 2 ;
    // data3Label.backgroundColor = [UIColor blueColor];
    health2Label.font = [UIFont systemFontOfSize:13];
    health2Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:health2Label];
    
    
    
    UIView *syncline2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, setH*2.2+2+self.view.frame.size.height*0.04, self.view.frame.size.width*0.95, 1)];
    syncline2.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0];
    [settingV addSubview:syncline2];
    
    //=====================================================
    
    CGRect  microsoft1Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+6+setH*2.2 , self.view.frame.size.width*0.3 , setH*0.45);
    UILabel * microsoft1Label = [[UILabel alloc] initWithFrame: microsoft1Frame];
    [health1Label setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0 ]];
    microsoft1Label.text = @"Microsoft";
    microsoft1Label.font = [UIFont systemFontOfSize:21];
    microsoft1Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview:microsoft1Label];
    
    CGRect  microsoft2Frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.04+setH*5.5/2 , self.view.frame.size.width*3/4 , setH*0.55);
    UILabel * microsoft2Label = [[UILabel alloc] initWithFrame: microsoft2Frame];
    [microsoft2Label setTextColor:[UIColor colorWithRed:115.0f/255.0f green:116.0f/255.0f blue:117.0f/255.0f alpha:0.9 ]];
    microsoft2Label.text = @"Sync Microsoft Health infomation with Microlife Connected Health + automatically.";
    microsoft2Label.numberOfLines = 2 ;
    // data3Label.backgroundColor = [UIColor blueColor];
    microsoft2Label.font = [UIFont systemFontOfSize:13];
    microsoft2Label.textAlignment = NSTextAlignmentLeft;
    [settingV addSubview: microsoft2Label];
    
    UIButton *mailbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mailbBtn.frame = CGRectMake(-1, setH*3.3+4+self.view.frame.size.height*0.08, self.view.frame.size.width+2, setH);
    mailbBtn.backgroundColor = [UIColor whiteColor];
    mailbBtn.layer.borderWidth = 1;
    mailbBtn.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0].CGColor;
    mailbBtn.layer.cornerRadius = 0;
    [mailbBtn addTarget:self action:@selector(goMailNotification) forControlEvents:UIControlEventTouchUpInside];
    
    [settingV addSubview:mailbBtn];
    
    UIButton *mailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mailBtn.frame = CGRectMake(self.view.frame.size.width*0.05, setH*3.3+4+self.view.frame.size.height*0.08, self.view.frame.size.width, setH);
    [mailBtn setTitle:@"Mail Notification management" forState:UIControlStateNormal];
    [mailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mailBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    mailBtn.backgroundColor = [UIColor clearColor];
    mailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [mailBtn setSelected:NO];//設置按鈕的狀態是否為選中(可在此根據具體情況來設置按鈕的初始狀態)
    
    [mailBtn addTarget:self action:@selector(goMailNotification) forControlEvents:UIControlEventTouchUpInside];
    [settingV addSubview:mailBtn];
    
    UIButton *gomailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gomailBtn.frame = CGRectMake(self.view.frame.size.width*0.9, setH*3.615+4+self.view.frame.size.height*0.08, setH*0.37, setH*0.37);
    [gomailBtn setImage:[UIImage imageNamed:@"all_icon_a_arrow_r"] forState:UIControlStateNormal ];
    gomailBtn.backgroundColor = [UIColor clearColor];
    gomailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [gomailBtn addTarget:self action:@selector(goMailNotification) forControlEvents:UIControlEventTouchUpInside];
    [settingV addSubview:gomailBtn];
    
    
    bpmbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bpmbBtn.frame = CGRectMake(-1, setH*4.3+4+self.view.frame.size.height*0.12, self.view.frame.size.width+2, setH);
    bpmbBtn.backgroundColor = [UIColor whiteColor];
    bpmbBtn.layer.borderWidth = 1;
    bpmbBtn.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0].CGColor;
    bpmbBtn.layer.cornerRadius = 0;
    [bpmbBtn setEnabled:NO];
    //[bpmbBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    
    [settingV addSubview:bpmbBtn];
    
    
    UIButton *bpmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bpmBtn.frame = CGRectMake(self.view.frame.size.width*0.05, setH*4.3+4+self.view.frame.size.height*0.12, self.view.frame.size.width, setH);
    [bpmBtn setTitle:@"Delete BPM Device Datas" forState:UIControlStateNormal];
    [bpmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bpmBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    bpmBtn.backgroundColor = [UIColor clearColor];
    bpmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bpmBtn setSelected:NO];//設置按鈕的狀態是否為選中(可在此根據具體情況來設置按鈕的初始狀態)
    
    // [bpmBtn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
    [bpmbBtn setEnabled:NO];
    
    [settingV addSubview:bpmBtn];
    
    
    UISwitch *bpmswitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width*6/7, setH*4.55+4+self.view.frame.size.height*0.12, self.bpmbBtn.frame.size.height/2, self.bpmbBtn.frame.size.height/4)];
    [bpmswitch setOn:YES];
    [bpmswitch addTarget:self action:@selector(BPMswitchAction:) forControlEvents:UIControlEventValueChanged];
    [settingV addSubview:bpmswitch];
}

-(void)profileClick{
    
    UIViewController *ProfileV = [[UIViewController alloc ]init];
    ProfileV = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileV"];
    //ProfileV.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    ProfileV.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:ProfileV animated:true completion:nil];
    
    
    
    NSLog(@"profileClick");
}

//float setH = self.view.frame.size.height*0.09;
//float setY = self.view.frame.size.height*0.47;

-(void)dataswitchBtn{
    UISwitch *dataswitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width*6/7, self.syncview.frame.size.height/12,  self.syncview.frame.size.height/3,  self.syncview.frame.size.height/6)];
    [dataswitch setOn:NO];
    [dataswitch addTarget:self action:@selector(dataswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.syncview addSubview:dataswitch];
}

-(void)dataswitchAction:(id)sender
{
    UISwitch *dataswitch = (UISwitch*)sender;
    BOOL isButtonOn = [dataswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        NSLog(@"data on");
    }else {
        //showSwitchValue.text = @"否";
        NSLog(@"data off");
    }
}
-(void)healthswitchBtn{
    UISwitch *healthswitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width*6/7,  self.syncview.frame.size.height*5/12 ,  self.syncview.frame.size.height/3,  self.syncview.frame.size.height/6)];
    [healthswitch setOn:NO];
    [healthswitch addTarget:self action:@selector(healthswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.syncview addSubview:healthswitch];
}

-(void)healthswitchAction:(id)sender
{
    UISwitch *healthswitch = (UISwitch*)sender;
    BOOL isButtonOn = [healthswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        NSLog(@"health on");
    }else {
        //showSwitchValue.text = @"否";
        NSLog(@"health off");
    }
}

-(void)microsoftswitchBtn{
    UISwitch *microsoftswitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width*6/7, self.syncview.frame.size.height*9/12,  self.syncview.frame.size.height/3,  self.syncview.frame.size.height/6)];
    [microsoftswitch setOn:NO];
    [microsoftswitch addTarget:self action:@selector(microsoftswitchAction:) forControlEvents:UIControlEventValueChanged];
    [self.syncview addSubview:microsoftswitch];
}

-(void)microsoftswitchAction:(id)sender
{
    UISwitch *microsoftswitch = (UISwitch*)sender;
    BOOL isButtonOn = [microsoftswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        NSLog(@"microsoft on");
    }else {
        //showSwitchValue.text = @"否";
        NSLog(@"microsoft off");
    }
}



-(void)BPMswitchAction:(id)sender
{
    UISwitch *bpmswitch = (UISwitch*)sender;
    BOOL isButtonOn = [bpmswitch isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        NSLog(@"BPM on");
    }else {
        //showSwitchValue.text = @"否";
        NSLog(@"BPM off");
    }
}

-(void)goMailNotification{
    UIViewController *MailNotification = [[UIViewController alloc ]init];
    MailNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"MailNotification"];
    
    MailNotification.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:MailNotification animated:true completion:nil];
}




#pragma mark - 代理方法  顯示選中行的單元格信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self->Devicearray[indexPath.row]);
    
    
    
}

#pragma mark - 設置顯示分區數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 數據源 每個分區對應的函數設置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    iDevice = Devicearray.count;
    
    [self refreshDMframe:iDevice];
    
    return Devicearray.count;
}

-(void)refreshDMframe:(NSUInteger)num {
    
    CGFloat settingSVH = self.view.frame.size.height*0.09;
    
    if (num >= 5) {
        
        DeviceManagementTV.frame = deviceTVOriFrame;
        
    }
    else if (num == 4) {
        
        DeviceManagementTV.frame = CGRectMake(deviceTVOriFrame.origin.x, deviceTVOriFrame.origin.y, deviceTVOriFrame.size.width, settingSVH*4);
        
        settingV.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height*0.09);
        settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+settingSVH*4.6)  ;
        
        
    }
    else if (num == 3) {
        
        DeviceManagementTV.frame = CGRectMake(deviceTVOriFrame.origin.x, deviceTVOriFrame.origin.y, deviceTVOriFrame.size.width, settingSVH*3);
        
        settingV.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height*0.09*2);
        settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+settingSVH*3.5)  ;
        
    }
    else if (num == 2) {
        
        DeviceManagementTV.frame = CGRectMake(deviceTVOriFrame.origin.x, deviceTVOriFrame.origin.y, deviceTVOriFrame.size.width, settingSVH*2);
        
        settingV.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height*0.09*3);
        settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+settingSVH*2.4)  ;
        
        
    }
    else if (num == 1){
    
        DeviceManagementTV.frame = CGRectMake(deviceTVOriFrame.origin.x, deviceTVOriFrame.origin.y, deviceTVOriFrame.size.width, settingSVH*1);
        
        settingV.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height*0.09*4);
        settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+settingSVH*1.3)  ;
        
    
    }
    else {
        
        DeviceManagementTV.frame = CGRectMake(deviceTVOriFrame.origin.x, deviceTVOriFrame.origin.y, deviceTVOriFrame.size.width, deviceTVOriFrame.size.height*0);
        
        settingV.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height*0.09*5.5);
        settingSV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.22+settingSVH*0.2)  ;
        
        DMLabel.hidden = YES;
        
    }

    
}

#pragma mark - 數據源 每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity=@"devieccell_ID";
    UITableViewCell *DeviceCell=[tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
    
    
    
    
    DeviceCell.textLabel.text=Devicearray[indexPath.row];
    
    DeviceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *OBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OBtn.frame = CGRectMake(self.view.frame.size.width*0.95-self.view.frame.size.height*0.04, self.view.frame.size.height*0.025, self.view.frame.size.height*0.04, self.view.frame.size.height*0.04);
    [OBtn setImage:[UIImage imageNamed:@"setting_btn_a_delete"] forState:UIControlStateNormal ];
    
    
    OBtn.backgroundColor = [UIColor clearColor];
    OBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  
    //[OBtn addTarget:self action:@selector(addMail)];
    [DeviceCell addSubview:OBtn];
    

        return DeviceCell;
    
    //    static NSString *CellIdentifier = @"cellMember";
    //    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        //cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MemberCell"owner:self options:nil];
    //        cell = [nib objectAtIndex:0];
    //
    //        cell.MemberL.text = self.person[indexPath.row];
    //        cell.checkboxBtn.tag = (int)indexPath.row;
    //       // [cell.checkboxBtn addTarget:self action:@selector(memberselect:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    }
    //
    //    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *detailAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Detail" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self.DeviceManagementTV setEditing:NO];
    }];
    
    detailAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self.DeviceManagementTV setEditing:YES];
        
        [Devicearray removeObjectAtIndex:indexPath.row];//移除數據源的數據
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的數據
        [DeviceManagementTV reloadData];
        
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[deleteAction,detailAction];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height*0.09 ;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    if ([segue.identifier isEqualToString:@"mailcell"])
    //    {
    //        NSIndexPath *indexPath = (NSIndexPath *)sender;
    //        EditMailNotificationViewController *editV = segue.destinationViewController;
    //        editV.str = [mailItem objectAtIndex:indexPath.row];
    //    }
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return TRUE;
    
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    return UITableViewCellEditingStyleDelete;
//    
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {//如果編輯樣式為删除樣式
//        
//        if (indexPath.row<[Devicearray count]) {
//            
//            [Devicearray removeObjectAtIndex:indexPath.row];//移除數據源的數據
//            
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的數據
//            [DeviceManagementTV reloadData];
//            
//        }
//        
//    }
//    
//}








@end

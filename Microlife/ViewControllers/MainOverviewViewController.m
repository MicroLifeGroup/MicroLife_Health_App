

#import "MainOverviewViewController.h"
#import "HealthEducationViewController.h"
#import "NotificationViewController.h"
#import "AboutViewController.h"
#import "LogoutViewController.h"

//pickerViews
//-------------------------------
#import "BloodPressurePickerView.h"
#import "PULPickerView.h"
#import "TimePickerView.h"
#import "DatePickerView.h"

//circleView
//-------------------------------
#import "OverViewCircleView.h"


//TableViewCells
//--------------------------------
#import "OverBPTableViewCell.h"
#import "OverWeightTableViewCell.h"
#import "OverTempTableViewCell.h"



@interface MainOverviewViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    //擷取裝置時間
    //-----------------------------------
    NSTimer *getDateTimer;
    UILabel *timeLabel;
    
    //切割單位長度
    //-----------------------------------
    CGFloat unitHeight;
    

    //顯示 體溫-血壓-體重列表 (包含箭頭 及 list名稱)
    //-----------------------------------
    UIView *listView;
    UILabel *listLable;
    UIImageView *listArrowImg;
    UIButton *listBt;
    UIView *listSperatorView;
    BOOL isListAction;//顯示列表
    
    
    
    //overview scrollView
    //-----------------------------------
    UIScrollView *overView_scrollView;
    NSMutableArray <UIView *> *ary_overView_subViews;
    UIPageControl *page;
    //三個 overview scrollView 的 subViews
    UIView *bloodPressureView;
    UIView *weightView;
    UIView *bodyTemperatureView;
    
    //各頁大小圓
    //------------------------------------
    //bloodPressure
    OverViewCircleView *bloodPressureCircleView;
    OverViewCircleView *bloodPressureCircleSmallView;
    
    //weight
    OverViewCircleView *weightCircleView;
    OverViewCircleView *weightCircleSmallView;
    
    //bodyTemperature
    OverViewCircleView *bodyTemperatureCircleView;
    OverViewCircleView *bodyTemperatureCircleSmallView;
    
    
    //pickerViewvu相關
    //-----------------------------------
    UITextField *callPickerView;
    
    //bloodPressure
    BloodPressurePickerView *bpPickerView;
    UIToolbar *bloodPressureToolBar;
    
    //pul
    PULPickerView *pulPickerView;
    UIToolbar *pulToolBar;
    
    //time
    TimePickerView *timePickerView;
    UIToolbar *timeToolBar;
    
    //date
    DatePickerView *datePickerView;
    UIToolbar *dateToolBar;
    
    
    
    //各頁之曲線按鍵
    //---------------------------------
    //SYS/DIA 曲線按鍵
    UIButton *sysAndDiaCurveBt;
    //PUL 曲線按鍵
    UIButton *pulCurveBt;
    //bpRainbowBarBt
    UIButton *bpRainbowBarBt;
    BOOL isBPRainbowBarBtSelected;
    
    //WEI 曲線按鍵
    UIButton *weiCurveBt;
    //BMI 曲線按鍵
    UIButton *bmiCurveBt;
    //FAT 曲線按鍵
    UIButton *fatCurveBt;
    //weightRainbowBarBt
    UIButton *weightRainbowBarBt;
    BOOL isweightRainbowBarBtSelected;
    
    
    //PUL value and unit
    //----------------------------------
    UILabel *pulLabel;
    UIButton *pulValueBt;
    UILabel *pulUnitLabel;
    
    //Device model and status
    //----------------------------------
    UILabel *deviceModel;
    UILabel *deviceStatus;
    
    
    //BMI
    //----------------------------------
    UILabel *bmiLabel;
    UIButton *bmiValueBt;
    
    //BODY FAT
    //----------------------------------
    UILabel *bodyFatLabel;
    UILabel *bodyFatValueLabel;
    
    
    //UITableView
    UITableView *m_tableView;
    
    
    //產生模糊畫面
    //----------------------------------
    UIView *blurView;
    
    
    
}


@end

@implementation MainOverviewViewController

#pragma mark - viewNormal function
//--------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //***********  navigationController 相關初始化設定  **********
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
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, theTitleView.frame.size.width, theTitleView.frame.size.height/3*2)];
    
    titleLabel.text = @"Overview";
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [theTitleView addSubview:titleLabel];
    
    //timeLabel
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame),titleLabel.frame.size.width*0.68, theTitleView.frame.size.height/3)];
    
    timeLabel.center = CGPointMake(theTitleView.center.x, theTitleView.frame.size.height/3*2);
    
    timeLabel.textColor = [UIColor whiteColor];
    
    timeLabel.adjustsFontSizeToFitWidth = YES;
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [theTitleView addSubview:timeLabel];
    
    self.navigationItem.titleView = theTitleView;
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    
    //******* listView & listBt & listLabel & listArrowImg *******
    //切九等份
    unitHeight = (self.view.frame.size.height - 44 - statusHeight - 49)/9;
    
    //listView
    listView = [[UIView alloc] initWithFrame:CGRectMake(0,unitHeight*8.4, self.view.frame.size.width, unitHeight*0.6)];
    
    listView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:listView];
    
    
    //listArrowImg
    listArrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(listView.frame.size.height/4, -5,listView.frame.size.height/2,listView.frame.size.height/2)];
    
    listArrowImg.center = CGPointMake(listView.center.x, listView.frame.size.height/4);
    
    listArrowImg.image = [UIImage imageNamed:@"all_icon_a_arrow_up"];
    
    [listView addSubview:listArrowImg];
    
    
    //listLabel
    listLable = [[UILabel alloc] initWithFrame:CGRectMake(0, listView.frame.size.height/2-20, SCREEN_WIDTH, SCREEN_HEIGHT*0.06)];

    listLable.text = @"YOUR BLOOD PRESSURE LISTS";
    
    listLable.textAlignment = NSTextAlignmentCenter;
    
    listLable.textColor = TEXT_COLOR;
    
    listLable.adjustsFontSizeToFitWidth = YES;
    
    //listLable.font = [UIFont boldSystemFontOfSize:listLable.frame.size.height * 0.8];
    listLable.font = [UIFont boldSystemFontOfSize:14.0];
    
    [listView addSubview:listLable];
    
    
    
    //listBt
    listBt = [[UIButton alloc]initWithFrame:listView.frame];
    
    [listBt addTarget:self action:@selector(listBtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:listBt];
    
    //listSperatorView
    listSperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(listView.frame) - 2, self.view.frame.size.width, 1.0)];
    
    listSperatorView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:listSperatorView];
    
    
    //isListAction
    isListAction = NO;
    
    
    ary_overView_subViews = [NSMutableArray new];
    
    
    
    //*************  scrollView 初始設定  ************
    overView_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMinY(listSperatorView.frame) - CGRectGetMinY(overView_scrollView.frame))];
    
    overView_scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, overView_scrollView.frame.size.height);
    
    overView_scrollView.pagingEnabled = YES;
    
    overView_scrollView.delegate = self;
    
    overView_scrollView.showsHorizontalScrollIndicator = NO;
    
    overView_scrollView.showsVerticalScrollIndicator = NO;

    
    [self.view addSubview:overView_scrollView];
    
    //bloodPressureView
    bloodPressureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, overView_scrollView.frame.size.height)];
    bloodPressureView.backgroundColor = [UIColor clearColor];
    [overView_scrollView addSubview:bloodPressureView];
    
    //weightView
    weightView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, bloodPressureView.frame.size.width, overView_scrollView.frame.size.height)];
    weightView.backgroundColor = [UIColor whiteColor];
    [overView_scrollView addSubview:weightView];
    
    //bodyTemperatureView
    bodyTemperatureView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, bloodPressureView.frame.size.width, overView_scrollView.frame.size.height)];
    bodyTemperatureView.backgroundColor = [UIColor whiteColor];
    [overView_scrollView addSubview:bodyTemperatureView];
    
    
    
    //***********  pageControl  *************
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(listSperatorView.frame) - 0.5*unitHeight, self.view.frame.size.width, 0.5*unitHeight)];
    
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_dot_a_0"]];
    
    page.currentPageIndicatorTintColor = [UIColor grayColor];
    
    page.numberOfPages = 3;
    
    page.currentPage = 0;
    
    [self.view addSubview:page];
    
    
    
    //**************  bloodPressureToolBar & bloodPressureToolBarBts  ***************
    //toolBarCancelBt
    UIBarButtonItem *toolBarCancelBt = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCancelBtAction)];
    [toolBarCancelBt setTintColor:[UIColor darkGrayColor]];
    
    //sys
    UIBarButtonItem *sysBt = [[UIBarButtonItem alloc] initWithTitle:@"SYS" style:UIBarButtonItemStylePlain target:self action:nil];
    [sysBt setTintColor:[UIColor blackColor]];

    //dia
    UIBarButtonItem *diaBt = [[UIBarButtonItem alloc] initWithTitle:@"DIA" style:UIBarButtonItemStylePlain target:self action:nil];
    [diaBt setTintColor:[UIColor blackColor]];

    //Next
    UIBarButtonItem *nextBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(bpNextTopulBtAction)];
    
    //space
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //bloodPressureToolBar
    bloodPressureToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/16)];
    
    [bloodPressureToolBar setItems:@[toolBarCancelBt,space,sysBt,space,diaBt,space,nextBt] animated:NO];

    
    
    //****************  pulToolBar & pulToolBarBts  ******************
    //back
    UIBarButtonItem *backTobpBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(pulBackTobpBtAction)];
    [backTobpBt setTintColor:[UIColor darkGrayColor]];
    
    //pul
    UIBarButtonItem *pulBt = [[UIBarButtonItem alloc] initWithTitle:@"PUL" style:UIBarButtonItemStylePlain target:self action:nil];
    [pulBt setTintColor:[UIColor blackColor]];
    
    //nextToTimeBt
    UIBarButtonItem *nextToTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(pulNextToTimeBtAction)];
    
    //pulToolbar
    pulToolBar = [[UIToolbar alloc] initWithFrame:bloodPressureToolBar.frame];
    [pulToolBar setItems:@[backTobpBt,space,pulBt,space,nextToTimeBt] animated:NO];
    
    
    
    //****************  timeToolBar & timeToolBarBts  *******************
    //timeBackToPulBt
    UIBarButtonItem *timeBackToPulBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(timeBackToPulBtAction)];
    [timeBackToPulBt setTintColor:[UIColor darkGrayColor]];
    
    
    //timeBt
    UIBarButtonItem *timeBt = [[UIBarButtonItem alloc] initWithTitle:@"TIME" style:UIBarButtonItemStylePlain target:self action:nil];
    [timeBt setTintColor:[UIColor blackColor]];
    
    
    //timeNextToDateBt
    UIBarButtonItem *timeNextToDateBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(timeNextToDateBtAction)];
    
    //timeToolBar
    timeToolBar = [[UIToolbar alloc] initWithFrame:bloodPressureToolBar.frame];
    [timeToolBar setItems:@[timeBackToPulBt,space,timeBt,space,timeNextToDateBt] animated:NO];
    
    
    
    //**********************  dateToolBar & dateToolBarBts  *********************
    //dateBackToTimeBt
    UIBarButtonItem *dateBackToTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dateBackToTimeBtAction)];
    [dateBackToTimeBt setTintColor:[UIColor darkGrayColor]];
    
    
    //dateBt
    UIBarButtonItem *dateBt = [[UIBarButtonItem alloc] initWithTitle:@"DATE" style:UIBarButtonItemStylePlain target:self action:nil];
    [dateBt setTintColor:[UIColor blackColor]];
    
    //toolBarSaveBt
    UIBarButtonItem *toolBarSaveBt = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarSaveBtAction)];
    
    //dateToolBar
    dateToolBar = [[UIToolbar alloc] initWithFrame:bloodPressureToolBar.frame];
    [dateToolBar setItems:@[dateBackToTimeBt,space,dateBt,space,toolBarSaveBt] animated:NO];
    
    
    //初始化所有PickerView
    [self allPickerViewInit];
    
    
    //callPickerView
    callPickerView = [[UITextField alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width/3, self.view.frame.size.width/3)];
    callPickerView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/5);
    callPickerView.backgroundColor = [UIColor clearColor];
    callPickerView.tintColor = [UIColor clearColor];
    [callPickerView addTarget:self action:@selector(callPickerViewAction) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:callPickerView];
    
    callPickerView.inputView = bpPickerView.m_pickerView;
    callPickerView.inputAccessoryView = bloodPressureToolBar;
    
    
    
    //生成大小圓
    [self createBloodPressureCircle];
    [self createWeightCircle];
    [self createBodyTemperatureCircle];

    
    //生成curveBts
    [self createSysDiaAndPulCurveBts];
    [self createWeiBmiFatCurveBts];
    
    
    //生成 PUL Label
    [self createPULLabel];
    [self createDeviceModelAndStatus];
    
    //生成 BMI Lable
    [self createBMILabel];
    [self createBodyFatLabel];
    
    
    
    //m_tableView
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, unitHeight, self.view.frame.size.width, self.view.frame.size.height - unitHeight)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    //m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.hidden = YES;
    [self.view addSubview:m_tableView];
    
    
    
    //生成一個模糊畫面
    blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blurView.backgroundColor = [UIColor darkGrayColor];
    blurView.alpha = 0.3;
    [self.tabBarController.view addSubview:blurView];
    blurView.hidden = YES;
    

}


-(void)viewWillAppear:(BOOL)animated {
    
    //getTimer 計時開始(navigationBar 顯示時間用)
    getDateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(getDateAndTime) userInfo:nil repeats:YES];
    
}


-(void)viewDidDisappear:(BOOL)animated {
    
    //getDateTimer  停止
    [getDateTimer invalidate];
    getDateTimer = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 生成 bloodPressure 大小圓
//-------------------------------------
-(void)createBloodPressureCircle {
    
    //bloodPressure 藍色大圓
    bloodPressureCircleView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.88, self.view.frame.size.width/1.88)];
    bloodPressureCircleView.center = CGPointMake(bloodPressureView.frame.size.width/2, overView_scrollView.frame.size.height/3.88);
    [bloodPressureView addSubview:bloodPressureCircleView];
    
    bloodPressureCircleView.circleViewTitleString = @"SYS/DIA";
    bloodPressureCircleView.circleViewValueString = @"130/75";
    bloodPressureCircleView.circleViewUnitString = @"mmHg";
    [bloodPressureCircleView setString];
    
    //bloodPressure 藍色小圓
    bloodPressureCircleSmallView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/8, self.view.frame.size.width/8)];
    bloodPressureCircleSmallView.center = CGPointMake(CGRectGetMidX(bloodPressureCircleView.frame), CGRectGetMinY(bloodPressureCircleView.frame)+bloodPressureCircleView.layer.borderWidth);
    bloodPressureCircleSmallView.layer.borderWidth = 2.0;
    bloodPressureCircleSmallView.backgroundColor = [UIColor whiteColor];
    bloodPressureCircleSmallView.circleImgView.image = [UIImage imageNamed:@"overview_icon_a_bpm"];
    [bloodPressureView addSubview:bloodPressureCircleSmallView];
}

#pragma mark - 生成 weight 大小圓
//---------------------------------
-(void)createWeightCircle {
    
    //weight 藍色大圓
    weightCircleView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.88, self.view.frame.size.width/1.88)];
    weightCircleView.center = CGPointMake(weightView.frame.size.width/2, overView_scrollView.frame.size.height/3.88);
    [weightView addSubview:weightCircleView];
    
    weightCircleView.circleViewTitleString = @"Weight";
    weightCircleView.circleViewValueString = @"65";
    weightCircleView.circleViewUnitString = @"kg";
    [weightCircleView setString];
    
    
    
    //weight 藍色小圓
    weightCircleSmallView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/8, self.view.frame.size.width/8)];
    weightCircleSmallView.center = CGPointMake(CGRectGetMidX(bloodPressureCircleView.frame), CGRectGetMinY(bloodPressureCircleView.frame)+weightCircleView.layer.borderWidth);
    weightCircleSmallView.layer.borderWidth = 2.0;
    weightCircleSmallView.backgroundColor = [UIColor whiteColor];
    weightCircleSmallView.circleImgView.image = [UIImage imageNamed:@"overview_icon_a_ws_b"];
    [weightView addSubview:weightCircleSmallView];
    
    
}

#pragma mark - 生成 bodyTemperature 大小圓
//--------------------------------------------
-(void)createBodyTemperatureCircle {
    
    //BodyTemperature藍色大圓
    bodyTemperatureCircleView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.88, self.view.frame.size.width/1.88)];
    bodyTemperatureCircleView.center = CGPointMake(bodyTemperatureView.frame.size.width/2, overView_scrollView.frame.size.height/3.88);
    [bodyTemperatureView addSubview:bodyTemperatureCircleView];
    
    bodyTemperatureCircleView.circleViewTitleString = @"Body Temp.";
    bodyTemperatureCircleView.circleViewValueString = @"36.2℃";
    bodyTemperatureCircleView.circleViewUnitString = @"";
    [bodyTemperatureCircleView setString];
    
    
    //BodyTemperature藍色小圓
    bodyTemperatureCircleSmallView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/8, self.view.frame.size.width/8)];
    bodyTemperatureCircleSmallView.center = CGPointMake(CGRectGetMidX(bloodPressureCircleView.frame), CGRectGetMinY(bloodPressureCircleView.frame)+bodyTemperatureCircleView.layer.borderWidth);
    bodyTemperatureCircleSmallView.layer.borderWidth = 2.0;
    bodyTemperatureCircleSmallView.backgroundColor = [UIColor whiteColor];
    bodyTemperatureCircleSmallView.circleImgView.image = [UIImage imageNamed:@"overview_icon_a_ncfr_b"];
    [bodyTemperatureView addSubview:bodyTemperatureCircleSmallView];
    
    
}

#pragma  mark - bloodPressure - SYS/DIA curveBt and PULcurveBt
//--------------------------------------------------------------
-(void)createSysDiaAndPulCurveBts {
    
    CGFloat btWidth = self.view.frame.size.width/4.5;
    CGFloat btHeight = self.view.frame.size.width/12;
    
    //SYS/DIA curveBt
    sysAndDiaCurveBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btWidth, btHeight)];
    sysAndDiaCurveBt.center = CGPointMake(bloodPressureView.frame.size.width/2 - sysAndDiaCurveBt.frame.size.width/1.8, bloodPressureView.frame.size.height/1.8);
    [sysAndDiaCurveBt setTitle:@"SYS/DIA" forState:UIControlStateNormal];
    [sysAndDiaCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sysAndDiaCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [sysAndDiaCurveBt addTarget:self action:@selector(sysDiaAndPulCurveBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [bloodPressureView addSubview:sysAndDiaCurveBt];
    
    //PULcurveBt
    pulCurveBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,btWidth, btHeight)];
    pulCurveBt.center = CGPointMake(bloodPressureView.frame.size.width/2 + pulCurveBt.frame.size.width/1.8,sysAndDiaCurveBt.center.y);
    [pulCurveBt setTitle:@"PUL" forState:UIControlStateNormal];
    [pulCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    [pulCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [pulCurveBt addTarget:self action:@selector(sysDiaAndPulCurveBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [bloodPressureView addSubview:pulCurveBt];
    
    
    //bpRainbowBarBt
    bpRainbowBarBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btHeight, btHeight)];
    bpRainbowBarBt.center = CGPointMake(bloodPressureView.frame.size.width - bpRainbowBarBt.frame.size.width, pulCurveBt.center.y);
    [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    [bpRainbowBarBt addTarget:self action:@selector(bpRainbowBarBtAction:) forControlEvents:UIControlEventTouchUpInside];
    isBPRainbowBarBtSelected = NO;
    [bloodPressureView addSubview:bpRainbowBarBt];
    
}

#pragma mark - sysDia and pul CurveBt Action
-(void)sysDiaAndPulCurveBtAction:(UIButton *)sender {
    
    if (sender == sysAndDiaCurveBt) {
        
        [sysAndDiaCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sysAndDiaCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [pulCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [pulCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
    }
    else if (sender == pulCurveBt) {
        
        [sysAndDiaCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [sysAndDiaCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [pulCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [pulCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark - bloodPressure RainbowBarBt Action
-(void)bpRainbowBarBtAction:(UIButton *)sender {
    
    isBPRainbowBarBtSelected = isBPRainbowBarBtSelected == YES ? NO : YES;
    
    if (isBPRainbowBarBtSelected) {
        
        [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_1"] forState:UIControlStateNormal];
    }
    else {
        
        
        [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    }
    
}


#pragma mark - WEI BMI FAT CurveBT
//---------------------------------
-(void)createWeiBmiFatCurveBts {
    
    CGFloat btWidth = self.view.frame.size.width/4.5;
    CGFloat btHeight = self.view.frame.size.width/12;
    
    //BMI CurveBt
    bmiCurveBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btWidth, btHeight)];
    bmiCurveBt.center = CGPointMake(weightView.frame.size.width/2, weightView.frame.size.height/1.8);
    [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [bmiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    [bmiCurveBt setTitle:@"BMI" forState:UIControlStateNormal];
    [bmiCurveBt addTarget:self action:@selector(weiBmiFatBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [weightView addSubview:bmiCurveBt];
    
    
    //WEI CurveBt
    weiCurveBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btWidth,btHeight)];
    weiCurveBt.center = CGPointMake(bmiCurveBt.center.x - 1.1*btWidth, bmiCurveBt.center.y);
    [weiCurveBt setTitle:@"WEI" forState:UIControlStateNormal];
    [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [weiCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weiCurveBt addTarget:self action:@selector(weiBmiFatBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [weightView addSubview:weiCurveBt];
    
    //FAT CurveBt
    fatCurveBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btWidth, btHeight)];
    fatCurveBt.center = CGPointMake(bmiCurveBt.center.x + 1.1*btWidth, bmiCurveBt.center.y);
    [fatCurveBt setTitle:@"FAT" forState:UIControlStateNormal];
    [fatCurveBt setTitleColor: STANDER_COLOR forState:UIControlStateNormal];
    [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [fatCurveBt addTarget:self action:@selector(weiBmiFatBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [weightView addSubview:fatCurveBt];
    
    
    //weight rainbowBarBt
    weightRainbowBarBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btHeight, btHeight)];
    weightRainbowBarBt.center = CGPointMake(weightView.frame.size.width - weightRainbowBarBt.frame.size.width, fatCurveBt.center.y);
    [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    [weightRainbowBarBt addTarget:self action:@selector(weightRainbowBarBtAction:) forControlEvents:UIControlEventTouchUpInside];
    isweightRainbowBarBtSelected = NO;
    [weightView addSubview:weightRainbowBarBt];

    
}

#pragma WEI BMI FAT curveBt Action
-(void)weiBmiFatBtAction:(UIButton *)sender {
    
    if (sender == weiCurveBt) {
        
        [weiCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor: STANDER_COLOR forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
    }
    else if (sender == bmiCurveBt) {
        
        [weiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
    }
    else if (sender == fatCurveBt) {
        
        [weiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
    }
    
    
}

#pragma mark - weight RainbowBarBt Action
-(void)weightRainbowBarBtAction:(UIButton *)sender {
    
    isweightRainbowBarBtSelected = isweightRainbowBarBtSelected == YES ? NO : YES;
    
    if (isweightRainbowBarBtSelected) {
        
        [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_1"] forState:UIControlStateNormal];
    }
    else {
        
        [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    }
    
}


#pragma mark - PUL Label
//---------------------------------------------------
-(void)createPULLabel {
    
    CGFloat labelWidth = self.view.frame.size.width/8;
    CGFloat labelHeight = self.view.frame.size.width/16;
    
    //pulLabel
    pulLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
    pulLabel.center = CGPointMake(bloodPressureView.frame.size.width/6, bloodPressureView.frame.size.height/2.8);
    pulLabel.textAlignment = NSTextAlignmentCenter;
    pulLabel.text = @"PUL";
    [bloodPressureView addSubview:pulLabel];
    
    //pulValueBt
    pulValueBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(pulLabel.frame), CGRectGetMaxY(pulLabel.frame), labelWidth*2, labelWidth)];
    pulValueBt.center = CGPointMake(pulLabel.center.x, pulLabel.center.y+pulLabel.frame.size.height/2+pulValueBt.frame.size.height/2);
    [pulValueBt setTitle:@"85" forState:UIControlStateNormal];
    [pulValueBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pulValueBt.titleLabel.font = [UIFont systemFontOfSize:pulValueBt.frame.size.height*0.88];
    pulValueBt.titleLabel.adjustsFontSizeToFitWidth = YES;
    [bloodPressureView addSubview:pulValueBt];
    
    //pulUnitLabel
    pulUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(pulLabel.frame), CGRectGetMaxY(pulValueBt.frame), labelWidth, labelHeight)];
    pulUnitLabel.textAlignment = NSTextAlignmentCenter;
    pulUnitLabel.text = @"bpm";
    [bloodPressureView addSubview:pulUnitLabel];
}


#pragma mark - Device Model and Device Status
-(void)createDeviceModelAndStatus {
    
    CGFloat labelWidth = self.view.frame.size.width/8;
    CGFloat labelHeight = self.view.frame.size.height/16;
    CGFloat labelLongWidth = self.view.frame.size.width/4;
    
    //deviceModel
    deviceModel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
    deviceModel.center = CGPointMake(bloodPressureView.frame.size.width/7*6, bloodPressureView.frame.size.height/2.8);
    deviceModel.textAlignment = NSTextAlignmentCenter;
    deviceModel.text = @"AFIB";
    [bloodPressureView addSubview:deviceModel];
    
    //deviceStatus
    deviceStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelLongWidth, labelHeight)];
    deviceStatus.center = CGPointMake(deviceModel.center.x, pulValueBt.center.y);
    deviceStatus.textAlignment = NSTextAlignmentCenter;
    deviceStatus.text = @"Not Detected ";
    deviceStatus.adjustsFontSizeToFitWidth = YES;
    [bloodPressureView addSubview:deviceStatus];
}

#pragma mark - BMI Label
-(void)createBMILabel {
    
    CGFloat labelWidth = self.view.frame.size.width/8;
    CGFloat labelHeight = self.view.frame.size.height/16;
    
    //BMI Label
    bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
    bmiLabel.center = CGPointMake(weightView.frame.size.width/6, weightView.frame.size.height/2.8);
    bmiLabel.text = @"BMI";
    bmiLabel.textAlignment = NSTextAlignmentCenter;
    [weightView addSubview:bmiLabel];
    
    //bmiValueBt
    bmiValueBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(bmiLabel.frame), CGRectGetMaxY(bmiLabel.frame), labelWidth*2, labelWidth)];
    bmiValueBt.center = CGPointMake(bmiLabel.center.x, bmiLabel.center.y+bmiLabel.frame.size.height/2+bmiValueBt.frame.size.height/2);
    [bmiValueBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bmiValueBt setTitle:@"25" forState:UIControlStateNormal];
    bmiValueBt.titleLabel.font = [UIFont systemFontOfSize:bmiValueBt.frame.size.height*0.88];
    bmiValueBt.titleLabel.adjustsFontSizeToFitWidth = YES;
    [weightView addSubview:bmiValueBt];
    
}


#pragma mark - Body Fat Label
-(void)createBodyFatLabel {
    
    CGFloat labelWidth = self.view.frame.size.width/8;
    CGFloat labelHeight = self.view.frame.size.height/16;

    //bodyFatLabel
    bodyFatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth*2, labelHeight)];
    bodyFatLabel.center =  CGPointMake(weightView.frame.size.width/7*6, weightView.frame.size.height/2.8);
    bodyFatLabel.textAlignment = NSTextAlignmentCenter;
    bodyFatLabel.text = @"Body Fat";
    [weightView addSubview:bodyFatLabel];
    
    //bodyFatValueLabel
    bodyFatValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth*2, labelWidth)];
    bodyFatValueLabel.center = CGPointMake(bodyFatLabel.center.x, bodyFatLabel.center.y+bodyFatLabel.frame.size.height/2+bodyFatValueLabel.frame.size.height/2);
    bodyFatValueLabel.textAlignment = NSTextAlignmentCenter;
    bodyFatValueLabel.text = @"25%";
    bodyFatValueLabel.font = [UIFont systemFontOfSize:bodyFatValueLabel.frame.size.height*0.88];
    [weightView addSubview:bodyFatValueLabel];
    
}


#pragma mark - 所有 pickerView 初始化
//---------------------------------------------------
-(void)allPickerViewInit {
    
    CGFloat pickerViewWidth = self.view.frame.size.width;
    CGFloat pickerViewHeight = self.view.frame.size.height/3;
    
    //BloodPressure
    bpPickerView = [[BloodPressurePickerView alloc] initWithbloodPressurePickerViewFrame:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //Pul
    pulPickerView = [[PULPickerView alloc] initWithpulPIckerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //Time
    timePickerView = [[TimePickerView alloc] initWithTimePickerViewFrame:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //Date
    datePickerView = [[DatePickerView alloc] initWithDatePickerViewFrame:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
}


#pragma mark - profileBtAction (導覽列左邊按鍵方法)
//----------------------------------------------
-(void)profileBtAction {
    
    [self SidebarBtn];
}


#pragma mark - listBtAction (顯示 tableView)
//------------------------------------------
-(void)listBtAction:(UIButton *)sender {
    
    isListAction = isListAction == YES ? NO : YES;
    
    if (isListAction == YES) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        self.tabBarController.tabBar.hidden = YES;
        
        listView.frame = CGRectMake(0, 0, listView.frame.size.width, listView.frame.size.height);
        
        listBt.frame = listView.frame;
        
        listArrowImg.image = [UIImage imageNamed:@"all_icon_a_arrow_down"];
        
        listSperatorView.hidden = YES;
        
        m_tableView.hidden = NO;
        
        [self.view bringSubviewToFront:listView];
        [self.view bringSubviewToFront:listBt];
        
        overView_scrollView.hidden = YES;
        
        [m_tableView reloadData];
    }
    else {
        
        listView.frame = CGRectMake(0,unitHeight*8.4, listView.frame.size.width, listView.frame.size.height);
        
        listBt.frame = listView.frame;
        
        listArrowImg.image = [UIImage imageNamed:@"all_icon_a_arrow_up"];
        
        listSperatorView.hidden = NO;
        
        m_tableView.hidden = YES;
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        self.tabBarController.tabBar.hidden = NO;
        
        overView_scrollView.hidden = NO;
        
    }
    
}


#pragma mark -  取得裝置目前時間
//---------------------------
-(void)getDateAndTime {
    
    NSDate *date = [NSDate date];
    NSTimeInterval now = [date timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc]initWithTimeIntervalSinceNow:now];
    
    //年月日
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:currentDate];
    
    //時分
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [timeFormatter stringFromDate:currentDate];
    
    //串接Date + at
    NSString *strAt = [dateStr stringByAppendingString:@" at "];
    
    //串接Date at + time
    NSString *finalStr = [strAt stringByAppendingString:timeStr];
    
    timeLabel.text = finalStr;
}


#pragma mark - scrollView Delegate
//--------------------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == overView_scrollView) {
        
        int currentPage = (int)(round(scrollView.contentOffset.x / scrollView.frame.size.width)) + 1;
        
        switch (currentPage) {
            case 1:
                listLable.text = @"YOUR BLOOD PRESSURE LISTS";
                page.currentPage = 0;
                break;
            case 2:
                listLable.text = @"YOUR WEIGHT LISTS";
                page.currentPage = 1;
                break;
            case 3:
                listLable.text = @"YOUR BODY TEMPERATURE LISTS";
                page.currentPage = 2;
                break;
            default:
                break;
        }
        

        
    }
    
}


//pickerView自定方法
-(void)showSelectedRowInPickerView:(UIPickerView *)pickerView atRow:(NSInteger)row inComponet:(NSInteger)component{
    
    [pickerView selectRow:row inComponent:component animated:YES];
}

#pragma mark - toolBarBtAction
//---------------------------------------------------------------
//bloodPressure
-(void)toolBarCancelBtAction {
    
    blurView.hidden = YES;
    [callPickerView resignFirstResponder];
    callPickerView.inputView = bpPickerView.m_pickerView;
    callPickerView.inputAccessoryView = bloodPressureToolBar;

}

-(void)bpNextTopulBtAction {

    [callPickerView resignFirstResponder];
    callPickerView.inputView = pulPickerView.m_pickerView;
    callPickerView.inputAccessoryView = pulToolBar;
    [callPickerView becomeFirstResponder];
}


//pul
-(void)pulBackTobpBtAction {
    
    [callPickerView resignFirstResponder];
    callPickerView.inputView = bpPickerView.m_pickerView;
    callPickerView.inputAccessoryView = bloodPressureToolBar;
    [callPickerView becomeFirstResponder];
}


-(void)pulNextToTimeBtAction {
    
    [callPickerView resignFirstResponder];
    callPickerView.inputView = timePickerView.m_pickerView;
    callPickerView.inputAccessoryView = timeToolBar;
    [callPickerView becomeFirstResponder];
}


//time
-(void)timeBackToPulBtAction {
    
    [callPickerView resignFirstResponder];
    callPickerView.inputView = pulPickerView.m_pickerView;
    callPickerView.inputAccessoryView = pulToolBar;
    [callPickerView becomeFirstResponder];
}

-(void)timeNextToDateBtAction {
    
    [callPickerView resignFirstResponder];
    callPickerView.inputView = datePickerView.m_pickerView;
    callPickerView.inputAccessoryView = dateToolBar;
    [callPickerView becomeFirstResponder];
}

//date
-(void)dateBackToTimeBtAction {
    
    [callPickerView resignFirstResponder];
    callPickerView.inputView = timePickerView.m_pickerView;
    callPickerView.inputAccessoryView = timeToolBar;
    [callPickerView becomeFirstResponder];
    
}

-(void)toolBarSaveBtAction {
    
    [callPickerView resignFirstResponder];
    
    blurView.hidden = YES;
    
}


-(void)callPickerViewAction {
    
    blurView.hidden = NO;
}



#pragma mark - TableView DataSource & Delegate
//--------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cell_ID;
    
    UITableViewCell *cell;
    
    if (page.currentPage == 0) {
        
        //BLOOD Pressure CELL
        //--------------------------------------
        cell_ID = @"bp_cellID";
        
         OverBPTableViewCell*bpCell = (OverBPTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_ID];
        
        cell = bpCell;
        
        if(cell == nil) {
            
            cell = [[OverBPTableViewCell alloc] initBPTableiewCellWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/6)];
        }

    }
    else if (page.currentPage == 1) {
        
        //WEIGHT CELL
        //--------------------------------------
        cell_ID = @"weight_cellID";
        
        OverWeightTableViewCell *weightCell = (OverWeightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_ID];
        
        cell = weightCell;
        
        if (cell == nil) {
            
            cell = [[OverWeightTableViewCell alloc] initWithWeightCellFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/6)];
            
        }

        
    }
    else if (page.currentPage == 2) {
        
        //BODY TEMP CELL
        //--------------------------------------
        cell_ID = @"temp_cellID";
        
         OverTempTableViewCell *tempCell = (OverTempTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_ID];
        
        cell = tempCell;
        
        if (cell == nil) {
            
            cell = [[OverTempTableViewCell alloc] initTempTableViewCellWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/6)];
        }

    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height/6;
}

@end

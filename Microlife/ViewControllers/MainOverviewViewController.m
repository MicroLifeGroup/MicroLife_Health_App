

#import "MainOverviewViewController.h"
#import "HealthEducationViewController.h"
#import "NotificationViewController.h"
#import "AboutViewController.h"
#import "LogoutViewController.h"

//pickerViews
//-------------------------------
//血壓
#import "BloodPressurePickerView.h"
#import "PULPickerView.h"
#import "TimePickerView.h"
#import "DatePickerView.h"

//體重
#import "WEIPickerView.h"
#import "BMIPickerView.h"
#import "FATPickerView.h"
//#import "SkeletonPickerView.h"
//#import "MusclePickerView.h"
//#import "BMRPickerView.h"
//#import "OrganFatPickerView.h"

//溫度
#import "OverViewTempAddView.h"
#import "BodyTempPickerView.h"
#import "RoomTempPickerView.h"


//circleView
//-------------------------------
#import "OverViewCircleView.h"


//TableViewCells
//--------------------------------
#import "OverBPTableViewCell.h"
#import "OverWeightTableViewCell.h"
#import "OverTempTableViewCell.h"

#import "GraphView.h"
#import "RainbowBarView.h"


//圖表
#import "GraphView.h"

//藍芽
#import "BLEDataHandler.h"

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
    UITextField *callBPPickerView;
    UITextField *callWEIPickerView;
    UITextField *callTempPickerView;
    
    //血壓
    //bloodPressure
    BloodPressurePickerView *bpPickerView;
    UIToolbar *bloodPressureToolBar;
    
    //pul
    PULPickerView *pulPickerView;
    UIToolbar *pulToolBar;
    
    
    //體重
    //wei
    WEIPickerView *weiPickerView;
    UIToolbar *weiToolBar;
    
    //bmi
    BMIPickerView *bmiPickerView;
    UIToolbar *bmiToolBar;
    
    //fat
    FATPickerView *fatPickerView;
    UIToolbar *fatToolBar;
    
    //skeleton
    //SkeletonPickerView *skeletonPickerView;
    //UIToolbar *skeletonToolBar;
    
    //muscle
    //MusclePickerView *musclePickerView;
    //UIToolbar *muscleToolBar;
    
    //BMR
    //BMRPickerView *bmrPickerView;
    UIToolbar *bmrToolBar;
    
    //OrganFat
    //OrganFatPickerView *organFatPickerView;
    //UIToolbar *organFatToolBar;
    
    
    //溫度
    //bodyTemp
    BodyTempPickerView *bodyTempPickerView;
    UIToolbar *bodyTempToolBar;
    
    //roomTemp
    UIToolbar *roomTempToolBar;
    RoomTempPickerView *roomTempPickerView;
    

    //time
    TimePickerView *timePickerView;

    UIToolbar *timeToolBar;
    UIToolbar *weightTimeToolBar;
    UIToolbar *tempTimeToolBar;
    
    //date
    DatePickerView *datePickerView;

    
    UIToolbar *dateToolBar;
    UIToolbar *weightDateToolBar;
    UIToolbar *tempDateToolBar;
    
    
    
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
    
    
    //RainbowBarView
    //----------------------------------
    RainbowBarView *rainbowViewForBp;
    RainbowBarView *rainbowViewForBMI;
    
    //OverviewAddEventView
    //----------------------------------
    OverViewTempAddView *addTempView;
    
    
    //圖表
    UIView *BPChartArea;
    UIView *tempChartArea;
    UIView *weightChartArea;
    
    GraphView *BPChartView;
    GraphView *weightChartView;
    GraphView *tempChartView;
    
    //0=歐規 1=USA 2=非歐,非USA
    int measureSpec;
    float BMIValue;
}

#define IMAGE_NORMAL_BP [UIImage imageNamed:@"overview_icon_a_bpm"]
#define IMAGE_AFIB [UIImage imageNamed:@"overview_icon_a_afib"]
#define IMAGE_HIGH_BP [UIImage imageNamed:@"overview_icon_a_bpm_r"]
#define IMAGE_PAD [UIImage imageNamed:@"overview_icon_a_pad"]

#define IMAGE_NORMAL_TEMP [UIImage imageNamed:@"overview_icon_a_ncfr_b"]
#define IMAGE_FEVER [UIImage imageNamed:@"overview_icon_a_ncfr_r"]


#define IMAGE_NORMAL_WEIGHT [UIImage imageNamed:@"overview_icon_a_ws_r"]
#define IMAGE_OVERWEIGHT [UIImage imageNamed:@"overview_icon_a_ws_r"]


@end

@implementation MainOverviewViewController

#pragma mark - viewNormal function
//--------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tabBarController.tabBar.tintColor = STANDER_COLOR;
    
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
    //********************************
    bloodPressureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, overView_scrollView.frame.size.height)];
    bloodPressureView.backgroundColor = [UIColor clearColor];
    [overView_scrollView addSubview:bloodPressureView];
    
    
    //weightView
    //********************************
    weightView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, bloodPressureView.frame.size.width, overView_scrollView.frame.size.height)];
    weightView.backgroundColor = [UIColor whiteColor];
    [overView_scrollView addSubview:weightView];
    
    //bodyTemperatureView
    //********************************
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
    

    
    //初始化所有 ToolBars & BarButtonItems
    [self createAllToolBarsAndBarButtonItems];
    
    //初始化所有PickerView
    [self allPickerViewInit];
    
    
    
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
    
    
    //初始化 所有的callPickerViews
    [self createCallPickerViews];
    
    
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
    
    
    //tempAdd Event View
    addTempView = [[OverViewTempAddView alloc] initWithTempAddViewFrame:CGRectMake(0, 0, bodyTemperatureView.frame.size.width, bodyTemperatureView.frame.size.height)];
    addTempView.hidden = NO;
    addTempView.m_superVC = self;
    [bodyTemperatureView addSubview:addTempView];
    
    
#warning hidden
    addTempView.hidden = YES;
    
    //
    BLEDataHandler *handler = [[BLEDataHandler alloc] init];
    
    [handler protocolStart];
    
    //生成圖表
    [self initChart];
    
    [self addObserverForBLEHandler];
    
    //[self didReceiveBPMMeasureData];
    
}

-(void)initParameter{
    
    measureSpec = [LocalData sharedInstance].measureSpec;
    BMIValue = 0;
}

-(void)addObserverForBLEHandler{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveBPMMeasureData) name:@"receiveBPMData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveWeightMeasureData) name:@"receiveWeightData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTempMeasureData) name:@"receiveTempData" object:nil];
    
}

-(void)didReceiveBPMMeasureData{
    
    int age = [LocalData sharedInstance].UserAge;
    int PULUnit = [LocalData sharedInstance].PULUnit;
    
    NSDictionary *latestBP = [[LocalData sharedInstance] getLatestMeasureValue];
    
    int SYS = [[latestBP objectForKey:@"SYS"] intValue];
    int DIA = [[latestBP objectForKey:@"DIA"] intValue];
    BOOL MAM = [[latestBP objectForKey:@"MAM"] boolValue];
    BOOL PAD = 0;
    BOOL AFIB =[[latestBP objectForKey:@"Arr"] boolValue];
    int PUL = [[latestBP objectForKey:@"PUL"] intValue];
    
    
    weightCircleSmallView.alertRedImage.hidden = NO;
    bodyTemperatureCircleSmallView.alertRedImage.hidden = NO;
    bloodPressureCircleSmallView.alertRedImage.hidden = YES;
    
    UIImage *circleImg;
    UIColor *circleColor = STANDER_COLOR;
    
    
    bloodPressureCircleView.sys = SYS;
    bloodPressureCircleView.dia = DIA;
    
    if (SYS > 130 || DIA > 80) {
        //血壓異常
        circleColor = CIRCEL_RED;
        circleImg = IMAGE_HIGH_BP;
        
        if (age > 65 || age == -1) {
            bloodPressureCircleSmallView.alertRedImage.hidden = NO;
        }else{
            bloodPressureCircleSmallView.alertRedImage.hidden = YES;
        }
        
    }else{
        circleColor = STANDER_COLOR;
        circleImg = IMAGE_NORMAL_BP;
    }
    
    [pulValueBt setTitle:[NSString stringWithFormat:@"%d",PUL] forState:UIControlStateNormal];
    
    if (PULUnit == 0) {
        pulUnitLabel.text = @"bpm";
    }else{
        pulUnitLabel.text = @"bpm";
    }
    
    [bloodPressureCircleView setString];
    
    if (MAM) {
        
        if (PAD) {
            deviceStatus.textColor = CIRCEL_RED;
            deviceStatus.text = @"Detected";
            circleImg = IMAGE_PAD;
            
        }else{
            deviceStatus.textColor = TEXT_COLOR;
            deviceStatus.text = @"Not Detected";
        }
        
        if(AFIB){
            deviceStatus.textColor = CIRCEL_RED;
            deviceStatus.text = @"Detected";
            circleImg = IMAGE_AFIB;
            
            if (age > 65 || age == -1) {
                bloodPressureCircleSmallView.alertRedImage.hidden = NO;
            }else{
                bloodPressureCircleSmallView.alertRedImage.hidden = YES;
            }
            
        }else{
            deviceStatus.textColor = TEXT_COLOR;
            deviceStatus.text = @"Not Detected";
        }
        
    }else{
        deviceStatus.textColor = TEXT_COLOR;
        deviceStatus.text = @"Off";
    }
    
    bloodPressureCircleView.layer.borderColor = circleColor.CGColor;
    bloodPressureCircleSmallView.circleImgView.image = circleImg;
    bloodPressureCircleSmallView.layer.borderColor = circleColor.CGColor;
    
    [self createChartWithType:0];
}


-(void)didReceiveWeightMeasureData{
    
    NSDictionary *latestWeight = [[LocalData sharedInstance] getLatestMeasureValue];
    
    UIImage *circleImage = IMAGE_NORMAL_WEIGHT;
    UIColor *circleColor = STANDER_COLOR;
    weightCircleSmallView.alertRedImage.hidden = YES;
    
    float weight = [[latestWeight objectForKey:@"weight"] floatValue];
    BMIValue = [[latestWeight objectForKey:@"BMI"] floatValue];
    float bodyFat = [[latestWeight objectForKey:@"bodyFat"] floatValue];
    
    int userArea = [LocalData sharedInstance].userArea;
    
    weightCircleView.weight = weight;
    //BMI
    //亞洲區：23 =0
    //非亞洲區：25 =1

    //FAT
    //男性：24%
    //女性：31%
    
    if (userArea == 0) {
        if (BMIValue > 23) {
            
            circleImage = IMAGE_OVERWEIGHT;
            circleColor = CIRCEL_RED;
            weightCircleSmallView.alertRedImage.hidden = NO;
        }
    }else{
        if (BMIValue > 25) {
            circleImage = IMAGE_OVERWEIGHT;
            circleColor = CIRCEL_RED;
            weightCircleSmallView.alertRedImage.hidden = NO;
        }
    }
    
    weightCircleSmallView.circleImgView.image = circleImage;
    
    
    weightCircleView.layer.borderColor = circleColor.CGColor;
    weightCircleSmallView.layer.borderColor = circleColor.CGColor;
    bodyFatValueLabel.text = [NSString stringWithFormat:@"%.0f%%",bodyFat];
    [bmiValueBt setTitle:[NSString stringWithFormat:@"%.0f",BMIValue] forState:UIControlStateNormal];
    [weightCircleView setString];
    
    [rainbowViewForBMI checkBMIValue:BMIValue];
    
    [self createChartWithType:2];
}

-(void)didReceiveTempMeasureData{
    
    NSDictionary *latestTemp = [[LocalData sharedInstance] getLatestMeasureValue];
    
    float bodyTemp = [[latestTemp objectForKey:@"bodyTemp"] floatValue];
    //float roomTemp = [[latestTemp objectForKey:@"roomTemp"] floatValue];
    
    NSLog(@"bodyTemp ===== %f",bodyTemp);
    
    UIImage *circleImage = IMAGE_NORMAL_TEMP;
    UIColor *circleColor = STANDER_COLOR;
    
    bodyTemperatureCircleView.temp = bodyTemp;
    
    bodyTemperatureCircleSmallView.alertRedImage.hidden = YES;
    
    if (bodyTemp >= 37.5) {
        
        circleColor = CIRCEL_RED;
        circleImage = IMAGE_FEVER;
        bodyTemperatureCircleSmallView.alertRedImage.hidden = NO;
        
    }
    
    bodyTemperatureCircleSmallView.circleImgView.image = circleImage;
    
    bodyTemperatureCircleView.layer.borderColor = circleColor.CGColor;
    bodyTemperatureCircleSmallView.layer.borderColor = circleColor.CGColor;
    [bodyTemperatureCircleView setString];
    
    [self createChartWithType:5];
}

-(void)initChart{
    
    //Chart View
    BPChartArea = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bpRainbowBarBt.frame) + bpRainbowBarBt.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    
    BPChartView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, BPChartArea.frame.size.width, BPChartArea.frame.size.height-page.frame.size.height) withChartType:0 withDataCount:14 withDataRange:14];
    
    [bloodPressureView addSubview:BPChartArea];
    [BPChartArea addSubview:BPChartView];
    
    weightChartArea = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bpRainbowBarBt.frame) + bpRainbowBarBt.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    
    weightChartView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, weightChartArea.frame.size.width, weightChartArea.frame.size.height-page.frame.size.height) withChartType:2 withDataCount:14 withDataRange:14];
    
    [weightView addSubview:weightChartArea];
    [weightChartArea addSubview:weightChartView];
    
    
    tempChartArea = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bpRainbowBarBt.frame) + bpRainbowBarBt.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    
    tempChartView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, tempChartArea.frame.size.width, tempChartArea.frame.size.height-page.frame.size.height) withChartType:5 withDataCount:14 withDataRange:14];
    [bodyTemperatureView addSubview:tempChartArea];
    [tempChartArea addSubview:tempChartView];
}

-(void)createChartWithType:(int)type{
    
    
    GraphView *chartView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, BPChartArea.frame.size.width, BPChartArea.frame.size.height-page.frame.size.height) withChartType:type withDataCount:14 withDataRange:14];
    
    if(type == 0 || type ==1){
        
        [BPChartView removeFromSuperview];
        BPChartView = chartView;
        [BPChartArea addSubview:BPChartView];
    }
    
    if(type == 2 || type == 3 || type == 4){
        
        [weightChartView removeFromSuperview];
        weightChartView = chartView;
        [weightChartArea addSubview:weightChartView];
    }
    
    if (type == 5) {
        
        [tempChartView removeFromSuperview];
        tempChartView = chartView;
        [tempChartArea addSubview:tempChartView];
    }

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


#pragma mark - create AllToolBars & BarButtonItems
-(void)createAllToolBarsAndBarButtonItems {
    
    CGFloat toolBarWidth = self.view.frame.size.width;
    CGFloat toolBarHeight = self.view.frame.size.height/16;
    
    //**************  bloodPressureToolBar & bloodPressureToolBarBts  ***************
    //cancel
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
    bloodPressureToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    
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
    
    
    //****************  weiToolBar & weiToolBarBts  ******************
    //Cancel
    UIBarButtonItem *weiToolBarCancelBt = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(weightCancelBtAction)];
    [weiToolBarCancelBt setTintColor:[UIColor darkGrayColor]];
    
    
    //wei
    UIBarButtonItem *weiBt = [[UIBarButtonItem alloc] initWithTitle:@"WEI" style:UIBarButtonItemStylePlain target:self action:nil];
    [weiBt setTintColor:[UIColor blackColor]];
    
    
    UIBarButtonItem *weiNextToBmiBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(weiNextToBmiBtAction)];
    
    
    //weiToolBar
    weiToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/16)];
    
    [weiToolBar setItems:@[weiToolBarCancelBt,space,weiBt,space,weiNextToBmiBt] animated:NO];
    
    
    //****************  bmiToolBar & bmiToolBarBts  ******************
    //bmiBackToWeiBt
    UIBarButtonItem *bmiBackToWeiBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(bmiBackToWeiBtAction)];
    [bmiBackToWeiBt setTintColor:[UIColor darkGrayColor]];
    
    
    //bmi
    UIBarButtonItem *bmiBt = [[UIBarButtonItem alloc] initWithTitle:@"BMI" style:UIBarButtonItemStylePlain target:self action:nil];
    [bmiBt setTintColor:[UIColor blackColor]];
    
    //bmiNextToFatBt
    UIBarButtonItem *bmiNextToFatBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(bmiNextToFatBTAction)];
    
    //bmiToolBar
    bmiToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,toolBarWidth, toolBarHeight)];
    [bmiToolBar setItems:@[bmiBackToWeiBt,space,bmiBt,space,bmiNextToFatBt] animated:NO];
    
    
    //****************  fatToolBar & fatToolBarBts  ******************
    //fatBacktoBmiBt
    UIBarButtonItem *fatBacktoBmiBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(fatBackToBmiBtAction)];
    [fatBacktoBmiBt setTintColor:[UIColor darkGrayColor]];
    
    //fatBt
    UIBarButtonItem *fatBt = [[UIBarButtonItem alloc] initWithTitle:@"FAT" style:UIBarButtonItemStylePlain target:self action:nil];
    [fatBt setTintColor:[UIColor blackColor]];
    
    //fatNextToWeightTime
    UIBarButtonItem *fatNextToWeightTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(fatNextToWeightTimeBtAction)];
    
    fatToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,toolBarWidth, toolBarHeight)];
    [fatToolBar setItems:@[fatBacktoBmiBt,space,fatBt,space,fatNextToWeightTimeBt] animated:NO];
    
    
    //****************  weightTimeToolBar & weightTimeToolBarBts  ******************
    //weightTimeBackToFatBt
    UIBarButtonItem *weightTimeBackToFatBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(weightTimeBackTofatBtAction)];
    [weightTimeBackToFatBt setTintColor:[UIColor darkGrayColor]];
    
    //weightTimeBt
    UIBarButtonItem *weightTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"TIME" style:UIBarButtonItemStylePlain target:self action:nil];
    [weightTimeBt setTintColor:[UIColor blackColor]];
    
    
    //weightTimeNextToDateBt
    UIBarButtonItem *weightTimeNextToDateBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(weightTimeNextToWeightDateBtAction)];
    
    
    //weightTimeToolBar
    weightTimeToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,toolBarWidth,toolBarHeight)];
    [weightTimeToolBar setItems:@[weightTimeBackToFatBt,space,weightTimeBt,space,weightTimeNextToDateBt] animated:NO];
    
    
    //****************  weightDateToolBar & weightDateToolBarBts  ******************
    //weightDateBackToTimeBt
    UIBarButtonItem *weightDateBackToTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(weightDateBackToWeightTimeBtAction)];
    [weightDateBackToTimeBt setTintColor:[UIColor darkGrayColor]];
    
    //weightDateBt
    UIBarButtonItem *weightDateBt = [[UIBarButtonItem alloc] initWithTitle:@"DATE" style:UIBarButtonItemStylePlain target:self action:nil];
    [weightDateBt setTintColor:[UIColor blackColor]];
    
    //weightSave
    UIBarButtonItem *weightSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(weightSaveBtAction)];
    
    
    //weightTimeToolBar
    weightDateToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    [weightDateToolBar setItems:@[weightDateBackToTimeBt,space,weightDateBt,space,weightSave] animated:NO];
    
    
    
    //****************  bodyTempToolBar & bodyTempToolBarBts  **************
    //bodyTempCancelBt
    UIBarButtonItem *bodyTempCancelBt = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(bodyTempCancelBtAction)];
    [bodyTempCancelBt setTintColor:[UIColor darkGrayColor]];
    
    //bodyTempBt
    UIBarButtonItem *bodyTempBt = [[UIBarButtonItem alloc] initWithTitle:@"BODY TEMP" style:UIBarButtonItemStylePlain target:self action:nil];
    [bodyTempBt setTintColor:[UIColor blackColor]];
    
    //bodyTempNextToRoomTempBt
    UIBarButtonItem *bodyTempNextToRoomTempBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(bodyTempNextToRoomTempBtAction)];
    
    //bodyTempToolBar
    bodyTempToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    [bodyTempToolBar setItems:@[bodyTempCancelBt,space,bodyTempBt,space,bodyTempNextToRoomTempBt] animated:NO];
    
    
    //****************  roomTempToolBar & roomTempToolBarBts  **************
    //roomTempBackToBodyTempBt
    UIBarButtonItem *roomTempBackToBodyTempBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(roomTempBackToBodyTempBtAction)];
    
    [roomTempBackToBodyTempBt setTintColor:[UIColor darkGrayColor]];
    
    //roomTempBt
    UIBarButtonItem *roomTempBt = [[UIBarButtonItem alloc] initWithTitle:@"ROOM TEMP" style:UIBarButtonItemStylePlain target:self action:nil];
    [roomTempBt setTintColor:[UIColor blackColor]];
    
    
    //roomTempNextToTempTimeBt
    UIBarButtonItem *roomTempNextToTempTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(roomTempNextToTempTimeBtAction)];
    
    //roomTempToolBar
    roomTempToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    [roomTempToolBar setItems:@[roomTempBackToBodyTempBt,space,roomTempBt,space,roomTempNextToTempTimeBt] animated:NO];
    
    
    //****************  tempTimeToolBar & tempTimeToolBarBts  **************
    //tempTimeBackToRoomTempBt
    UIBarButtonItem *tempTimeBackToRoomTempBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(tempTimeBackToRoomTempBtAction)];
    [tempTimeBackToRoomTempBt setTintColor:[UIColor darkGrayColor]];
    
    //tempTimeBt
    UIBarButtonItem *tempTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Time" style:UIBarButtonItemStylePlain target:self action:nil];
    [tempTimeBt setTintColor:[UIColor blackColor]];
    
    //tempTimeNextToTempDateBt
    UIBarButtonItem *tempTimeNextToTempDateBt = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(tempTimeNextToTempDateBtAction)];
    
    //tempTimeToolBar
    tempTimeToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    [tempTimeToolBar setItems:@[tempTimeBackToRoomTempBt,space,tempTimeBt,space,tempTimeNextToTempDateBt] animated:NO];
    
    
    //****************  tempDateToolBar & tempDateToolBarBts  **************
    //tempDateBackToTempTimeBt
    UIBarButtonItem *tempDateBackToTempTimeBt = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(tempDateBackToTempTimeBtAction)];
    [tempDateBackToTempTimeBt setTintColor:[UIColor darkGrayColor]];
    
    //tempDateBt
    UIBarButtonItem *tempDateBt = [[UIBarButtonItem alloc] initWithTitle:@"DATE" style:UIBarButtonItemStylePlain target:self action:nil];
    [tempDateBt setTintColor:[UIColor blackColor]];
    
    //tempSaveBt
    UIBarButtonItem *tempSaveBt = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(tempSaveBtAction)];
    
    //tempDateToolBar
    tempDateToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, toolBarWidth, toolBarHeight)];
    [tempDateToolBar setItems:@[tempDateBackToTempTimeBt,space,tempDateBt,space,tempSaveBt] animated:NO];
    
}



#pragma mark - create callPickerViews
//-------------------------------------
-(void)createCallPickerViews {
    
    //callBPPickerView (血壓計)
    callBPPickerView = [[UITextField alloc] initWithFrame:CGRectMake(0,0, bloodPressureView.frame.size.width/3, bloodPressureView.frame.size.width/3)];
    callBPPickerView.center = CGPointMake(bloodPressureView.frame.size.width/2, bloodPressureView.frame.size.height/4.5);
    callBPPickerView.backgroundColor = [UIColor clearColor];
    callBPPickerView.tintColor = [UIColor clearColor];
    [callBPPickerView addTarget:self action:@selector(callPickerViewAction) forControlEvents:UIControlEventEditingDidBegin];
    callBPPickerView.inputView = bpPickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = bloodPressureToolBar;
    [bloodPressureView addSubview:callBPPickerView];
    
    //callWEIPickerView (體重計)
    callWEIPickerView = [[UITextField alloc] initWithFrame:CGRectMake(0,0, weightView.frame.size.width/3, weightView.frame.size.width/3)];
    callWEIPickerView.center = CGPointMake(weightView.frame.size.width/2, weightView.frame.size.height/4.5);
    callWEIPickerView.backgroundColor = [UIColor clearColor];
    callWEIPickerView.tintColor = [UIColor clearColor];
    [callWEIPickerView addTarget:self action:@selector(callPickerViewAction) forControlEvents:UIControlEventEditingDidBegin];
    callWEIPickerView.inputView = weiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weiToolBar;
    [weightView addSubview:callWEIPickerView];

    
    
    //callTEMPPickerView (溫度計)
    callTempPickerView = [[UITextField alloc] initWithFrame:CGRectMake(0,0, bodyTemperatureView.frame.size.width/3, bodyTemperatureView.frame.size.width/3)];
    callTempPickerView.center = CGPointMake(bodyTemperatureView.frame.size.width/2, bodyTemperatureView.frame.size.height/4.5);
    callTempPickerView.backgroundColor = [UIColor clearColor];
    callTempPickerView.tintColor = [UIColor clearColor];
    [callTempPickerView addTarget:self action:@selector(callPickerViewAction) forControlEvents:UIControlEventEditingDidBegin];
    
    callTempPickerView.inputView = bodyTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = bodyTempToolBar;
    
    [bodyTemperatureView addSubview:callTempPickerView];

}


#pragma mark - 生成 bloodPressure 大小圓
//-------------------------------------
-(void)createBloodPressureCircle {
    
    //bloodPressure 藍色大圓
    bloodPressureCircleView = [[OverViewCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.88, self.view.frame.size.width/1.88)];
    bloodPressureCircleView.center = CGPointMake(bloodPressureView.frame.size.width/2, overView_scrollView.frame.size.height/3.88);
    [bloodPressureView addSubview:bloodPressureCircleView];
    
    bloodPressureCircleView.circleViewTitleString = @"SYS/DIA";
    bloodPressureCircleView.circleViewUnitString = @"mmHg";
    bloodPressureCircleView.device = 0; //0:血壓計
    bloodPressureCircleView.sys = 0;
    bloodPressureCircleView.dia = 0;
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
    weightCircleView.circleViewUnitString = @"kg";
    weightCircleView.device = 1; //1:體重計
    weightCircleView.weight = 0;
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
    bodyTemperatureCircleView.circleViewUnitString = @"";
    bodyTemperatureCircleView.device = 2; //2:溫度計
    bodyTemperatureCircleView.temp = 0;
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
    
    
    //rainbowViewForBp
    rainbowViewForBp = [[RainbowBarView alloc] initWithRainbowView:CGRectMake(0, CGRectGetMaxY(bpRainbowBarBt.frame) + bpRainbowBarBt.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    [rainbowViewForBp checkRainbowbarValue:measureSpec sys:bloodPressureCircleView.sys dia:bloodPressureCircleView.dia];
    [bloodPressureView addSubview:rainbowViewForBp];
    rainbowViewForBp.hidden = YES;
    
    
    
}


#pragma mark - sysDia and pul CurveBt Action
-(void)sysDiaAndPulCurveBtAction:(UIButton *)sender {
    
    isBPRainbowBarBtSelected = NO;
    
    [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    
    if (sender == sysAndDiaCurveBt) {
        
        [sysAndDiaCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sysAndDiaCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [pulCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [pulCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [self createChartWithType:0];
        
    }
    else if (sender == pulCurveBt) {
        
        [sysAndDiaCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [sysAndDiaCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [pulCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [pulCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [self createChartWithType:1];
    }
    
    BPChartView.hidden = NO;
    rainbowViewForBp.hidden = YES;
}

#pragma mark - bloodPressure RainbowBarBt Action
-(void)bpRainbowBarBtAction:(UIButton *)sender {
    
    isBPRainbowBarBtSelected = isBPRainbowBarBtSelected == YES ? NO : YES;
    
    if (isBPRainbowBarBtSelected) {
        
        [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_1"] forState:UIControlStateNormal];
        
        [rainbowViewForBp checkRainbowbarValue:measureSpec sys:bloodPressureCircleView.sys dia:bloodPressureCircleView.dia];
        
        BPChartView.hidden = YES;
        rainbowViewForBp.hidden = NO;
    }
    else {
        
        
        [bpRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
        
        BPChartView.hidden = NO;
        rainbowViewForBp.hidden = YES;
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
    
    
    //rainbowViewForBp
    rainbowViewForBMI = [[RainbowBarView alloc] initWithRainbowView:CGRectMake(0, CGRectGetMaxY(weightRainbowBarBt.frame) + weightRainbowBarBt.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    [rainbowViewForBMI checkBMIValue:BMIValue];
    [weightView addSubview:rainbowViewForBMI];
    rainbowViewForBMI.hidden = YES;

}

#pragma WEI BMI FAT curveBt Action
-(void)weiBmiFatBtAction:(UIButton *)sender {
    
    isweightRainbowBarBtSelected = NO;
    
    [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
    
    if (sender == weiCurveBt) {
        
        [weiCurveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor: STANDER_COLOR forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [self createChartWithType:2];
        
        
    }
    else if (sender == bmiCurveBt) {
        
        [weiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [self createChartWithType:3];
    }
    else if (sender == fatCurveBt) {
        
        [weiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [weiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [bmiCurveBt setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
        [bmiCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        
        [fatCurveBt setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [fatCurveBt setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        
        [self createChartWithType:4];
    }
    
    weightChartView.hidden = NO;
    rainbowViewForBMI.hidden = YES;
    
}

#pragma mark - weight RainbowBarBt Action
-(void)weightRainbowBarBtAction:(UIButton *)sender {
    
    isweightRainbowBarBtSelected = isweightRainbowBarBtSelected == YES ? NO : YES;
    
    if (isweightRainbowBarBtSelected) {
        
        [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_1"] forState:UIControlStateNormal];
        
        [rainbowViewForBMI checkBMIValue:BMIValue];
        
        weightChartView.hidden = YES;
        rainbowViewForBMI.hidden = NO;
    }
    else {
        
        [weightRainbowBarBt setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_bar_0"] forState:UIControlStateNormal];
        
        weightChartView.hidden = NO;
        rainbowViewForBMI.hidden = YES;
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
    [pulValueBt setTitle:@"--" forState:UIControlStateNormal];
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
    deviceStatus.textColor = TEXT_COLOR;
    deviceStatus.text = @"Off";
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
    [bmiValueBt setTitle:@"--" forState:UIControlStateNormal];
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
    bodyFatValueLabel.text = @"--";
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
    
    //weight *******************
    //WEI
    weiPickerView = [[WEIPickerView alloc] initWithWeiPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //BMI
    bmiPickerView = [[BMIPickerView alloc] initWithBMIPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];

    
    //FAT
    fatPickerView = [[FATPickerView alloc] initWithFATPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    
    //Skeleton
    //skeletonPickerView = [[SkeletonPickerView alloc] initWithSkeletonPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //Muscle
    //musclePickerView = [[MusclePickerView alloc] initWithMusclePickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //BMR
    //bmrPickerView = [[BMRPickerView alloc] initWithBMRPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //OrganFat
    //organFatPickerView = [[OrganFatPickerView alloc] initWithOrganFatPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    

    //Temp  *********************
    //BodyTemp
    bodyTempPickerView = [[BodyTempPickerView alloc] initWithBodyTempPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    //RoomTemp
    roomTempPickerView = [[RoomTempPickerView alloc] initWithRoomTempPickerView:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    
    
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

#pragma mark - toolBarBtActions
//---------------------------------------------------------------
//bloodPressure  *********************
-(void)toolBarCancelBtAction {
    
    blurView.hidden = YES;
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = bpPickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = bloodPressureToolBar;

}

-(void)bpNextTopulBtAction {

    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = pulPickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = pulToolBar;
    [callBPPickerView becomeFirstResponder];
}


//pul
-(void)pulBackTobpBtAction {
    
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = bpPickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = bloodPressureToolBar;
    [callBPPickerView becomeFirstResponder];
}


-(void)pulNextToTimeBtAction {
    
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = timePickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = timeToolBar;
    [callBPPickerView becomeFirstResponder];
}


//bp time
-(void)timeBackToPulBtAction {
    
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = pulPickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = pulToolBar;
    [callBPPickerView becomeFirstResponder];
}


-(void)timeNextToDateBtAction {
    
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = datePickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = dateToolBar;
    [callBPPickerView becomeFirstResponder];
}

//bp date
-(void)dateBackToTimeBtAction {
    
    [callBPPickerView resignFirstResponder];
    callBPPickerView.inputView = timePickerView.m_pickerView;
    callBPPickerView.inputAccessoryView = timeToolBar;
    [callBPPickerView becomeFirstResponder];
    
}

-(void)toolBarSaveBtAction {
    
    [callBPPickerView resignFirstResponder];
    
    blurView.hidden = YES;
    
}


-(void)callPickerViewAction {
    
    blurView.hidden = NO;
    
}


//weight Cancel  *****************
-(void)weightCancelBtAction {
    
    blurView.hidden = YES;
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = weiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weiToolBar;
    
}

//wei nextTo bmi
-(void)weiNextToBmiBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = bmiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = bmiToolBar;
    [callWEIPickerView becomeFirstResponder];
    
}

//bmi backTo wei
-(void)bmiBackToWeiBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = weiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weiToolBar;
    [callWEIPickerView becomeFirstResponder];
}

//bmi nextTo Fat
-(void)bmiNextToFatBTAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = fatPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = fatToolBar;
    [callWEIPickerView becomeFirstResponder];
    
}

//fat backTo bmi
-(void)fatBackToBmiBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = bmiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = bmiToolBar;
    [callWEIPickerView becomeFirstResponder];
    
}

//fat nextTo Time
-(void)fatNextToWeightTimeBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = timePickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weightTimeToolBar;
    [callWEIPickerView becomeFirstResponder];
    
}

//weightTime backTo fat
-(void)weightTimeBackTofatBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = fatPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = fatToolBar;
    [callWEIPickerView becomeFirstResponder];
    
}

//weightTime nextTo weightDate
-(void)weightTimeNextToWeightDateBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = datePickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weightDateToolBar;
    [callWEIPickerView becomeFirstResponder];
}

//weightDate backTo weightTime
-(void)weightDateBackToWeightTimeBtAction {
    
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = timePickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weightTimeToolBar;
    [callWEIPickerView becomeFirstResponder];
}

//weight save
-(void)weightSaveBtAction {
    
    blurView.hidden = YES;
    [callWEIPickerView resignFirstResponder];
    callWEIPickerView.inputView = weiPickerView.m_pickerView;
    callWEIPickerView.inputAccessoryView = weiToolBar;
    
}



//bodytemp cancel  *******************
-(void)bodyTempCancelBtAction {
    
    blurView.hidden = YES;
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = bodyTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = bodyTempToolBar;
}

//bodyTemp NextTo RoomTemp
-(void)bodyTempNextToRoomTempBtAction {
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = roomTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = roomTempToolBar;
    [callTempPickerView becomeFirstResponder];
}

//roomTemp backTo bodyTemp
-(void)roomTempBackToBodyTempBtAction {
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = bodyTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = bodyTempToolBar;
    [callTempPickerView becomeFirstResponder];
    
}

//roomTemp nextTo time
-(void)roomTempNextToTempTimeBtAction {
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = timePickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = tempTimeToolBar;
    [callTempPickerView becomeFirstResponder];
}

//TempTime backTo roomTemp
-(void)tempTimeBackToRoomTempBtAction {
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = roomTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = roomTempToolBar;
    [callTempPickerView becomeFirstResponder];
    
}

//TempTime nextTo TempDate
-(void)tempTimeNextToTempDateBtAction {
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = datePickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = tempDateToolBar;
    [callTempPickerView becomeFirstResponder];
}

//TempDate backTo tempTime
-(void)tempDateBackToTempTimeBtAction {
    
    
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = timePickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = tempTimeToolBar;
    [callTempPickerView becomeFirstResponder];
}


//TempDate save
-(void)tempSaveBtAction {
    
    blurView.hidden = YES;
    [callTempPickerView resignFirstResponder];
    callTempPickerView.inputView = bodyTempPickerView.m_pickerView;
    callTempPickerView.inputAccessoryView = bodyTempToolBar;
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

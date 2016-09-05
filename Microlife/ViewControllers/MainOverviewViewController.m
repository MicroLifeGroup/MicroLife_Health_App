

#import "MainOverviewViewController.h"
#import "CirleView.h"
#import "HealthEducationViewController.h"
#import "NotificationViewController.h"
#import "AboutViewController.h"
#import "LogoutViewController.h"

@interface MainOverviewViewController () <UIScrollViewDelegate> {
    
    //擷取裝置時間
    NSTimer *getDateTimer;
    UILabel *timeLabel;
    
    //切割單位長度
    CGFloat unitHeight;
    

    //顯示 體溫-血壓-體重列表 (包含箭頭 及 list名稱)
    UIView *listView;
    UILabel *listLable;
    UIImageView *listArrowImg;
    UIButton *listBt;
    UIView *listSperatorView;
    BOOL isListAction;//顯示列表
    
    
    
    //overview scrollView
    UIScrollView *overView_scrollView;
    NSMutableArray <UIView *> *ary_overView_subViews;
    UIPageControl *page;
    //三個 overview scrollView 的 subViews
    UIView *bloodPressureView;
    UIView *weightView;
    UIView *bodyTemperatureView;
    
}


@end

@implementation MainOverviewViewController

#pragma mark - viewNormal function
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
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame),theTitleView.frame.size.width*0.253, theTitleView.frame.size.height/3)];
    
    timeLabel.textColor = TEXT_COLOR;
    
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
    weightView.backgroundColor = [UIColor greenColor];
    [overView_scrollView addSubview:weightView];
    
    //bodyTemperatureView
    bodyTemperatureView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, bloodPressureView.frame.size.width, overView_scrollView.frame.size.height)];
    bodyTemperatureView.backgroundColor = [UIColor cyanColor];
    [overView_scrollView addSubview:bodyTemperatureView];
    
    
    
    
    //***********  pageControl  *************
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(listSperatorView.frame) - 0.5*unitHeight, self.view.frame.size.width, 0.5*unitHeight)];
    
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_dot_a_0"]];
    
    page.currentPageIndicatorTintColor = [UIColor grayColor];
    
    page.numberOfPages = 3;
    
    page.currentPage = 0;
    
    [self.view addSubview:page];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    //getTimer 計時開始(navigationBar 顯示時間用)
    getDateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(getDateAndTime) userInfo:nil repeats:YES];
    
    //藍色大圓
    CGFloat bigCircleWidth = self.view.frame.size.width/1.7;
    CirleView *bigCircle = [[CirleView alloc]initWithFrame:CGRectMake(0, 0, bigCircleWidth, bigCircleWidth)];
    bigCircle.center = CGPointMake(bloodPressureView.center.x, bloodPressureView.frame.size.height/3.5);
    bigCircle.circleColor = STANDER_COLOR;
    bigCircle.circleWidth = 5.0f;
    [bloodPressureView addSubview:bigCircle];
    
    //藍色小圓
    
    
    
}


-(void)viewDidDisappear:(BOOL)animated {
    
    //getDateTimer  停止
    [getDateTimer invalidate];
    getDateTimer = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - profileBtAction (導覽列左邊按鍵方法)
-(void)profileBtAction {
    
    [self SidebarBtn];
}


#pragma mark - listBtAction 
-(void)listBtAction:(UIButton *)sender {
    
    isListAction = isListAction == YES ? NO : YES;
    
    if (isListAction == YES) {
        
        listView.frame = CGRectMake(0, 0, listView.frame.size.width, listView.frame.size.height);
        
        listBt.frame = listView.frame;
        
        listArrowImg.image = [UIImage imageNamed:@"all_icon_a_arrow_down"];
        
        listSperatorView.hidden = YES;
        
        [self.view bringSubviewToFront:listView];
        [self.view bringSubviewToFront:listBt];
    }
    else {
        
        listView.frame = CGRectMake(0,unitHeight*8.4, listView.frame.size.width, listView.frame.size.height);
        
        listBt.frame = listView.frame;
        
        listArrowImg.image = [UIImage imageNamed:@"all_icon_a_arrow_up"];
        
        listSperatorView.hidden = NO;
    }
    
}


#pragma mark -  取得裝置目前時間
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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

@end

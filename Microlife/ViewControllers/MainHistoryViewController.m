//
//  MainHistoryViewController.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MainHistoryViewController.h"
#import "HistoryPageView.h"
#import "EditListViewController.h"
#import "BLEDataHandler.h"

@interface MainHistoryViewController ()<UINavigationControllerDelegate, UIScrollViewDelegate,HistoryPageViewDelegate,HistoryListDelegate>{
    UIPageControl *pageControl;
    HistoryListTableView *listsView;
    UIImageView *titleImgView;
    
    HistoryPageView *tempView;
    HistoryPageView *weightView;
    HistoryPageView *BPView;
}

@end

@implementation MainHistoryViewController



@synthesize contentScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
    
   // NSLog(@"[WeightClass sharedInstance] = %@", [[WeightClass sharedInstance] selectAllData]);
    //NSLog(@"[BTClass sharedInstance] = %@", [[BTClass sharedInstance] selectAllData]);
   // NSLog(@"[BPMClass sharedInstance] = %@", [[BPMClass sharedInstance] selectAllData]);
    NSLog(@"selectAllData = %@",[[BPMClass sharedInstance] selectAllData]);
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (listsView != nil) {
        [listsView.historyList reloadData];
    }
    
    if (tempView != nil) {
        [tempView renderEventCircle];
    }
    
}

-(void)initParameter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentEditVC) name:@"showEditVC" object:nil];
    
}

-(void)initInterface{
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    
    [self setNavgationTitle];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-tabBarHeight-self.view.bounds.size.height*0.05-100, self.view.bounds.size.width, self.view.bounds.size.height*0.02)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_dot_a_0.png"]];
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_dot_a_1.png"]];
    
    [contentScroll setPagingEnabled:YES];
    [contentScroll setShowsHorizontalScrollIndicator:NO];
    [contentScroll setShowsVerticalScrollIndicator:NO];
    [contentScroll setScrollsToTop:NO];
    [contentScroll setDelegate:self];
    
    [self setNavigationImage];
    
    CGFloat width, height;
    width = contentScroll.frame.size.width;
    height = self.view.bounds.size.height-navHeight-tabBarHeight-20;
    [contentScroll setContentSize:CGSizeMake(width * 3, height)];
    
    BPView = [[HistoryPageView alloc] initWithFrame:CGRectMake(0, 0, contentScroll.frame.size.width, height)];
    BPView.delegate = self;
    BPView.chartType = 0;
    BPView.viewType = 0;
    [BPView initBPCurveControlButton];
    [BPView setSegment:[NSArray arrayWithObjects:@"DAY", @"WEEK", @"MONTH", @"YEAR", nil]];
    //[BPView setTimeLabelTitle:@"26/07/2016"];
    [BPView initBPHealthCircle];
    [BPView setAbsentDaysText:20 andFaceIcon:[UIImage imageNamed:@"history_icon_a_face_2"]];
    
    weightView = [[HistoryPageView alloc] initWithFrame:CGRectMake(width, 0, contentScroll.frame.size.width, height)];
    weightView.delegate = self;
    weightView.chartType = 2;
    weightView.viewType = 1;
    [weightView initWeightCurveControlButton];
    [weightView setSegment:[NSArray arrayWithObjects:@"DAY", @"WEEK", @"MONTH", @"YEAR", nil]];
    //[weightView setTimeLabelTitle:@"26/07/2016"];
    [weightView initWeightHealthCircle];
    [weightView setAbsentDaysText:100 andFaceIcon:[UIImage imageNamed:@"history_icon_a_face_3"]];
    
    
    tempView = [[HistoryPageView alloc] initWithFrame:CGRectMake(width*2, 0, contentScroll.frame.size.width, height)];
    tempView.delegate = self;
    tempView.chartType = 5;
    tempView.viewType = 2;
    [tempView setSegment:[NSArray arrayWithObjects:@"1HR", @"4HR", @"24HR", nil]];
    //[tempView setTimeLabelTitle:@"26/07/2016"];
    [tempView initTempHealthCircle];
    [tempView setAbsentDaysText:0 andFaceIcon:[UIImage imageNamed:@"history_icon_a_face_1"]];
    
    
    [tempView initTempCurveControlButton];
    [tempView renderEventCircle];
    
    [contentScroll addSubview:BPView];
    [contentScroll addSubview:weightView];
    [contentScroll addSubview:tempView];
    [self.view addSubview:pageControl];
    
}

-(void)setNavigationImage{
    
    UIImage *titleImg;
    
    switch (pageControl.currentPage) {
        case 0:
            titleImg = [UIImage imageNamed:@"history_icon_a_bpm"];
            break;
            
        case 1:
            titleImg = [UIImage imageNamed:@"history_icon_a_ws"];
            break;
            
        case 2:
            titleImg = [UIImage imageNamed:@"history_icon_a_ncfr"];
            break;
            
        default:
            break;
    }
    
    titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    titleImgView.image = titleImg;
    
    titleImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.navigationItem.titleView = titleImgView;
    
}

-(void)setNavgationTitle{
    
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
    
}

-(void)presentEditVC{
    
    EditListViewController *editListVC = [[EditListViewController alloc] init];
        
    [self.navigationController pushViewController:editListVC animated:YES];
}

#pragma mark - profileBtAction (導覽列左邊按鍵方法)
-(void)profileBtAction {
    
    [self SidebarBtn];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == contentScroll) {
        
        CGFloat width = scrollView.frame.size.width;
        
        NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;
        
        [pageControl setCurrentPage:currentPage];
        [self setNavigationImage];
    }
}

#pragma mark - HistoryPageView Delegate
-(void)showListButtonTapped:(UIView *)btnSnapShot{
    
    [listsView removeFromSuperview];
    
    listsView = [[HistoryListTableView alloc] initWithFrame:CGRectMake(0, self.tabBarController.tabBar.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    listsView.listType = pageControl.currentPage;
    listsView.delegate = self;
    [listsView.hideListBtn addSubview:btnSnapShot];
    
    [self.view addSubview:listsView];
    
    self.tabBarController.tabBar.hidden = YES;
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    pageControl.hidden = YES;
    
    [UIView transitionWithView:listsView duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
        
        listsView.frame = CGRectMake(0, 0, listsView.frame.size.width, listsView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideListButtonTapped{
    
    [UIView transitionWithView:listsView duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
        
        listsView.frame = CGRectMake(0, self.view.frame.size.height, listsView.frame.size.width, listsView.frame.size.height);
        
    } completion:^(BOOL finished) {
        //
    }];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    pageControl.hidden = NO;

}

-(void)GraphViewScrollBegin{
    contentScroll.scrollEnabled = NO;
}

-(void)GraphViewScrollEnd{
    contentScroll.scrollEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

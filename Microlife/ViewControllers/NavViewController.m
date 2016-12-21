//
//  NavViewController.m
//  Microlife
//
//  Created by 點睛 on 2016/9/21.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "NavViewController.h"
#import "UserLoginViewController.h"
#import "ViewController.h"

@implementation NavViewController
{
    UIPageControl *pageControl;
    UIScrollView *navScrollView;
    ViewController *loginVC;
    UIView *logoView;
}
@synthesize navImageArray,navTextArray;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showLogoView];
}

-(void)showLogoView
{
    logoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [logoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:logoView];
    
    //add logo image
    CGFloat logo_w=SCREEN_WIDTH*0.8;
    CGFloat logo_h=SCREEN_HEIGHT*0.6;
    CGFloat logo_x=(SCREEN_WIDTH/2.0)-(logo_w/2.0);
    CGFloat logo_y=(SCREEN_HEIGHT/3.0);//-(logo_h/2.0);
    
    UIImage *logoImage=[UIImage imageNamed:@"ml_logo"];
    UIImageView *logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(logo_x, logo_y, logo_w, logo_h)];
    [logoImageView setImage:logoImage];
    
    [logoView addSubview:logoImageView];
    
}

-(void)showNavView
{
    [logoView removeFromSuperview];
    
    [self initParameter];
    [self initInterface];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(showNavView) withObject:nil afterDelay:3.0];
    
}



-(void)initParameter
{
    navImageArray=[[NSMutableArray alloc]init];
    navTextArray=[[NSMutableArray alloc]init];
    
    //儲存5張圖片名稱
    for (int i=0; i<5; i++)
    {
        [navImageArray addObject:[NSString stringWithFormat:@"walkthrough_%d",i+1]];
    }
    
    //儲存5張圖片說明
    [navTextArray addObject:@"At microlife, we are deeply committed to empower you and your loved ones to live healthier lives."];
    [navTextArray addObject:@"Our mission is to bring innovative medical technologies to your home to make health management easier, smarter, and more accurate."];
    [navTextArray addObject:@"Use Microlife Connect Health + for simple overview and safekeeping of your readings. Stay on top of your health with ease, anytime, anywhere."];
    [navTextArray addObject:@"Set goals and reminders to establish healthy routines and monitor progresses for you and your loved ones."];
    [navTextArray addObject:@"Your partner for better health management."];
}

-(void)initInterface
{
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*1175/1334, SCREEN_WIDTH, SCREEN_HEIGHT*0.02)];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[self resizeImage:[UIImage imageNamed:@"walkthrough_page_1"]]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[self resizeImage:[UIImage imageNamed:@"walkthrough_page_0"]]];
    
    
    navScrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    navScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*navImageArray.count, SCREEN_HEIGHT);
    navScrollView.pagingEnabled=YES;
    navScrollView.bounces=NO;
    navScrollView.delegate=self;
    
    for (int i=0; i<navImageArray.count; i++)
    {
        
        UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        UILabel *navTextlabel=[[UILabel alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT*920/1334, SCREEN_WIDTH-80,50)];
        [navTextlabel setNumberOfLines:0];
        [navTextlabel setLineBreakMode:NSLineBreakByWordWrapping];
        [navTextlabel setText:[navTextArray objectAtIndex:i]];
        CGSize size = [navTextlabel sizeThatFits:CGSizeMake(navTextlabel.frame.size.width, MAXFLOAT)];
        [navTextlabel setFrame:CGRectMake(40, SCREEN_HEIGHT*920/1334, SCREEN_WIDTH-80,size.height)];
        [navTextlabel setTextColor:[UIColor whiteColor]];
        [navTextlabel setTextAlignment:NSTextAlignmentCenter];
        
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backImageView.image=[self resizeImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[navImageArray objectAtIndex:i]]]];
        
        [navView addSubview:backImageView];
        [navView addSubview:navTextlabel];
        
        //最後一頁
        if (i==navTextArray.count-1)
        {
            UIButton *privacyBtn=[[UIButton alloc]init];
            [privacyBtn setBackgroundImage:[UIImage imageNamed:@"walkthrough_btn_privacy"] forState:UIControlStateNormal];
            [privacyBtn setTitle:@"Privacy Mode" forState:UIControlStateNormal];
            [privacyBtn setTintColor:[UIColor whiteColor]];
            [privacyBtn setFrame:CGRectMake(SCREEN_WIDTH*220/750, SCREEN_HEIGHT*1030/1334, 300*SCREEN_WIDTH/750, 100*SCREEN_HEIGHT/1334)];
            [privacyBtn addTarget:self action:@selector(clickPrivacyBtn) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*165/750, SCREEN_HEIGHT*800/1334, 400*SCREEN_WIDTH/750, 100*SCREEN_HEIGHT/1334)];
            
            [logoImage setImage:[UIImage imageNamed:@"walkthrough_logo"]];
            
            UIButton *nextPageBtn=[[UIButton alloc]init];
            [nextPageBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-100*SCREEN_HEIGHT/1334, SCREEN_WIDTH, 100*SCREEN_HEIGHT/1334)];
            [nextPageBtn setBackgroundColor:STANDER_COLOR];
            [nextPageBtn setTitle:@"NextPage" forState:UIControlStateNormal];
            [nextPageBtn setTintColor:[UIColor whiteColor]];
            [nextPageBtn addTarget:self action:@selector(clickNextPageBtn) forControlEvents:UIControlEventTouchUpInside];
            [navView addSubview:privacyBtn];
            [navView addSubview:logoImage];
            [navView addSubview:nextPageBtn];
        }
        
        [navScrollView addSubview:navView];
    }

    [self.view addSubview:navScrollView];
    [self.view addSubview:pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == navScrollView)
    {
        CGFloat width = scrollView.frame.size.width;
        NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;
        [pageControl setCurrentPage:currentPage];
    }
}

-(void)clickPrivacyBtn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    
    [LocalData sharedInstance].accountID = -1;
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)clickNextPageBtn
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"UserLoginViewController"];
//    
//    [self presentViewController:vc animated:YES completion:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
//    if (loginVC == nil) {
//        
//        loginVC = (ViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
//    }
    
    //[appDelegate.window setRootViewController:vc];
    
    //[appDelegate.window makeKeyAndVisible];
}

@end

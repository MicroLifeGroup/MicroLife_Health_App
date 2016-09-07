//
//  MViewController.m
//  FuelSation
//
//  Created by Tom on 2016/4/14.
//  Copyright © 2016年 Tom. All rights reserved.
//

#import "MViewController.h"
#import "HealthEducationViewController.h"
#import "NotificationViewController.h"
#import "AboutViewController.h"
#import "LogoutViewController.h"

@interface MViewController (){
    
}


@end

@implementation MViewController

@synthesize imgScale,appDelegate;
@synthesize sidebarcloseBtn;
@synthesize circleview;
#pragma mark - System default

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if(IS_IPHONE_5){
        imgScale = 2.2;
    }else if(IS_IPHONE_6){
        imgScale = 2;
    }else if(IS_IPHONE_6P){
        imgScale = 1.75;
    }else{
        imgScale = 2.5;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //改變self.title 的字體顏色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //改變 navigationBar 的底色
    self.navigationController.navigationBar.barTintColor = STANDER_COLOR;
    
    //改變 statusBarStyle(字體變白色)
    //先將 info.plist 中的 View controller-based status bar appearance 設為 NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Screen Rotation

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{


}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return NO;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - left menu
-(void)SidebarBtn{
    
    
    int BtnRedius = self.view.frame.size.height/10;
    
    circleview = [[UIView alloc] initWithFrame:CGRectMake(-BtnRedius, -BtnRedius, BtnRedius*2, BtnRedius*2)];
    [circleview setBackgroundColor:[UIColor colorWithRed:0/255.0 green:61.0/255.0 blue:165.0/255.0 alpha:0.93]];
    circleview.layer.cornerRadius = BtnRedius;
    [[self.circleview layer] setMasksToBounds:YES];
    self.circleview.userInteractionEnabled = YES;
    
    
    sidebarcloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //[sidebarcloseBtn setBackgroundColor:[UIColor clearColor]];
    [sidebarcloseBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica"size:36]];
    [sidebarcloseBtn setTitle:@"close" forState:UIControlStateNormal];
    sidebarcloseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    sidebarcloseBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [sidebarcloseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sidebarcloseBtn addTarget:self action:@selector(sidebarClose) forControlEvents:UIControlEventTouchUpInside];
    
    // [self.view addSubview:circleview];
    [self.tabBarController.view addSubview:circleview];
    // [self.view addSubview:sidebarcloseBtn];
    [self.tabBarController.view addSubview:sidebarcloseBtn];
    
    
    
    
    circleview.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDuration:0.6];
    //圖片放大X倍
    circleview.transform = CGAffineTransformMakeScale(20.0f, 20.0f);
    /* Commit the animation */
    [UIView commitAnimations];
    
    float imageRadius = 10.0f;
    
    
    UIImageView *personalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, imageRadius, imageRadius)];
    UIImage *personImage = [UIImage imageNamed:@"personal"];
    personalImageView.image = personImage;
    personalImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSLog(@"personalImageView.x = %f",personalImageView.frame.origin.x);
    
    //personalImageView = [[UIImageView alloc] initWithImage:personImage];
    //[personalImageView setFrame:CGRectMake(80.0f,80.0f, imageRadius, imageRadius)];
    
    
    [personalImageView.layer setMasksToBounds:YES];
    personalImageView.layer.cornerRadius = imageRadius/2;
    
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.sidebarcloseBtn addSubview:personalImageView];
    
    /* 圖片置中 */
    //self.personalImageView.center = self.view.center;
    //設置轉換標誌
    personalImageView.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:0.2];
    //圖片放大X倍
    //[personalImageView layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    personalImageView.transform = CGAffineTransformMakeScale(10.0f, 10.0f);
    /* Commit the animation */
    [UIView commitAnimations];
    

    [self ImageExpand];
    [self Icon1];
    [self Icon2];
    [self Icon3];
    [self Icon4];
    [self PersonLabel];
    [self ImformationButton];
    [self cccccolor];
    
    //[self.navigationController.view addSubview:circleview];
    
    
    
    
}

-(void) sidebarClose{
    
    [sidebarcloseBtn removeFromSuperview];
    [circleview removeFromSuperview];
    [self cccccolor];
    
    //[self.view removeFromSuperview];
    
}




-(void) ImageExpand{
    
    
    
    float imageRadius = 10.0f;
    
    UIImageView *personalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, imageRadius, imageRadius)];
    UIImage *personImage = [UIImage imageNamed:@"personal"];
    personalImageView.image = personImage;
    personalImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSLog(@"personalImageView.x = %f",personalImageView.frame.origin.x);
    
    
    //personalImageView = [[UIImageView alloc] initWithImage:personImage];
    //[personalImageView setFrame:CGRectMake(80.0f,80.0f, imageRadius, imageRadius)];
    
    
    [personalImageView.layer setMasksToBounds:YES];
    personalImageView.layer.cornerRadius = imageRadius/2;
    
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.sidebarcloseBtn addSubview:personalImageView];
    
    
    
    /* 圖片置中 */
    //self.personalImageView.center = self.view.center;
    //設置轉換標誌
    personalImageView.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:0.2];
    //圖片放大X倍
    //[personalImageView layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    personalImageView.transform = CGAffineTransformMakeScale(10.0f, 10.0f);
    /* Commit the animation */
    [UIView commitAnimations];
    
}


-(void) PersonLabel{
    int labelHeight = 20;
    int labelwidth = 90;
    CGRect namelabelFrame = CGRectMake(80.0f/2, 160+20 , labelwidth+30 , (labelHeight+6));
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:namelabelFrame];
    [nameLabel setTextColor:[UIColor whiteColor]];
    nameLabel.alpha = 1;
    nameLabel.text = @"Ivy Huang";
    nameLabel.font = [UIFont systemFontOfSize:22];
    [self.sidebarcloseBtn addSubview:nameLabel];
    
    
    nameLabel.transform = CGAffineTransformIdentity;
    [nameLabel layer].anchorPoint = CGPointMake(0.5, 1);  //錨點
    [UIView animateKeyframesWithDuration:0.4 delay:0.1 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.0 animations: ^{
            
            nameLabel.transform = CGAffineTransformMakeScale(1.0, 0.001);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations: ^{
            
            nameLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
    
    
    
    //[ expandIntoView:self.view finished:NULL];
    
    
    
    CGRect emaillabelFrame = CGRectMake(80.0f/2, 160+20+labelHeight+15 , 4*labelwidth , labelHeight);
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:emaillabelFrame];
    [emailLabel setTextColor:[UIColor whiteColor]];
    emailLabel.text = @"ideabus@gmail.com";
    emailLabel.font = [UIFont systemFontOfSize:17];
    emailLabel.alpha = 1.0;
    [self.sidebarcloseBtn addSubview:emailLabel];
    
    emailLabel.transform = CGAffineTransformIdentity;
    [emailLabel layer].anchorPoint = CGPointMake(0.5, 1);  //錨點
    [UIView animateKeyframesWithDuration:0.4 delay:0.1 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.0 animations: ^{
            
            emailLabel.transform = CGAffineTransformMakeScale(1.0, 0.001);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations: ^{
            
            emailLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
    
    
    
    
    
}

-(void) ImformationButton{
    int bx = 122;
    int by = 265;
    int imbuttonHeight = 30;
    int imbuttonwidth = 140;
    
    CGRect buttonIB1Frame = CGRectMake( bx, by, imbuttonwidth, imbuttonHeight );
    UIButton *buttonIB1 = [[UIButton alloc] initWithFrame: buttonIB1Frame];
    [buttonIB1 setTitle:@"HealthEducation" forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [buttonIB1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonIB1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonIB1.alpha = 0.0;
    
    [self.sidebarcloseBtn addSubview:buttonIB1];
    [UIView animateWithDuration:0.05 delay:0.2 options:0 animations:^{
        buttonIB1.alpha = 1.0;
    } completion:^(BOOL finished) {
        //NSLog(@"動畫完成了");
    }];
    [buttonIB1 addTarget:self action:@selector(onClickButtonIB1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGRect buttonIB2Frame = CGRectMake( bx, by+60, imbuttonwidth, imbuttonHeight );
    UIButton *buttonIB2 = [[UIButton alloc] initWithFrame: buttonIB2Frame];
    [buttonIB2 setTitle:@"Notification" forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [buttonIB2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonIB2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonIB2.alpha = 0.0;
    
    [self.sidebarcloseBtn addSubview:buttonIB2];
    
    [UIView animateWithDuration:0.05 delay:0.35 options:0 animations:^{
        buttonIB2.alpha = 1.0;
    } completion:^(BOOL finished) {
        //NSLog(@"動畫完成了2");
    }];
    [buttonIB2 addTarget:self action:@selector(onClickButtonIB2:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect buttonIB3Frame = CGRectMake( bx, by+120, imbuttonwidth, imbuttonHeight );
    UIButton *buttonIB3 = [[UIButton alloc] initWithFrame: buttonIB3Frame];
    [buttonIB3 setTitle:@"About" forState:UIControlStateNormal];
    buttonIB3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[button setBackgroundColor:[UIColor blueColor]];
    [buttonIB3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonIB3.alpha = 0.0;
    
    [self.sidebarcloseBtn addSubview:buttonIB3];
    [UIView animateWithDuration:0.05 delay:0.5 options:0 animations:^{
        buttonIB3.alpha = 1.0;
    } completion:^(BOOL finished) {
        //NSLog(@"動畫完成了3");
    }];
    [buttonIB3 addTarget:self action:@selector(onClickButtonIB3:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect buttonIB4Frame = CGRectMake( bx, by+180, imbuttonwidth, imbuttonHeight );
    UIButton *buttonIB4 = [[UIButton alloc] initWithFrame: buttonIB4Frame];
    [buttonIB4 setTitle:@"Logout" forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [buttonIB4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonIB4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonIB4.alpha = 0.0;
    
    [self.sidebarcloseBtn addSubview:buttonIB4];
    [UIView animateWithDuration:0.05 delay:0.65 options:0 animations:^{
        buttonIB4.alpha = 1.0;
    } completion:^(BOOL finished) {
        // NSLog(@"動畫完成了4");
    }];
    
    [buttonIB4 addTarget:self action:@selector(onClickButtonIB4:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)onClickButtonIB1:(UIButton *)sender{
    
    
    NSLog(@"HealthEducationVC");
    
    // [self sidebarClose];
    
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    //
    
    HealthEducationViewController *HealthEducationVC = [HealthEducationViewController new];
    
    [self presentViewController:HealthEducationVC animated:YES completion:nil];
    
    HealthEducationVC.view.backgroundColor = [UIColor blackColor];
    HealthEducationVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    self.definesPresentationContext = YES;
    
    
    
    
    
    //    UIViewController *healtheducationVC = [[UIViewController alloc ]init];
    //    healtheducationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthEducationVC"];
    //    healtheducationVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //
    //    [self presentViewController:healtheducationVC animated:true completion:nil];
    
    
    
}

-(IBAction)onClickButtonIB2:(UIButton *)sender{
    
    
    NSLog(@"NotificationVC");
    
    
    NotificationViewController  *NotificationVC = [NotificationViewController new];
    
    [self presentViewController:NotificationVC animated:YES completion:nil];
    
    NotificationVC.view.backgroundColor = [UIColor whiteColor];
    NotificationVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    self.definesPresentationContext = YES;
    
    
    
    //    UIViewController *notificationVC = [[UIViewController alloc ]init];
    //    notificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
    //    notificationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //
    //    [self presentViewController:notificationVC animated:true completion:nil];
    
    
}

-(IBAction)onClickButtonIB3:(UIButton *)sender{
    
    
    NSLog(@"AboutVC");
    AboutViewController *AboutVC = [AboutViewController new];
    
    [self presentViewController:AboutVC animated:YES completion:nil];
    
    AboutVC.view.backgroundColor = [UIColor whiteColor];
    AboutVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    self.definesPresentationContext = YES;
    
    
    
    //    UIViewController *aboutVC = [[UIViewController alloc ]init];
    //    aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
    //    aboutVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //
    //    [self presentViewController:aboutVC animated:true completion:nil];
    
    
}

-(IBAction)onClickButtonIB4:(UIButton *)sender{
    
    NSLog(@"Logout");
    LogoutViewController  *LogoutVC = [LogoutViewController new];
    
    [self presentViewController:LogoutVC animated:YES completion:nil];
    
    LogoutVC.view.backgroundColor = [UIColor whiteColor];
    LogoutVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    self.definesPresentationContext = YES;
    
    
    //    UIViewController *logoutVC = [[UIViewController alloc ]init];
    //    logoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LogoutVC"];
    //    logoutVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //
    //    [self presentViewController:logoutVC animated:true completion:nil];
    //
    
}







-(void) Icon1{
    
    UIImageView *iconImgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(60-15, 265-15, 0.01, 30)];
    UIImage *iconImg1 = [UIImage imageNamed:@"menu_icon_a_health"];
    iconImgV1.image = iconImg1;
    iconImgV1.contentMode = UIViewContentModeScaleToFill;
    [self.sidebarcloseBtn addSubview :iconImgV1];
    
    
    //設置轉換標誌
    iconImgV1.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:0.1];
    //圖片放大X倍
    [iconImgV1 layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    iconImgV1.transform = CGAffineTransformMakeScale(3000.0f, 1.0f);
    
    /* Commit the animation */
    [UIView commitAnimations];
    
}

-(void) Icon2{
    
    UIImageView *iconImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(60-15, 325-15, 0.01, 30)];
    UIImage *iconImg2 = [UIImage imageNamed:@"menu_icon_a_notification"];
    iconImgV2.image = iconImg2;
    iconImgV2.contentMode = UIViewContentModeScaleToFill;
    [self.sidebarcloseBtn addSubview :iconImgV2];
    
    
    //設置轉換標誌
    iconImgV2.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.35];
    [UIView setAnimationDuration:0.1];
    //圖片放大X倍
    [iconImgV2 layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    iconImgV2.transform = CGAffineTransformMakeScale(3000.0f, 1.0f);
    
    /* Commit the animation */
    [UIView commitAnimations];
    
}

-(void) Icon3{
    
    UIImageView *iconImgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(60-15, 385-15, 0.01, 30)];
    UIImage *iconImg3 = [UIImage imageNamed:@"menu_icon_a_about"];
    iconImgV3.image = iconImg3;
    iconImgV3.contentMode = UIViewContentModeScaleToFill;
    [self.sidebarcloseBtn addSubview :iconImgV3];
    
    
    //設置轉換標誌
    iconImgV3.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationDuration:0.1];
    //圖片放大X倍
    [iconImgV3 layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    iconImgV3.transform = CGAffineTransformMakeScale(3000.0f, 1.0f);
    
    /* Commit the animation */
    [UIView commitAnimations];
    
}

-(void) Icon4{
    
    UIImageView *iconImgV4 = [[UIImageView alloc] initWithFrame:CGRectMake(60-15, 445-15, 0.01, 30)];
    UIImage *iconImg4 = [UIImage imageNamed:@"menu_icon_a_logout"];
    iconImgV4.image = iconImg4;
    iconImgV4.contentMode = UIViewContentModeScaleToFill;
    [self.sidebarcloseBtn addSubview :iconImgV4];
    
    
    //設置轉換標誌
    iconImgV4.transform = CGAffineTransformIdentity;
    /* 動畫開始 */
    [UIView beginAnimations:nil context:NULL];
    /* 動畫時間*/
    [UIView setAnimationDelay:0.65];
    [UIView setAnimationDuration:0.1];
    //圖片放大X倍
    [iconImgV4 layer].anchorPoint = CGPointMake(0.0f, 0.0f);
    iconImgV4.transform = CGAffineTransformMakeScale(3000.0f, 1.0f);
    
    /* Commit the animation */
    [UIView commitAnimations];
    
}

-(void) cccccolor{
    self.view.backgroundColor = [UIColor whiteColor];
}



@end

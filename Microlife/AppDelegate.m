//
//  AppDelegate.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ShareCommon.h"

@interface AppDelegate ()<GIDSignInDelegate>{
    int loginType;  //0 = FB  1 = Google;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [GIDSignIn sharedInstance].delegate = self;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFBNotification) name:@"FBLogin" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGoogleNotification) name:@"GoogleLogin" object:nil];
    
    
    //推播 localNotification
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (locationNotification) {
        [self startNotifyAndChangeIconNumberWithReset:true];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
    }
    
    //[self test];
    
    return YES;
}

-(void)getFacebookStatus{
    
}

- (void)receiveFBNotification{
    
    loginType = 0;
}

- (void)receiveGoogleNotification{
    loginType = 1;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //Local Notify
    //[self setLocalNoise];
    
}

//当本地通知触发后，需要在AppDelegate中进行接收并做相应处理
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSDictionary *user=notification.userInfo;
    
    NSLog(@"user:%@",user);
    
    if(user && notification.alertBody)
    {
        [ShareCommon showApplicationAlert:notification.alertBody Title:@"Alert"];
    }
    
    
    [self startNotifyAndChangeIconNumberWithReset:true];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];  //記錄應用程式啟動
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if (loginType == 0) {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    }
    
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    
}

//當textField已經结束被編輯，會委托代理調用這個方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
}

//當keyBoard上return键被點擊，委托代理調用這個方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
//返回值YES，NO没區别,似乎是系统會獲得這個返回值

//當textField中文字發生改變，調用這個方法

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}



#pragma mark - local Notification
- (void)setLocalNoise:(NSMutableArray*)noiseData
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //[self startNotifyAndChangeIconNumberWithReset:true];
    
    NSLog(@"=========");
    NSLog(@"%@",noiseData);
    NSLog(@"=========");
    
    for(NSDictionary *dic in noiseData)
    {
        BOOL status=(BOOL)[dic objectForKey:@"status"];
        
        if(status)
        {
            //typeName
            
            NSString *typeName;
            NSArray *typeArr=[dic objectForKey:@"type"];
            for(NSDictionary *itemDic in typeArr)
            {
                int choose=[[itemDic objectForKey:@"choose"] intValue];
                
                if(choose==1)
                {
                    typeName=[itemDic objectForKey:@"typeName"];
                }
            }
            
            NSString *alertBody=typeName;
            
            //model
            NSString *model=[dic objectForKey:@"model"];
            //min hour
            int min=[[dic objectForKey:@"min"] intValue];
            int hour=[[dic objectForKey:@"hour"] intValue];
            int sec=0;
            
            //weekName
            NSMutableArray *weekNameArr=[[NSMutableArray alloc]init];
            NSArray *weekArr=[dic objectForKey:@"week"];
            
            NSDate *now=[NSDate date];
            
            NSDate *startWeekDate=[ShareCommon getWeekStartForDate:now];
        
            
            int i=0;
            for(NSDictionary *itemDic in weekArr)
            {
                int choose=[[itemDic objectForKey:@"choose"] intValue];
                if(i>0)
                {
                    startWeekDate=[startWeekDate dateByAddingTimeInterval:24*60*60];
                }
                
                if(choose==1)
                {
                    NSString *wname=[itemDic objectForKey:@"weekName"];
                    if(wname && wname.length>0)
                    {
                        [weekNameArr addObject:[itemDic objectForKey:@"weekName"]];
                        
                        NSString *cDate=[ShareCommon DateToStringByFormate:startWeekDate formate:@"yyyy/MM/dd"];
                        
                        cDate=[NSString stringWithFormat:@"%@ %02d:%02d:%02d",cDate,hour,min,sec];
                        
                        NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
                        formatter.dateFormat        = @"yyyy/MM/dd HH:mm:ss";
                        NSDate *alertDate                = [formatter dateFromString:cDate];
                        
                        
                        
                        
                        
                        [self addNoise:alertDate alertBody:alertBody repeat:YES];

                    }
                    
                }
                
                i++;
            }
            
            NSLog(@"======");
            
            NSLog(@"typeName:%@",typeName);
            NSLog(@"model:%@",model);
            NSLog(@"hh:%d,min:%d,sec:%d",hour,min,sec);
            NSLog(@"Week:%@",weekNameArr);
            
            NSLog(@"======");
        }
        
    }
    
    

    
    //[self startNotifyAndChangeIconNumberWithReset:false];
    
}

- (void)startNotifyAndChangeIconNumberWithReset:(BOOL)isReset
{
    NSLog(@"startNotifyAndChangeIconNumberWithReset");
    
    if (isReset == true) {
        UIApplication *app = [UIApplication sharedApplication];
        app.applicationIconBadgeNumber = 0;
        
    }
    else
    {
        NSArray *notifLocalizations = [[UIApplication sharedApplication] scheduledLocalNotifications];
        int notifIndex = 1;
        for (UILocalNotification *local in notifLocalizations) {
            local.applicationIconBadgeNumber = notifIndex;
            local.userInfo = @{@"id":[NSString stringWithFormat:@"%li",(long)local.applicationIconBadgeNumber]};
            
            [[UIApplication sharedApplication] scheduleLocalNotification:local];
            notifIndex++;
        }
        
        
        notifLocalizations = nil;
    }
    
}
- (void)addNoise:(NSDate *)aDate alertBody:(NSString*)alertBody repeat:(BOOL)isReapeat {
    
    NSLog(@"addNoise:%@",[ShareCommon DateToStringByFormate:aDate formate:@"yyyy/MM/dd HH:mm:ss"]);
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    if (localNotification) {
        localNotification.fireDate = aDate;
        //        notifyAlarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:];
        
        localNotification.timeZone = [NSTimeZone localTimeZone];
        if (isReapeat == true) {
            localNotification.repeatInterval = NSCalendarUnitWeekOfYear;
        }
        else{
            localNotification.repeatInterval = 0;
        }
        
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        //        localNotification.alertTitle = @"DEPO Car Light";//DEPO Car Light
        localNotification.alertBody = [NSString stringWithFormat:@"%@\n%@",alertBody,aDate];
        
        
        
        [[UIApplication sharedApplication]  scheduleLocalNotification:localNotification];
        NSLog(@"add.COUNT:%@",localNotification);
    }
}


-(void)test{
    /*
    NSDate *now=[NSDate date];
    
    NSDate *startWeekDate=[ShareCommon getWeekStartForDate:now];
    
    for(int i=0;i<7;i++)
    {
        if(i>0)
        {
            startWeekDate=[startWeekDate dateByAddingTimeInterval:24*60*60];
        }
        
        NSString *cDate=[ShareCommon DateToStringByFormate:startWeekDate formate:@"yyyy/MM/dd"];
        NSLog(@"startWeekDate:%@",cDate);
    }
    
    
    */
    
}



@end

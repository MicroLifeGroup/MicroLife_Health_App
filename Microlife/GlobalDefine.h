//
//  GlobalDefine.h

//
//  Created by Tom on 2015/10/18.
//  Copyright © 2015年 Tom. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

//stroy board ID Name


//Db Name
#define kDBNameSQLite @"DataModel.sqlite"


//Data Formate
#define kDistanceFormat         @"%2.1f"
#define kCaloriesFormat         @"%d"
#define kHeartRateFormat        @"%d"
#define kTimeRemainingFormat    @"%2d:%02d"
#define kRPMFormat              @"%d"
#define kLevelFormat            @"%d"
#define kWattsFormat            @"%d"
#define kInclineLevelFormat     @"%d"
#define kLapsFormat             @"%2.1f"
#define kSpeedFormat            @"%2.1f"

#define kAverageHRFormat          @"%d bpm"
#define kAverageSpeedFormat       @"%2.1f mph"
#define kAverageRPMFormat         @"%d"
#define kAverageWattFormat        @"%d"
#define kAverageMETFormat         @"%2.1f"
#define kAverageResistanceFormat  @"%i"


//Rex
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define TEXT_COLOR ([UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1])

#define STANDER_COLOR ([UIColor colorWithRed:0/255.0 green:61.0/255.0 blue:165.0/255.0 alpha:1])

#define CIRCEL_RED ([UIColor colorWithRed:231.0/255.0 green:26.0/255.0 blue:15.0/255.0 alpha:1])

#define DARKTEXT_COLOR ([UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1])

#define TABLE_BACKGROUND ([UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1])
//

/******************/
//Type Define

 //頁面
 typedef enum
 {
     
     MainLoginPage,         //登入頁
     MainOverwatchPage,     //量測頁
     MainReminderPage,      //鬧鐘頁
     MainHistoryPage,       //歷史頁
     MainSettingPage,       //設定頁
     MainProfilePage        //個資頁
    
     
 }UIPageName;
 


#endif /* Global_Define_h */

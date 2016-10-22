//
//  LocalData.h
//  Microlife
//
//  Created by Rex on 2016/9/9.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject{
    NSMutableArray *reminderDataArray;
    NSUserDefaults *defaults;
    
    NSDictionary *latestValueDict;
    
    //Allen
    NSMutableArray *memberDataArray;
}

@property int accountID;
@property int UserAge;
@property float UserHeight;
@property float UserWeight;
@property int metric;//0 = KG CM   1=lb
@property int PULUnit;//0=bpm   1=beats;
@property int targetSYS;
@property int targetDIA;
@property float targetWeight;
@property float targetFat;
@property int measureSpec;//0:歐規,1:USA ,2:非歐非USA
@property int userArea;//BMI 0 = //亞洲區：23 1=//非亞洲區：25


+(LocalData *)sharedInstance;

//鬧鐘資料
-(NSMutableArray *)getReminderData;
-(void)saveReminderData:(NSMutableArray *)dataArray;

//最新資料
-(void)saveLatestMeasureValue:(NSDictionary *)latestValue;
-(NSDictionary *)getLatestMeasureValue;

//Allen
-(void)saveMemberProfile:(NSDictionary *)memberDict;
-(NSMutableArray *)returnMemberProfile;
@end

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
    NSMutableArray *listDataArray;
    
    NSDictionary*editListDict;
    
    //Allen
    NSMutableArray *memberDataArray;
    
}

//基本資料
@property int accountID;
@property int UserAge;
@property int UserGender; //0 = man 1=women
@property float UserHeight;
@property float UserWeight;
@property int metric;//0 = KG CM   1=lb
@property int PULUnit;//0=   1=beats;
@property int BPUnit;//0=bpm   1=kpa;
@property int targetSYS;
@property int targetDIA;
@property float targetWeight;
@property float targetFat;
@property float standerBMI;//BMI 亞洲區：23 非亞洲區：25
@property float standerFat;//FAT 男性：24% 女性：31%
@property int measureSpec;//0:歐規,1:USA ,2:非歐非USA
@property int userArea;//BMI 0 = //亞洲區：23 1=//非亞洲區：25
@property BOOL showTargetSYS;
@property BOOL showTargetDIA;
@property BOOL showTargetWeight;
@property BOOL showTargetFat;
@property (nonatomic, strong) NSString *birthday;

@property int currentEventId;

//歷史泡泡框
@property (nonatomic) float avgBodyTemp;
@property (nonatomic) float lastBodyTemp;
@property (nonatomic) float avgWeight;
@property (nonatomic) int avgSYS;
@property (nonatomic) int avgDIA;
@property (nonatomic) int AFIBFreq;
@property (nonatomic) int PADFreq;

+(LocalData *)sharedInstance;

//鬧鐘資料
-(NSMutableArray *)getReminderData;
-(void)saveReminderData:(NSMutableArray *)dataArray;

//最新資料
-(void)saveLatestMeasureValue:(NSDictionary *)latestValue;
-(NSDictionary *)getLatestMeasureValue;

//歷史頁列表
-(void)setListDataArray:(NSMutableArray *)listArray;
-(NSMutableArray *)getListData;

//歷史編輯頁面資料
-(void)setEditListDict:(NSDictionary *)dataDict;
-(NSDictionary *)getEditListDict;

//Allen
-(void)saveMemberProfile:(NSDictionary *)memberDict;
-(void)editMemberProfile:(NSDictionary *)memberDict atIndexPath:(int)index;
-(NSMutableArray *)returnMemberProfile;
@end

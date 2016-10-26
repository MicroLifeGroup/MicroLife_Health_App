//
//  LocalData.m
//  Microlife
//
//  Created by Rex on 2016/9/9.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData

@synthesize UserAge,UserHeight,UserWeight,metric,PULUnit,targetSYS,targetDIA,targetWeight,targetFat,measureSpec,userArea,UserGender,standerBMI,standerFat,showTargetDIA,showTargetSYS,showTargetFat,showTargetWeight;

+(LocalData*) sharedInstance{
    static LocalData *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [LocalData new];
    });
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    if (reminderDataArray == nil) {
        reminderDataArray = [[NSMutableArray alloc] init];
    }
    
    if (reminderDataArray == nil) {
        reminderDataArray = [[NSMutableArray alloc] init];
    }
    
    if (latestValueDict == nil) {
        latestValueDict = [[NSDictionary alloc] init];
    }
    
    listDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    editListDict = [[NSDictionary alloc] init];
    
    //基本資料
    measureSpec = 1;
    UserAge = -1;
    UserGender = 0;
    UserHeight = 170.0;
    UserWeight = 65.0;
    metric = 0;//0 = KG CM   1=lb
    PULUnit = 0;//0=bpm   1=beats;
    targetSYS = 135;
    targetDIA = 80;
    targetWeight = 60.0;
    targetFat = 9.0;
    userArea = 0;
    showTargetSYS = NO;
    showTargetDIA = YES;
    showTargetWeight = YES;
    showTargetFat = YES;
    
    if (userArea == 0) {
        standerBMI = 23;
    }else{
        standerBMI = 25;
    }
    
    if (UserGender == 0) {
        standerFat = 25;
    }else{
        standerBMI = 31;
    }
}

-(void)saveReminderData:(NSMutableArray *)dataArray{
    
   // NSMutableArray *tempArray = dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        
        for (NSUInteger j = dataArray.count-1; j>0; j--) {
            
            NSMutableDictionary *tempDictA = dataArray[j];
            NSMutableDictionary *tempDictB = dataArray[j-1];
            
            int biggerHour = [[dataArray[j] objectForKey:@"hour"] intValue];
            int smallerHour = [[dataArray[j-1]objectForKey:@"hour"] intValue];
            if (biggerHour < smallerHour) {
                
                [dataArray removeObjectAtIndex:j-1];
                [dataArray insertObject:tempDictA atIndex:j-1];
                
                [dataArray removeObjectAtIndex:j];
                [dataArray insertObject:tempDictB atIndex:j];
                
            }else if (biggerHour == smallerHour) {
                
                int biggerMin = [[dataArray[j] objectForKey:@"min"] intValue];
                int smallerMin = [[dataArray[j-1]objectForKey:@"min"] intValue];
                
                if (biggerMin < smallerMin) {
                    
                    [dataArray removeObjectAtIndex:j-1];
                    [dataArray insertObject:tempDictA atIndex:j-1];
                    
                    [dataArray removeObjectAtIndex:j];
                    [dataArray insertObject:tempDictB atIndex:j];
                }
                
            }
        }
    }
        
    reminderDataArray = dataArray;
    
}

-(NSMutableArray *)getReminderData{
    
    return [reminderDataArray mutableCopy];
    
}

-(void)saveMemberProfile:(NSDictionary *)memberDict{
    
    [memberDataArray addObject:memberDict];
    
}

-(NSMutableArray *)returnMemberProfile{
    
    return memberDataArray;
}

-(void)saveLatestMeasureValue:(NSDictionary *)latestValue{
    latestValueDict = latestValue;
}

-(NSDictionary *)getLatestMeasureValue{
    return latestValueDict;
}

-(void)setListDataArray:(NSMutableArray *)listArray{
    listDataArray = listArray;
}

-(NSMutableArray *)getListData{
    return listDataArray;
}

-(void)setEditListDict:(NSDictionary *)dataDict{
    editListDict = dataDict;
}

-(NSDictionary *)getEditListDict{
    return editListDict;
}



@end

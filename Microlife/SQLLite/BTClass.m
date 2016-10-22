//
//  BTClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BTClass.h"

@implementation BTClass


@synthesize BT_ID,accountID,eventID,bodyTemp,roomTmep,date,BT_PhotoPath,BT_Note, BT_RecordingPath;

+(BTClass*) sharedInstance{
    static BTClass *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        sharedInstance = [[BTClass alloc] initWithOpenDataBase];
    });
    
    return sharedInstance;
}

-(id)initWithOpenDataBase{
    
    self = [super initWithOpenDataBase];
    
    if (self) {
        [self setUp];
    }
    return self;
}


-(void)setUp{
    
}

-(NSMutableArray *)selectAllData{
    
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT BT_ID, accountID, eventID, bodyTemp, roomTmep ,date ,BT_PhotoPath, BT_Note, BT_RecordingPath FROM BTList"];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM BTList WHERE accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:9];//SELECT:指令：幾筆欄位
    
    return DataArray;
}

-(NSMutableArray *)selectTempWithRange:(int)dataRange count:(int)dataCount{

    NSMutableArray* resultArray= [NSMutableArray new];

    NSMutableArray* DataArray = [NSMutableArray new];
    
    //roomTmep 資料庫拼錯
    
    int limitHour = dataRange - dataCount;
    
    NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp,roomTmep, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", \"date\") > strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND strftime(\"%%Y-%%m-%%d %%H\", \"date\") <=strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND accountID = %d ORDER BY date DESC",dataRange,limitHour,[LocalData sharedInstance].accountID];
    
    DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
    
    NSDate *currentDate = [NSDate date];
    
    NSString *latestTime = @"";
    
    float sumBodyTemp = 0;
    float sumRoomTemp = 0;
    
    NSNumber *avgBodyTemp = [NSNumber numberWithFloat:0.0];
    NSNumber *avgRoomTemp = [NSNumber numberWithFloat:0.0];
    
    NSString *originStr = @"";
    
    for (int j=limitHour; j<dataRange; j++) {
        
        NSDate *pastDate = [currentDate dateByAddingTimeInterval:-60.0f*60.0f*j];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd HH:00";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        latestTime = [dateFormatter stringFromDate:pastDate];

        //判斷是有有資料
        if ([[DataArray firstObject] count] != 1) {
            
            for (int i=0; i<DataArray.count; i++) {
                NSString *comparedTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:2]];
                
                comparedTime = [comparedTime substringToIndex:2];
            
                
                sumBodyTemp = [[[DataArray objectAtIndex:i] objectAtIndex:0] floatValue];
                
                NSLog(@"comparedTime = %@",comparedTime);
            }
            
            
            avgBodyTemp = [NSNumber numberWithFloat:sumBodyTemp/DataArray.count];
            avgRoomTemp = [NSNumber numberWithFloat:sumRoomTemp/DataArray.count];
            
        }
        
        
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    avgBodyTemp,@"temp",
                                    avgRoomTemp,@"room",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
        NSLog(@"Temp data resultArray = %@",resultArray);
        
    }
    
    return resultArray;
    
}

-(NSMutableArray *)selectSingleHourTempWithRange:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    //dataRange -= 1;
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp,roomTmep, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", \"date\") = strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND accountID = %d ORDER BY date DESC", dataRange,[LocalData sharedInstance].accountID];
    
    int limitHour = dataRange-1;
    
    NSMutableArray* DataArray = [NSMutableArray new];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp,roomTmep, STRFTIME(\"%%m/%%d %%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", \"date\") > strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND strftime(\"%%Y-%%m-%%d %%H\", \"date\") <=strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND accountID = %d ORDER BY date DESC",dataRange,limitHour,[LocalData sharedInstance].accountID];
    
    
    DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
    
    NSLog(@"limitHour = %d, dataRange = %d",limitHour,dataRange);
    NSLog(@"DataArray = %@",DataArray);
    
    NSString *dateStr = @"";
    
//    NSDate *currentDate = [NSDate date];
//    
//    NSDate *pastDate = [currentDate dateByAddingTimeInterval:-60.0f*60.0f*dataRange];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"HH:mm";
//    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//    
//    dateStr = [dateFormatter stringFromDate:pastDate];
//
    NSNumber *bodyTempNum = [NSNumber numberWithFloat:0.0];
    NSNumber *roomTempNum = [NSNumber numberWithFloat:0.0];
    
    
    for (int i=DataArray.count-1; i>=0; i--) {
        
        if ([[DataArray firstObject] count] != 1) {
            bodyTempNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
            
            roomTempNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] objectAtIndex:1] floatValue]];
            
            dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:2]];
            
            dateStr = [dateStr substringWithRange:NSMakeRange(0, 8)];
            
            dateStr = [NSString stringWithFormat:@"%@:00",dateStr];
        }else{
            break;
        }
        
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    bodyTempNum,@"temp",
                                    roomTempNum,@"room",
                                    dateStr,@"date",nil];
        
        [resultArray addObject:resultDict];
    }

    
    NSLog(@"current day temp resultArray = %@",resultArray);
    
    return resultArray;
}


- (void)updateData{

    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE BTList SET  accountID = \"%d\", eventID = \"%d\", bodyTemp = \"%@\", roomTmep = \"%@\",date = \"%@\",BT_PhotoPath = \"%@\",BT_Note = \"%@\",BT_RecordingPath = \"%@\" WHERE BT_ID = \"%d\""
                         , accountID, eventID, bodyTemp, roomTmep,date,BT_PhotoPath,BT_Note,BT_RecordingPath ,BT_ID];
    
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT INTO BTList( accountID, eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath) VALUES(  \"%d\",\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\");", accountID , eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

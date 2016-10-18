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
    
    NSDate *currentDate = [NSDate date];
    
    int queryCount = 1;
    
    for (int i = 0; i < dataRange ; i++) {
    
        NSMutableArray* DataArray = [NSMutableArray new];
        
        //roomTmep 資料庫拼錯
        
        NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp,roomTmep, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", \"date\") > strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND strftime(\"%%Y-%%m-%%d %%H\", \"date\") <=strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        
        DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
        
        queryCount++;

        NSString *latestTime = @"";
        
        NSDate *pastDate = [currentDate dateByAddingTimeInterval:-60.0f*60.0f*i];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        latestTime = [dateFormatter stringFromDate:pastDate];
        
        float sumBodyTemp = 0;
        float sumRoomTemp = 0;
        
        NSNumber *avgBodyTemp = [NSNumber numberWithFloat:0.0];
        NSNumber *avgRoomTemp = [NSNumber numberWithFloat:0.0];
        
        if ([[DataArray firstObject] count] != 1) {

//            if (i < DataArray.count) {
//                
//                latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:2]];
//            }
            
            //算平均 使用SQL avg() 會閃退
            for (int i=0; i<DataArray.count; i++) {
                sumBodyTemp += [[[DataArray objectAtIndex:i] firstObject] floatValue];
                sumRoomTemp += [[[DataArray objectAtIndex:i] objectAtIndex:1] floatValue];
            }
        }
        
        
        avgBodyTemp = [NSNumber numberWithFloat:sumBodyTemp/DataArray.count];
        avgRoomTemp = [NSNumber numberWithFloat:sumRoomTemp/DataArray.count];
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    avgBodyTemp,@"temp",
                                    avgRoomTemp,@"room",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];

    }

    NSLog(@"Temp data resultArray = %@",resultArray);
    
    return resultArray;
    
}

-(NSMutableArray *)selectSingleHourTempWithRange:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    dataRange -= 1;
    
    NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp,roomTmep, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", \"date\") = strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND accountID = %d ORDER BY date DESC", dataRange,[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [NSMutableArray new];
    
    DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
    
    NSLog(@"Command = %@",Command);
    NSLog(@"DataArray = %@",DataArray);
    
    NSString *dateStr = @"";
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *pastDate = [currentDate dateByAddingTimeInterval:-60.0f*60.0f*dataRange];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    dateStr = [dateFormatter stringFromDate:pastDate];
    
    NSNumber *bodyTempNum = [NSNumber numberWithFloat:0.0];
    NSNumber *roomTempNum = [NSNumber numberWithFloat:0.0];
    
    NSLog(@"dateStr = %@",dateStr);
    
    for (int i=DataArray.count-1; i>=0; i--) {
        
        if ([[DataArray firstObject] count] != 1) {
            bodyTempNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
            
            roomTempNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] objectAtIndex:1] floatValue]];
            
            //dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:2]];
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

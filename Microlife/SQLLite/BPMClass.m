//
//  BPMClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BPMClass.h"

@implementation BPMClass

@synthesize BPM_ID,accountID,SYS,DIA,PUL,PAD,AFIB,SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath;


+(BPMClass*) sharedInstance{
    static BPMClass *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        sharedInstance = [[BPMClass alloc] initWithOpenDataBase];
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
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT BPM_ID,accountID,SYS,DIA,PUL,SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath FROM BPMList"];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM BPMList WHERE accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:13];//SELECT:指令：幾筆欄位
    
    
    return DataArray;
}

-(NSMutableArray *)selectDataForList:(int)dataRange count:(int)dataCount{
    
    NSMutableArray* resultArray = [NSMutableArray new];
    
    int limitDay;
    
    if (dataCount != -1) {
        limitDay = dataRange-dataCount;
    }else{
        dataRange -= 1;
        limitDay = dataRange;
    }
    NSMutableArray* DataArray = [NSMutableArray new];
    
    NSString *dateSelectType;
    
    if (dataCount == 12) {
        dateSelectType = @"month";
    }else{
        dateSelectType = @"day";
    }
    
    NSString *Command = [NSString stringWithFormat:@"SELECT SYS, DIA, PUL,PAD,AFIB,BPM_PhotoPath,BPM_Note,BPM_RecordingPath,STRFTIME(\"%%Y/%%m/%%d %%H:%%M\",\"date\") FROM BPMList WHERE STRFTIME(\"%%Y-%%m-%%d\",\"date\") >= STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d %@\") AND strftime(\"%%Y-%%m-%%d\", \"date\") <=strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\", \"-%d %@\") AND accountID = %d ORDER BY date DESC",dataRange,dateSelectType,limitDay,dateSelectType,[LocalData sharedInstance].accountID];
    
    
    DataArray = [self SELECT:Command Num:9];//SELECT:指令：幾筆欄位
   
    if ([[DataArray firstObject] count] != 1) {
        for (int i=0; i<DataArray.count; i++) {
            
            NSString *SYSStr = [[DataArray objectAtIndex:i] objectAtIndex:0];
            NSString *DIAStr = [[DataArray objectAtIndex:i] objectAtIndex:1];
            NSString *PULStr = [[DataArray objectAtIndex:i] objectAtIndex:2];
            NSString *PADStr = [[DataArray objectAtIndex:i] objectAtIndex:3];
            NSString *AFIBStr = [[DataArray objectAtIndex:i] objectAtIndex:4];
            NSString *photoPath = [[DataArray objectAtIndex:i] objectAtIndex:5];
            NSString *note = [[DataArray objectAtIndex:i] objectAtIndex:6];
            NSString *recordingPath = [[DataArray objectAtIndex:i] objectAtIndex:7];
            NSString *dateStr = [[DataArray objectAtIndex:i] objectAtIndex:8];
            
            NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      SYSStr,@"SYS",
                                      DIAStr,@"DIA",
                                      PULStr,@"PUL",
                                      PADStr,@"PAD",
                                      AFIBStr,@"AFIB",
                                      photoPath,@"photoPath",
                                      note,@"note",
                                      recordingPath,@"recordingPath",
                                      dateStr,@"date",nil];
            
            [resultArray addObject:dataDict];
            
        }
    }
    
    NSLog(@"selectDataForList resultArray = %@",resultArray);

    
    return resultArray;
    
}


-(NSMutableArray *)selectBPWithRange:(int)dataRange count:(int)dataCount{
    
    NSMutableArray* resultArray = [NSMutableArray new];
    
    for (int i = dataRange-1; i >= dataRange-dataCount ; i--) {
        
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command;
        
        //WHERE strftime(\"%%Y-%%m\", \"date\") = strftime(\"%%Y-%%m\", \"now\", \"localtime\",\"-%d month\")
        
        NSString *latestTime = @" ";
        
        NSDate *currentDate = [NSDate date];
        
        if (dataCount == 12) {
            Command = [NSString stringWithFormat:@"SELECT SYS, DIA, STRFTIME(\"%%Y-%%m/%%d\",\"date\") FROM BPMList WHERE STRFTIME(\"%%Y-%%m\",\"date\") = STRFTIME(\"%%Y-%%m\",\"now\", \"localtime\",\"-%d month\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps = [NSDateComponents new];
            comps.month = -i;
            //comps.day   = -1;
            NSDate *pastDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy/MM";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            latestTime = [dateFormatter stringFromDate:pastDate];
            
            latestTime = [NSString stringWithFormat:@"%@",pastDate];
            latestTime = [latestTime substringToIndex:7];
            
        }else{
            Command = [NSString stringWithFormat:@"SELECT SYS, DIA, STRFTIME(\"%%Y/%%m/%%d\",\"date\") FROM BPMList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
            
            NSDate *pastDate = [currentDate dateByAddingTimeInterval:-24.0f*60.0f*60.0f*i];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM/dd";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            latestTime = [dateFormatter stringFromDate:pastDate];
        }
        
        DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
        
        int SYSSum = 0;
        int DIASum = 0;
        
        NSNumber *SYSValue = [NSNumber numberWithInt:0];
        NSNumber *DIAValue = [NSNumber numberWithInt:0];
        
        if ([[DataArray firstObject] count] != 1) {
            
            //            if (i < DataArray.count) {
            //
            //                latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
            //
            //                NSLog(@"DataArray = %@",DataArray);
            //                NSLog(@"latestTime = %@",latestTime);
            //
            //            }
            
            for (int j=0; j<DataArray.count; j++) {
                SYSSum += [[[DataArray objectAtIndex:j] firstObject] intValue];
                DIASum += [[[DataArray objectAtIndex:j] objectAtIndex:1] intValue];
            }
            
            SYSValue = [NSNumber numberWithFloat:SYSSum/DataArray.count];
            DIAValue = [NSNumber numberWithFloat:DIASum/DataArray.count];
        }
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:SYSValue,@"SYS",
                                    DIAValue,@"DIA",
                                    latestTime,@"date",nil];
        
        
        [resultArray addObject:resultDict];
        
    }
    
    NSLog(@"BP Data ==>>>> resultArray = %@",resultArray);
    
    return resultArray;
    
}

-(NSMutableArray *)selectPULWithRange:(int)dataRange count:(int)dataCount{
    
    NSMutableArray* resultArray = [NSMutableArray new];
    
    for (int i = dataRange-1; i >= dataRange-dataCount ; i--) {
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command;
        
        NSString *latestTime = @"";
        
        NSDate *currentDate = [NSDate date];
        
        if (dataRange == 12) {
            
            Command = [NSString stringWithFormat:@"SELECT PUL, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM BPMList WHERE STRFTIME(\"%%Y-%%m\",\"date\") = STRFTIME(\"%%Y-%%m\",\"now\", \"localtime\",\"-%d month\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps = [NSDateComponents new];
            comps.month = -i;
            //comps.day   = -1;
            NSDate *pastDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            latestTime = [dateFormatter stringFromDate:pastDate];
            
            latestTime = [NSString stringWithFormat:@"%@",pastDate];
            latestTime = [latestTime substringToIndex:7];
            
        }else{
            Command = [NSString stringWithFormat:@"SELECT PUL, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM BPMList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
            NSDate *pastDate = [currentDate dateByAddingTimeInterval:-24.0f*60.0f*60.0f*i];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            latestTime = [dateFormatter stringFromDate:pastDate];
        }
        
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        float PULSum = 0;
        
        NSNumber *PULValue = [NSNumber numberWithFloat:0.0];
        
        if ([[DataArray firstObject] count] != 1) {
            
//            if (i < DataArray.count) {
//                
//                latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
//                
//                NSLog(@"DataArray = %@",DataArray);
//                NSLog(@"latestTime = %@",latestTime);
//                
//            }
            
            for (int j=0; j<DataArray.count; j++) {
                PULSum += [[[DataArray objectAtIndex:j] firstObject] intValue];
            }
        }
        
        PULValue = [NSNumber numberWithFloat:PULSum/DataArray.count];
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    PULValue,@"PUL",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    NSLog(@"resultArray = %@",resultArray);
    
    return resultArray;
    
}

-(NSMutableArray *)selectSingleDayBPWithRange:(int)dataRange{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    dataRange -= 1;
    
    NSString *Command = [NSString stringWithFormat:@"SELECT SYS, DIA , STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM BPMList WHERE strftime(\"%%Y-%%m-%%d\", \"date\") = strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\", \"-%d day\") AND accountID = %d ORDER BY date DESC",dataRange,[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [NSMutableArray new];
    
    DataArray = [self SELECT:Command Num:3];//SELECT:指令：幾筆欄位
    
    NSString *dateStr = @" ";
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *pastDate = [currentDate dateByAddingTimeInterval:-24.0f*60.0f*60.0f*dataRange];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    dateStr = [dateFormatter stringFromDate:pastDate];
    
    for (int i=DataArray.count-1; i>=0; i--) {
        
        NSNumber *SYSNum = [NSNumber numberWithFloat:0.0];
        NSNumber *DIANum = [NSNumber numberWithFloat:0.0];
        
        if ([[DataArray firstObject] count] != 1) {
            SYSNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
            DIANum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] objectAtIndex:1] floatValue]];
            //dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:2]];
        }else{
            break;
        }
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    SYSNum,@"SYS",
                                    DIANum,@"DIA",
                                    dateStr,@"date",nil];
        
        [resultArray addObject:resultDict];
    }
    
    NSLog(@"BP currentDay resultArray = %@",resultArray);
    
    return resultArray;
    
}


-(NSMutableArray *)selectSingleDayPULWithRange:(int)dataRange{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT PUL, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM BPMList WHERE strftime(\"%%Y-%%m-%%d\", \"date\") = strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\") AND accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [NSMutableArray new];
    
    DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
    
    NSString *dateStr = @"";
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *pastDate = [currentDate dateByAddingTimeInterval:-24.0f*60.0f*60.0f*dataRange];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    dateStr = [dateFormatter stringFromDate:pastDate];
    
    for (int i=DataArray.count-1; i>=0; i--) {
        
        NSNumber *PULNum = [NSNumber numberWithFloat:0.0];
        
        if ([[DataArray firstObject] count] != 1) {
            PULNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
            //dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            break;
        }
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    PULNum,@"PUL",
                                    dateStr,@"date",nil];
        
        [resultArray addObject:resultDict];
    }
    
    NSLog(@"currentDay PUL resultArray = %@",resultArray);
    
    return resultArray;
    
}


- (void)updateData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE BPMList SET accountID = \"%d\",SYS = \"%d\", DIA = \"%d\", PUL = \"%d\", PAD = \"%d\",AFIB = \"%d\",SYS_Unit = \"%d\" , PUL_Unit = \"%d\",date = \"%@\",BPM_PhotoPath = \"%@\", BPM_Note = \"%@\",BPM_RecordingPath = \"%@\" WHERE BPM_ID = \"%d\""
                        , accountID, SYS, DIA, PUL, PAD, AFIB, SYS_Unit, PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath, BPM_ID];
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO BPMList( accountID, SYS, DIA, PUL, PAD ,AFIB ,SYS_Unit, PUL_Unit, date, BPM_PhotoPath, BPM_Note, BPM_RecordingPath) VALUES( \"%d\",\"%d\", \"%d\",\"%d\", \"%d\", \"%d\", \"%d\", \"%d\",\"%@\", \"%@\" ,\"%@\",\"%@\");" ,accountID ,SYS, DIA, PUL, PAD, AFIB, SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

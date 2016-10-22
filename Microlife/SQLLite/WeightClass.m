//
//  WeightClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "WeightClass.h"

@implementation WeightClass

@synthesize weightID,accountID,weight,weightUnit,BMI,bodyFat,water,skeleton,muscle,BMR,organFat,date,weight_PhotoPath,weight_Note,weight_RecordingPath;

+(WeightClass*) sharedInstance{
    static WeightClass *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        sharedInstance = [[WeightClass alloc] initWithOpenDataBase];
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

-(NSMutableArray *)selectAllDataAtRange:(int)dataRange count:(int)dataCount{
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath FROM WeightList"];

    //NSString *Command = [NSString stringWithFormat:@"SELECT * FROM WeightList WHERE accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    for (int i = dataRange-1; i >= dataRange-dataCount ; i--) {
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command;
        
        if (dataRange == 12) {
            Command = [NSString stringWithFormat:@"SELECT * FROM WeightList WHERE STRFTIME(\"%%Y-%%m\",\"date\") = STRFTIME(\"%%Y-%%m\",\"now\", \"localtime\",\"-%d month\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        }else{
            Command = [NSString stringWithFormat:@"SELECT * FROM WeightList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        }
        
        DataArray = [self SELECT:Command Num:15];//SELECT:指令：幾筆欄位
    
        NSLog(@"DataArray = %@",DataArray);
        
        //weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath
        
        if ([[DataArray firstObject] count] != 1) {
            //NSLog(@"DataArray = %@",DataArray);
            
            for (int i=0; i<DataArray.count; i++) {
                NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          [[DataArray objectAtIndex:i] objectAtIndex:0],@"weightID",
                                          [[DataArray objectAtIndex:i] objectAtIndex:1],@"accountID",
                                          [[DataArray objectAtIndex:i] objectAtIndex:2],@"weight",
                                          [[DataArray objectAtIndex:i] objectAtIndex:3],@"weightUnit",
                                          [[DataArray objectAtIndex:i] objectAtIndex:4],@"BMI",
                                          [[DataArray objectAtIndex:i] objectAtIndex:5],@"bodyFat",
                                          [[DataArray objectAtIndex:i] objectAtIndex:6],@"water",
                                          [[DataArray objectAtIndex:i] objectAtIndex:7],@"skeleton",
                                          [[DataArray objectAtIndex:i] objectAtIndex:8],@"muscle",
                                          [[DataArray objectAtIndex:i] objectAtIndex:9],@"BMR",
                                          [[DataArray objectAtIndex:i] objectAtIndex:10],@"organFat",
                                          [[DataArray objectAtIndex:i] objectAtIndex:11],@"date",
                                          [[DataArray objectAtIndex:i] objectAtIndex:12],@"weight_PhotoPath",
                                          [[DataArray objectAtIndex:i] objectAtIndex:13],@"weight_Note",
                                          [[DataArray objectAtIndex:i] objectAtIndex:14],@"weight_RecordingPath",nil];
                
                [resultArray addObject:dataDict];
            }
        }
    }
    
    return resultArray;
}

//-(NSMutableArray *)selectDataForOverView:(NSString *)column :(int)dataRange{
//    
//    NSMutableArray* resultArray= [NSMutableArray new];
//    
//    NSMutableArray* DataArray = [NSMutableArray new];
//    
//    NSString *Command = [NSString stringWithFormat:@"SELECT %@, STRFTIME(\"%%m/%%d %%H:%%M\",\"date\") FROM WeightList WHERE accountID = %d ORDER BY date DESC LIMIT %d",column, [LocalData sharedInstance].accountID,dataRange];
//    
//    DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
//    
//    if ([[DataArray firstObject] count] != 1) {
//        for (int i=DataArray.count-1; i>=0; i--) {
//            
//            NSNumber *listNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
//            
//            NSString *dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
//            
//            NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                        listNum,column,
//                                        dateStr,@"date",nil];
//            
//            [resultArray addObject:resultDict];
//        }
//    }
//    
//    
//    return resultArray;
//}

-(NSMutableArray *)selectData:(NSString *)column range:(int)dataRange count:(int)dataCount{
    
    NSMutableArray* resultArray = [NSMutableArray new];
    
    for (int i = dataRange-1; i >= dataRange-dataCount ; i--) {
        
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command;
        
        //WHERE strftime(\"%%Y-%%m\", \"date\") = strftime(\"%%Y-%%m\", \"now\", \"localtime\",\"-%d month\")
        
        NSString *latestTime = @" ";
        
        NSDate *currentDate = [NSDate date];
        
        if (dataRange == 12) {
            Command = [NSString stringWithFormat:@"SELECT %@, STRFTIME(\"%%Y-%%m-%%d\") FROM WeightList WHERE STRFTIME(\"%%Y-%%m\",\"date\") = STRFTIME(\"%%Y-%%m\",\"now\", \"localtime\",\"-%d month\") AND accountID = %d ORDER BY date DESC",column,i,[LocalData sharedInstance].accountID];
            
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
           Command = [NSString stringWithFormat:@"SELECT %@, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",column,i,[LocalData sharedInstance].accountID];
            
            NSDate *pastDate = [currentDate dateByAddingTimeInterval:-24.0f*60.0f*60.0f*i];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM-dd";
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            latestTime = [dateFormatter stringFromDate:pastDate];
        }
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        float sum = 0;
        
        NSNumber *avgValue = [NSNumber numberWithFloat:0.0];
        
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
                sum += [[[DataArray objectAtIndex:j] firstObject] floatValue];
            }
        }
        
        avgValue = [NSNumber numberWithFloat:sum/DataArray.count];
    
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    avgValue,column,
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    NSLog(@"%@ Data ==>>>> resultArray = %@",column ,resultArray);
    
    return resultArray;
    
}

-(NSMutableArray *)selectSingleDay:(NSString *)column range:(int)dataRange{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    dataRange -= 1;
    
    NSString *Command = [NSString stringWithFormat:@"SELECT %@, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE strftime(\"%%Y-%%m-%%d\", \"date\") = strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\", \"-%d day\") AND accountID = %d ORDER BY date DESC",column, dataRange,[LocalData sharedInstance].accountID];
    
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
        
        NSNumber *weightNum = [NSNumber numberWithFloat:0.0];
        
        if ([[DataArray firstObject] count] != 1) {
            weightNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
            //dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            break;
        }
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    weightNum,column,
                                    dateStr,@"date",nil];
        
        [resultArray addObject:resultDict];
    }
    
    NSLog(@"currentDay weight resultArray = %@",resultArray);
    
    return resultArray;
    
}

- (void)updateData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE WeightList SET, accountID = \"%d\", weight = \"%d\", weightUnit = \"%d\", BMI = \"%d\" ,body_fat = \"%d\",water = \"%d\" , skeleton = \"%d\",muscle = \"%d\",BMR = \"%d\",organ_fat = \"%d\",date = \"%@\",weight_PhotoPath = \"%@\", weight_Note = \"%@\",weight_RecordingPath = \"%@\" WHERE weightID = \"%d\" "
                        , accountID, weight, weightUnit, BMI, bodyFat, water,skeleton,muscle,BMR,organFat,date,weight_PhotoPath,weight_Note,weight_RecordingPath,weightID];
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO WeightList( weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath) VALUES( \"%d\", \"%d\", \"%d\",\"%d\", \"%d\",\"%d\", \"%d\",\"%d\", \"%d\" ,\"%d\",\"%d\",\"%@\",\"%@\",\"%@\",\"%@\");",weightID , accountID, weight, weightUnit, BMI, bodyFat, water,skeleton,muscle,BMR,organFat,date,weight_PhotoPath,weight_Note,weight_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

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

-(NSMutableArray *)selectAllData{
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath FROM WeightList"];

    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM WeightList WHERE accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:15];//SELECT:指令：幾筆欄位
    
    
    return DataArray;
}

-(NSMutableArray *)selectWeight:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    for (int i = dataRange; i > 0 ; i--) {
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command = [NSString stringWithFormat:@"SELECT weight, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        NSString *latestTime = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
        
        if (![latestTime isEqualToString:@"Can not find data!"]) {
            latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            latestTime = @"0";
        }
        
        float sum = 0;
        
        NSNumber *avgWeight = [NSNumber numberWithFloat:0.0];
        
        for (int i=0; i<DataArray.count; i++) {
            sum += [[[DataArray objectAtIndex:i] firstObject] intValue];
        }
        
        avgWeight = [NSNumber numberWithFloat:sum/DataArray.count];
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:avgWeight,@"weight",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    return resultArray;
    
}

-(NSMutableArray *)selectBMI:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    for (int i = dataRange; i > 0 ; i--) {
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command = [NSString stringWithFormat:@"SELECT BMI, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        NSString *latestTime = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
        
        if (![latestTime isEqualToString:@"Can not find data!"]) {
            latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            latestTime = @"0";
        }
        
        float sum = 0;
        
        NSNumber *avgBMI = [NSNumber numberWithFloat:0.0];
        
        for (int i=0; i<DataArray.count; i++) {
            sum += [[[DataArray objectAtIndex:i] firstObject] intValue];
        }
        
        avgBMI = [NSNumber numberWithFloat:sum/DataArray.count];
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:avgBMI,@"BMI",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    return resultArray;
    
}

-(NSMutableArray *)selectBodyFat:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    for (int i = dataRange; i > 0 ; i--) {
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command = [NSString stringWithFormat:@"SELECT bodyFat, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE strftime(\"%%Y-%%m-%%d\", \"date\") = strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\", \"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        
        
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        NSString *latestTime = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
        
        if (![latestTime isEqualToString:@"Can not find data!"]) {
            latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            latestTime = @"0";
        }
        
        float sum = 0;
        
        NSNumber *avgFat = [NSNumber numberWithFloat:0.0];
        
        for (int i=0; i<DataArray.count; i++) {
            sum += [[[DataArray objectAtIndex:i] firstObject] intValue];
        }
        
        avgFat = [NSNumber numberWithFloat:sum/DataArray.count];
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:avgFat,@"bodyFat",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    return resultArray;
    
}

-(NSMutableArray *)selectCurrentDay{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT weight, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM WeightList WHERE strftime(\"%%Y-%%m-%%d\", \"date\") = strftime(\"%%Y-%%m-%%d\", \"now\", \"localtime\") AND accountID = %d ORDER BY date DESC",[LocalData sharedInstance].accountID];
    
    NSMutableArray* DataArray = [NSMutableArray new];
    
    DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
    
    for (int i=0; i<DataArray.count; i++) {
        
        NSNumber *weightNum = [NSNumber numberWithFloat:[[[DataArray objectAtIndex:i] firstObject] floatValue]];
        
        if (![dateStr isEqualToString:@"Can not find data!"]) {
            dateStr = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            dateStr = @"0";
        }
        
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    weightNum,@"weight",
                                    dateStr,@"date",nil];
        
        [resultArray addObject:resultDict];
    }
    
    NSLog(@"resultArray = %@",resultArray);
    
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

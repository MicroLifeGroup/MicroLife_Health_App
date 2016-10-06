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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath FROM WeightList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:15];//SELECT:指令：幾筆欄位
    return DataArray;
}

- (void)updateData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE WeightList SET weightID = \"%d\", accountID = \"%d\", weight = \"%d\", weightUnit = \"%d\", BMI = \"%d\" ,body_fat = \"%d\",water = \"%d\" , skeleton = \"%d\",muscle = \"%d\",BMR = \"%d\",organ_fat = \"%d\",date = \"%@\",weight_PhotoPath = \"%@\", weight_Note = \"%@\",weight_RecordingPath = \"%@\""
                        ,weightID , accountID, weight, weightUnit, BMI, bodyFat, water,skeleton,muscle,BMR,organFat,date,weight_PhotoPath,weight_Note,weight_RecordingPath];
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO WeightList( weightID, accountID, weight, weightUnit, BMI, bodyFat, water, skeleton, muscle, BMR, organFat, date, weight_PhotoPath, weight_Note, weight_RecordingPath) VALUES( \"%d\", \"%d\", \"%d\",\"%d\", \"%d\",\"%d\", \"%d\",\"%d\", \"%d\" ,\"%d\",\"%d\",\"%@\",\"%@\",\"%@\",\"%@\");",weightID , accountID, weight, weightUnit, BMI, bodyFat, water,skeleton,muscle,BMR,organFat,date,weight_PhotoPath,weight_Note,weight_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

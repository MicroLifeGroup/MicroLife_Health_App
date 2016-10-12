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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM WeightList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:15];//SELECT:指令：幾筆欄位
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (int i=0; i<DataArray.count; i++) {
        
        NSMutableArray *resultArray = [DataArray objectAtIndex:i];
        
        if(![[resultArray objectAtIndex:0] isEqualToString:@"Can not find data!"]){
            NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:[resultArray objectAtIndex:0],@"eventID",
                                      [resultArray objectAtIndex:1],@"accountID",
                                      [resultArray objectAtIndex:2],@"weight",
                                      [resultArray objectAtIndex:3],@"weightUnit",
                                      [resultArray objectAtIndex:4],@"BMI",
                                      [resultArray objectAtIndex:5],@"bodyFat",
                                      [resultArray objectAtIndex:6],@"water",
                                      [resultArray objectAtIndex:7],@"skeleton",
                                      [resultArray objectAtIndex:8],@"muscle",
                                      [resultArray objectAtIndex:9],@"BMR",
                                      [resultArray objectAtIndex:10],@"organFat",
                                      [resultArray objectAtIndex:11],@"date",
                                      [resultArray objectAtIndex:12],@"weight_PhotoPath",
                                      [resultArray objectAtIndex:13],@"weight_Note",
                                      [resultArray objectAtIndex:14],@"weight_RecordingPath",
                                      
                                      nil];
            
            [returnArray addObject:dataDict];
        }
        
    }
    
    
    return returnArray;
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

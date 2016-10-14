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

-(NSMutableArray *)selectTemp:(int)dataRange{

    NSMutableArray* resultArray= [NSMutableArray new];
    
    NSLog(@"dataRange = %d",dataRange);
    
    for (int i = dataRange; i > 0 ; i--) {
    
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", date) > strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND strftime(\"%%Y-%%m-%%d %%H\", \"date\") <=strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        float sumTemp = 0;
        
        NSNumber *avgTemp = [NSNumber numberWithFloat:0.0];
        
        NSString *latestTime = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
        //NSLog(@"latestTime =%@",latestTime);
        
        if (![latestTime isEqualToString:@"Can not find data!"]) {
            if (i < DataArray.count) {
                latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
            }else{
                latestTime = @"0";
            }

        }else{
            latestTime = @"0";
        }
        
        for (int i=0; i<DataArray.count; i++) {
            sumTemp += [[[DataArray objectAtIndex:i] firstObject] intValue];
        }
        
        if (i < DataArray.count) {
            avgTemp = [NSNumber numberWithFloat:sumTemp/DataArray.count];
        }else{
            avgTemp = [NSNumber numberWithFloat:0.0];
        }
        
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:avgTemp,@"temp",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];

    }

    NSLog(@"resultArray = %@",resultArray);
    
    return resultArray;
    
//    NSString *Command = [NSString stringWithFormat:@"SELECT bodyTemp, STRFTIME(\"%%H:%%M\",\"date\") FROM BTList WHERE strftime(\"%%Y-%%m-%%d %%H\", date) > strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\", \"-%d hour\") AND strftime(\"%%Y-%%m-%%d %%H\", \"date\") <=strftime(\"%%Y-%%m-%%d %%H\", \"now\", \"localtime\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accountID];
}


- (void)updateData{

    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE BTList SET  accountID = \"%d\", eventID = \"%d\", bodyTemp = \"%@\", roomTmep = \"%@\",date = \"%@\",BT_PhotoPath = \"%@\",BT_Note = \"%@\",BT_RecordingPath = \"%@\" WHERE BT_ID = \"%d\""
                         , accountID, eventID, bodyTemp, roomTmep,date,BT_PhotoPath,BT_Note,BT_RecordingPath ,BT_ID];
    
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO BTList( accountID, eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath) VALUES(  \"%d\",\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\");", accountID , eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

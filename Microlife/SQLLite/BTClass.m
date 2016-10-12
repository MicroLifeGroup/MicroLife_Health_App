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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM BTList ORDER BY date DESC"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:9];//SELECT:指令：幾筆欄位
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (int i=0; i<DataArray.count; i++) {
        
        NSMutableArray *resultArray = [DataArray objectAtIndex:i];

        if(![[resultArray objectAtIndex:0] isEqualToString:@"Can not find data!"]){
            NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:[resultArray objectAtIndex:0],@"BT_ID",
                                      [resultArray objectAtIndex:1],@"accountID",
                                      [resultArray objectAtIndex:2],@"eventID",
                                      [resultArray objectAtIndex:3],@"bodyTemp",
                                      [resultArray objectAtIndex:4],@"roomTmep",
                                      [resultArray objectAtIndex:5],@"date",
                                      [resultArray objectAtIndex:6],@"BT_PhotoPath",
                                      [resultArray objectAtIndex:7],@"BT_Note",
                                      [resultArray objectAtIndex:8],@"BT_RecordingPath",nil];
            
            [returnArray addObject:dataDict];
        }
    }

    
    return returnArray;
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

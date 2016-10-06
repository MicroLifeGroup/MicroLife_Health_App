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
    
    
    NSString *Command = [NSString stringWithFormat:@"SELECT BT_ID, accountID, eventID, bodyTemp, roomTmep ,date ,BT_PhotoPath, BT_Note, BT_RecordingPath FROM BTList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:5];//SELECT:指令：幾筆欄位
    return DataArray;
}

- (void)updateData{

    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE BTList SET BT_ID = \"%d\", accountID = \"%d\", eventID = \"%d\", bodyTemp = \"%@\", roomTmep = \"%@\",date = \"%@\",BT_PhotoPath = \"%@\",BT_Note = \"%@\",BT_RecordingPath = \"%@\""
                        ,BT_ID , accountID, eventID, bodyTemp, roomTmep,date,BT_PhotoPath,BT_Note,BT_RecordingPath];
    
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO BTList( BT_ID, accountID, eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath) VALUES( \"%d\", \"%d\",\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\");",BT_ID, accountID , eventID, bodyTemp, roomTmep, date, BT_PhotoPath, BT_Note, BT_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

//
//  EventClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EventClass.h"

@implementation EventClass

@synthesize eventID,accountID,eventTime,type,event;

+(EventClass*) sharedInstance{
    static EventClass *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        sharedInstance = [[EventClass alloc] initWithOpenDataBase];
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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT eventID, accountID, event, type, eventTime FROM EventList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:5];//SELECT:指令：幾筆欄位
    return DataArray;
}

- (void)updateData{

    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE EventList SET eventID = \"%d\", accountID = \"%d\", event = \"%@\", type = \"%@\", eventTime = \"%@\""
                        ,eventID , accountID, type, event, eventTime];
    
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO EventList( eventID, accountID, event, type, eventTime) VALUES( \"%d\", \"%d\",\"%@\", \"%@\", \"%@\");",eventID, accountID , event, type, eventTime];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

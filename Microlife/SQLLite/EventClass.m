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
    
    //NSString *Command = [NSString stringWithFormat:@"SELECT eventID, accountID, event, type, eventTime FROM EventList"];
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM EventList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:5];//SELECT:指令：幾筆欄位
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (int i=0; i<DataArray.count; i++) {
        
        NSMutableArray *resultArray = [DataArray objectAtIndex:i];
        
        if(![[resultArray objectAtIndex:0] isEqualToString:@"Can not find data!"]){
            NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:[resultArray objectAtIndex:0],@"eventID",
                                      [resultArray objectAtIndex:1],@"accountID",
                                      [resultArray objectAtIndex:2],@"event",
                                      [resultArray objectAtIndex:3],@"type",
                                      [resultArray objectAtIndex:4],@"eventTime",
                                      nil];
            
            [returnArray addObject:dataDict];
        }
        
    }
    
    
    return returnArray;

}

- (void)updateData{

    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE EventList SET  accountID = \"%d\", event = \"%@\", type = \"%@\", eventTime = \"%@\" WHERE eventID = \"%d\""
                         , accountID, type, event, eventTime ,eventID];
    
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO EventList( accountID, event, type, eventTime) VALUES(  \"%d\",\"%@\", \"%@\", \"%@\");", accountID , event, type, eventTime];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM BPMList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:13];//SELECT:指令：幾筆欄位
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (int i=0; i<DataArray.count; i++) {
        
        NSMutableArray *resultArray = [DataArray objectAtIndex:i];
        
        if(![[resultArray objectAtIndex:0] isEqualToString:@"Can not find data!"]){
            NSDictionary *dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:[resultArray objectAtIndex:0],@"BPM_ID",
                                      [resultArray objectAtIndex:1],@"accountID",
                                      [resultArray objectAtIndex:2],@"SYS",
                                      [resultArray objectAtIndex:3],@"DIA",
                                      [resultArray objectAtIndex:4],@"PUL",
                                      [resultArray objectAtIndex:5],@"PAD",
                                      [resultArray objectAtIndex:6],@"AFIB",
                                      [resultArray objectAtIndex:7],@"SYS_Unit",
                                      [resultArray objectAtIndex:8],@"PUL_Unit",
                                      [resultArray objectAtIndex:9],@"date",
                                      [resultArray objectAtIndex:10],@"BPM_PhotoPath",
                                      [resultArray objectAtIndex:11],@"BPM_Note",
                                      [resultArray objectAtIndex:12],@"BPM_RecordingPath",
                                      nil];
            
            [returnArray addObject:dataDict];
        }
    
    }
    
    
    return returnArray;
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

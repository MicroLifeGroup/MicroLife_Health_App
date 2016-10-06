//
//  BPMClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BPMClass.h"

@implementation BPMClass

@synthesize BPM_ID,accountID,SYS,DIA,PUL,SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath;


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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT BPM_ID,accountID,SYS,DIA,PUL,SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath FROM BPMList"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:11];//SELECT:指令：幾筆欄位
    return DataArray;
}

- (void)updateData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"UPDATE BPMList SET BPM_ID = \"%d\", accountID = \"%d\",SYS = \"%d\", DIA = \"%d\", PUL = \"%d\", SYS_Unit = \"%d\" , PUL_Unit = \"%d\",date = \"%@\",BPM_PhotoPath = \"%@\", BPM_Note = \"%@\",BPM_RecordingPath = \"%@\""
                        , BPM_ID, accountID, SYS, DIA, PUL, SYS_Unit, PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath];
    
    [self COLUMN_UPDATE:SQLStr];
    
}

-(void)insertData{
    
    NSString *SQLStr = [NSString stringWithFormat:@"INSERT OR REPLACE INTO BPMList( BPM_ID, accountID, SYS, DIA, PUL, SYS_Unit, PUL_Unit, date, BPM_PhotoPath, BPM_Note, BPM_RecordingPath) VALUES( \"%d\", \"%d\",\"%d\", \"%d\",\"%d\", \"%d\", \"%d\",\"%@\", \"%@\" ,\"%@\",\"%@\");",BPM_ID ,accountID ,SYS, DIA, PUL, SYS_Unit,PUL_Unit,date,BPM_PhotoPath,BPM_Note,BPM_RecordingPath];
    
    [self COLUMN_INSERT:SQLStr];
}

@end

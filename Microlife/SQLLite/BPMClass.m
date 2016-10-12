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
    
    NSString *Command = [NSString stringWithFormat:@"SELECT * FROM BPMList ORDER BY date DESC"];
    
    NSMutableArray* DataArray = [self SELECT:Command Num:13];//SELECT:指令：幾筆欄位
    
    
    return DataArray;
}

-(NSMutableArray *)selectPUL:(int)dataRange{
    
    NSMutableArray* resultArray= [NSMutableArray new];
    
    for (int i = dataRange; i > 0 ; i--) {
        
        NSLog(@"i=%d",i);
        
        NSMutableArray* DataArray = [NSMutableArray new];
        
        NSString *Command = [NSString stringWithFormat:@"SELECT PUL, STRFTIME(\"%%Y-%%m-%%d\",\"date\") FROM BPMList WHERE DATE(date) = STRFTIME(\"%%Y-%%m-%%d\",\"now\", \"localtime\",\"-%d day\") AND accountID = %d ORDER BY date DESC",i,[LocalData sharedInstance].accontID];
        
        DataArray = [self SELECT:Command Num:2];//SELECT:指令：幾筆欄位
        
        NSString *latestTime = [NSString stringWithFormat:@"%@",[[DataArray firstObject] firstObject]];
        
        if (![latestTime isEqualToString:@"Can not find data!"]) {
            latestTime = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:i] objectAtIndex:1]];
        }else{
            latestTime = @"0";
        }
        
        float sum = 0;
        
        NSNumber *avgPUL = [NSNumber numberWithFloat:0.0];
        
        for (int i=0; i<DataArray.count; i++) {
            sum += [[[DataArray objectAtIndex:i] firstObject] intValue];
        }
        
        avgPUL = [NSNumber numberWithFloat:sum/DataArray.count];
        
        NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:avgPUL,@"PUL",
                                    latestTime,@"date",nil];
        
        [resultArray addObject:resultDict];
        
    }
    
    return resultArray;
    
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

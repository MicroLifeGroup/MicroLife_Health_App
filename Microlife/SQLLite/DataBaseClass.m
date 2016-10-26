//
//  DataBaseClass.m
//  DataBase
//
//  Created by Kimi on 12/9/6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseClass.h"


@implementation DataBaseClass

- (id)initWithOpenDataBase{
    
    if( self = [super init])
	{
        
        BOOL ExistDB = [self OpenOrCreateDB:@"MicrolifeDB"];
        if ( ExistDB == 0 ) //DB不存在
        {
            
            [self CREATE_BPMList];      //創建血壓資料
            
            [self CREATE_WeightList];   //創建體重體脂資料
            
            [self CREATE_EventList];    //創建溫度計資料
            
            [self CREATE_BTList];       //創建藍芽資料
                
        }
	}
	return self;

}

//= 創建資料表 ========================================================================================================================
-(void)CREATE_ProfileList{
    
    
    /*
     @property BOOL showTargetSYS;
     @property BOOL showTargetDIA;
     @property BOOL showTargetWeight;
     @property BOOL showTargetFat;
     @property int accountID;
     @property int UserGender; //0 = man 1=women
     @property float UserHeight;
     @property float UserWeight;
     @property int metric;//0 = KG CM   1=lb
     @property int PULUnit;//0=   1=beats;
     @property int BPUnit;//0=bpm   1=kpa;
     birthday;
     */
    
    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS ProfileList( profileID INTEGER NULL PRIMARY KEY AUTOINCREMENT, accountID INTEGER, userBirthday TEXT, userGender INTEGER, UserHeight INTEGER, userWeight INTEGER, metric INTEGER, PULUnit INTEGER, BPUnit INTEGER,showTargetSYS INTEGER, showTargetDIA INTEGER, showTargetWeight INTEGER, showTargetFat INTEGER);";
    //建立資料表
    [self CREATE_TABLE:SQLStr];
    
}


-(void)CREATE_BPMList{
    
    //CREATE TABLE IF NOT EXISTS 資料表名稱( 欄位名稱1 數據型態 鍵值, 欄位名稱2 數據型態 鍵值,...)
    /* -數據型態-----------------------------------------------------------------
     NULL:該值是一個NULL值
     INTEGER:該值是一個有正負的整數，由數據的大小決定存儲為1,2,3,4,6或8 bytes
     REAL:該值是一個浮點值，作為一個8 bytes浮點數存儲。
     TEXT:該值是一個文本字符串，使用（UTF-8，UTF-16BE或UTF-16LE）編碼存儲
     BLOB:存儲自定義的數據類型
     ------------------------------------------------------------------ */
    
    //    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS SYSTEM( VerID INTEGER PRIMARY KEY, OPENDAY TEXT, TIMEOUT INT, NOWPAGE INTEGER, NOWID INTEGER, PURCHASE TEXT,ATT1 TEXT,ATT2 TEXT,ATT3 TEXT,ATT4 TEXT,ATT5 TEXT);";
    
    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS BPMList( BPM_ID INTEGER NULL PRIMARY KEY AUTOINCREMENT, accountID INTEGER, userID INTEGER ,SYS INTEGER, DIA INTEGER, PUL INTEGER, PAD INTEGER, AFIB INTEGER, MAM INTEGER,  date TEXT, BPM_PhotoPath TEXT, BPM_Note TEXT, BPM_RecordingPath TEXT);";
    //建立資料表
    [self CREATE_TABLE:SQLStr];
    
}

-(void)CREATE_WeightList{
    
    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS WeightList( weightID INTEGER NULL PRIMARY KEY AUTOINCREMENT, accountID INTEGER,weight INTEGER, BMI INTEGER, bodyFat INTEGER, water INTEGER, skeleton INTEGER, muscle INTEGER, BMR INTEGER, organFat INTEGER, date TEXT, weight_PhotoPath TEXT,  weight_Note TEXT, weight_RecordingPath TEXT);";
    //建立資料表
    [self CREATE_TABLE:SQLStr];
    
}

-(void)CREATE_EventList{
    
    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS EventList( eventID INTEGER NULL PRIMARY KEY AUTOINCREMENT, accountID INTEGER,event TEXT, type TEXT, eventTime TEXT);";
    //建立資料表
    [self CREATE_TABLE:SQLStr];
    
}

-(void)CREATE_BTList{
    
    NSString *SQLStr = @"CREATE TABLE IF NOT EXISTS BTList( BT_ID INTEGER PRIMARY KEY AUTOINCREMENT , accountID INTEGER, eventID INTEGER, bodyTemp TEXT, roomTmep TEXT, date TEXT, BT_PhotoPath TEXT, BT_Note TEXT, BT_RecordingPath TEXT);";
    //建立資料表
    [self CREATE_TABLE:SQLStr];
    
}

//= 創建資料表END

//= 寫入資料表END ===================================================================================================================

- (NSString *)ArrayToString:(NSMutableArray *)Array{
    NSString *Str = @"";
    
    for (int i = 0; i < Array.count; i++) 
    {
        if ( i == 0 ) 
            Str = [NSString stringWithFormat:@"%@",[Array objectAtIndex:i]];
        else
            Str = [NSString stringWithFormat:@"%@,%@",Str,[Array objectAtIndex:i]];
    }
    
    return Str;
}


@end

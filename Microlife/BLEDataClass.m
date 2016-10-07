//
//  BLEDataClass.m
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BLEDataClass.h"

@implementation BLEDataClass

-(instancetype)init{
    self = [super init];
    
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    [self initBTProtocol];
    [self initBPMProtocol];
    
}

-(void)initBPMProtocol
{
    bPMProtocol=[[BPMProtocol alloc]getInstanceSimulation:NO PrintLog:YES];
    
    bPMProtocol.connectStateDelegate=self;
    bPMProtocol.dataResponseDelegate=self;
    
}

-(void)initBTProtocol
{
    thermoProtocol=[[ThermoProtocol alloc]getInstanceSimulation:NO PrintLog:YES];
    
    thermoProtocol.connectStateDelegate=self;
    thermoProtocol.dataResponseDelegate=self;
    
    checkThermTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(changeConnect) userInfo:nil repeats:YES];
    
}

-(void)changeConnect
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    int year = [calendar component:NSCalendarUnitYear fromDate:date];
    int month = [calendar component:NSCalendarUnitMonth fromDate:date];
    int day = [calendar component:NSCalendarUnitDay fromDate:date];
    int hour = [calendar component:NSCalendarUnitHour fromDate:date];
    int min = [calendar component:NSCalendarUnitMinute fromDate:date];
    int sec = [calendar component:NSCalendarUnitSecond fromDate:date];
    
    NSLog(@"Time Out==>%d/%d/%d %d:%d:%d<==",year,month,day,hour,min,sec);
    
    if(!isChecking)
    {
        isChecking=YES;
        [thermoProtocol startScanTimeout:10];
    }
    
}

#pragma mark - command delegate

/**
 * 開啟設備BLE事件
 * @param isEnable 藍牙是否開啟
 */
- (void) onBtStateChanged:(bool) isEnable{
    NSLog(@"onBtStateChanged-----isEnable = %i", isEnable);
}

/**
 * 返回掃描到的藍牙
 * @param uuid mac address
 * @param name 名稱
 * @param rssi 訊號強度
 */
- (void) onScanResultUUID:(NSString*) uuid Name:(NSString*) name RSSI:(int) rssi{
    NSLog(@"onScanResultUUID-----uuid = %@ , name = %@ , rssi = %i", uuid, name, rssi);
    
    if([name containsString:@"3MW1"]){
        
        cur_uuid=uuid;
        
        [thermoProtocol connectUUID:uuid];
        
    }
}

/**
 * 連線狀態
 * ScanFinish,			//掃描結束
 * Connected,			//連線成功
 * Disconnected,		//斷線
 * ConnectTimeout,		//連線超時
 */
- (void) onConnectionState:(ConnectState) state{
    NSLog(@"onConnectionState-----state = %i", state);
    
    
    connectState=state;
    
    if(state == Connected){
        
        NSLog(@"connection status Connected");
        
        isChecking=YES;
        
    }else if(state == Disconnect || state == ConnectTimeout || state == ScanFinish){
        
        NSLog(@"connection status Disconnected");
        
        isChecking=NO;
        
    }
}




//==========================================

-(void)onResponseDeviceInfo:(NSString *)macAddress workMode:(int)workMode batteryVoltage:(float)batteryVoltage
{
    NSLog(@"macAddress:%@",macAddress);
    NSLog(@"workMode:%d",workMode);
    NSLog(@"batteryVoltage:%f",batteryVoltage);
}

-(void)onResponseUploadMeasureData:(ThermoMeasureData *)data
{
    NSLog(@"%@",[data toString]);
    
    float bodyTemp = roundf([data getMeasureTemperature]*100.0)/100.0;
    float roomTemp = roundf([data getAmbientTemperature]*100.0)/100.0;
    
    //=====save data to DB=====
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSString *yearString=[dateFormatter stringFromDate:[NSDate date]];
    
    NSString *year = [NSString stringWithFormat:@"%d",[data getYear]];
    yearString = [yearString substringToIndex:2];
    yearString = [yearString stringByAppendingString:year];
    
    NSString *month = [NSString stringWithFormat:@"%02d",[data getMonth]];
    NSString *day = [NSString stringWithFormat:@"%02d",[data getDay]];
    NSString *hour = [NSString stringWithFormat:@"%02d",[data getHour]];
    NSString *minute = [NSString stringWithFormat:@"%02d",[data getMinute]];
    
    NSString *date = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",yearString,month,day,hour,minute];
    
    [BTClass sharedInstance].BT_ID = cur_uuid;
    [BTClass sharedInstance].accountID = 123;
    [BTClass sharedInstance].eventID = 1;
        
    [BTClass sharedInstance].date = date;
    
    [BTClass sharedInstance].bodyTemp = [NSString stringWithFormat:@"%.1f",bodyTemp];
    [BTClass sharedInstance].roomTmep = [NSString stringWithFormat:@"%.1f",roomTemp];
    [BTClass sharedInstance].BT_PhotoPath = @"";
    [BTClass sharedInstance].BT_Note = @"";
    [BTClass sharedInstance].BT_RecordingPath = @"";
    
    [[BTClass sharedInstance] insertData];
    
    NSLog(@"[BPMClass sharedInstance] = %@", [[BTClass sharedInstance] selectAllData]);
    
}

@end

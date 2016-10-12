//
//  BLEDataHandler.h
//  Microlife
//
//  Created by Rex on 2016/10/11.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IdeabusSDK_MicroLife.h"

typedef enum{
    
    BPM = 0,
    Temp,
    Weight
    
}scanTag;

@interface BLEDataHandler : NSObject<ConnectStateDelegate,ThermoDataResponseDelegate,BPMDataResponseDelegate,EBodyDataResponseDelegate>{
    
    ThermoProtocol *thermoProtocol;
    BPMProtocol *bPMProtocol;
    EBodyProtocol *eBodyProtocol;
    
    BOOL isSetInfo;
    
    BOOL isChecking;
    
    NSString *cur_uuid;
    ConnectState connectState;
    NSTimer *checkThermTimer;
    
    int scanIndex;
    scanTag tag;
}

-(void)protocolStart;

@end

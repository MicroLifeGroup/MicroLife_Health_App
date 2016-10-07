//
//  BLEDataClass.h
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IdeabusSDK_MicroLife.h"

@interface BLEDataClass : NSObject<ConnectStateDelegate,ThermoDataResponseDelegate,BPMDataResponseDelegate,MyBluetoothLEDelegate>{
    
    ThermoProtocol *thermoProtocol;
    BPMProtocol *bPMProtocol;
    
    BOOL isChecking;
    NSString *cur_uuid;
    ConnectState connectState;
    NSTimer *checkThermTimer;
}

@end

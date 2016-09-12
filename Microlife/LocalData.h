//
//  LocalData.h
//  Microlife
//
//  Created by Rex on 2016/9/9.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject{
    NSMutableArray *reminderDataArray;
    NSUserDefaults *defaults;
}

+(LocalData *)sharedInstance;
-(void)saveReminderData:(NSMutableArray *)dataArray;
-(NSMutableArray *)getReminderData;
@end

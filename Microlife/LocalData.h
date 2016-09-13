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

-(void)saveReminderData:(NSMutableDictionary *)dataDict atIndexPath:(NSInteger)dataIndex;

-(NSMutableDictionary *)getReminderDataAtindex:(NSInteger)dataIndex;

-(NSMutableArray *)getReminderData;

@end

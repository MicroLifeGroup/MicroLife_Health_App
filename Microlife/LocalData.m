//
//  LocalData.m
//  Microlife
//
//  Created by Rex on 2016/9/9.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData

+(LocalData*) sharedInstance{
    static LocalData *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [LocalData new];
    });
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    if (reminderDataArray == nil) {
        reminderDataArray = [[NSMutableArray alloc] init];
    }
    
}

-(void)saveReminderData:(NSMutableArray *)dataArray{
    
    reminderDataArray = [dataArray mutableCopy];
    
}

-(NSMutableArray *)getReminderData{
    
    return [reminderDataArray mutableCopy];
    
}


@end

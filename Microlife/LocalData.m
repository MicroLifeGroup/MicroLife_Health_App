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
    
    self.accontID = 123;
    
}

-(void)saveReminderData:(NSMutableArray *)dataArray{
    
   // NSMutableArray *tempArray = dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        
        for (NSUInteger j = dataArray.count-1; j>0; j--) {
            
            NSMutableDictionary *tempDictA = dataArray[j];
            NSMutableDictionary *tempDictB = dataArray[j-1];
            
            int biggerHour = [[dataArray[j] objectForKey:@"hour"] intValue];
            int smallerHour = [[dataArray[j-1]objectForKey:@"hour"] intValue];
            if (biggerHour < smallerHour) {
                
                [dataArray removeObjectAtIndex:j-1];
                [dataArray insertObject:tempDictA atIndex:j-1];
                
                [dataArray removeObjectAtIndex:j];
                [dataArray insertObject:tempDictB atIndex:j];
                
            }else if (biggerHour == smallerHour) {
                
                int biggerMin = [[dataArray[j] objectForKey:@"min"] intValue];
                int smallerMin = [[dataArray[j-1]objectForKey:@"min"] intValue];
                
                if (biggerMin < smallerMin) {
                    
                    [dataArray removeObjectAtIndex:j-1];
                    [dataArray insertObject:tempDictA atIndex:j-1];
                    
                    [dataArray removeObjectAtIndex:j];
                    [dataArray insertObject:tempDictB atIndex:j];
                }
                
            }
        }
    }
    
    NSLog(@"dataArray = %@",dataArray);
    
    reminderDataArray = dataArray;
    
}

-(NSMutableArray *)getReminderData{
    
    return [reminderDataArray mutableCopy];
    
}


@end

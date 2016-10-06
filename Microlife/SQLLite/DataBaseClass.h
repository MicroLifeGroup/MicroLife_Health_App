//
//  DataBaseClass.h
//  DataBase
//
//  Created by Kimi on 12/9/6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SQLiteClass.h"

@interface DataBaseClass : SQLiteClass
{
    
}

@property int TotalUsers;

- (id)initWithOpenDataBase;
- (NSString *)ArrayToString:(NSMutableArray *)Array;//
@end

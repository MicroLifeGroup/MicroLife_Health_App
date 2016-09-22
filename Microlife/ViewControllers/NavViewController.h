//
//  NavViewController.h
//  Microlife
//
//  Created by 點睛 on 2016/9/21.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MViewController.h"
@interface NavViewController : MViewController<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *navImageArray;
@property(nonatomic,strong)NSMutableArray *navTextArray;
@end

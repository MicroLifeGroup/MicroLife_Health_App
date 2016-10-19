//
//  MailNotificationViewController.h
//  Setting
//
//  Created by Ideabus on 2016/8/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditMailNotificationViewController.h"
#import "MemberCell.h"

@interface MailNotificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,postValueDelegate>{
    //,postValueDelegate
    
    UITableView *MailTableView;
    NSMutableArray *person;
    NSString *str;
   
    
  
    
    UITableView *MailNotificationTableView;
    NSMutableArray *mailItem;

    
    
}

@property (nonatomic,retain)UITableView *MailNotificationTableView;
@property(strong,nonatomic) UITableView *MailTableView;
@property(strong,nonatomic) NSMutableArray *person;
@property(strong,nonatomic) NSString *str;


// 定義一個全局變數來接收行數
@property(assign,nonatomic)int number;

@end

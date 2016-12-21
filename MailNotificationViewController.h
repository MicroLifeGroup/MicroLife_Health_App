//
//  MailNotificationViewController.h
//  Setting
//
//  Created by Ideabus on 2016/8/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMailNotificationViewController.h"
#import "EditMailNotificationViewController.h"
#import "MemberCell.h"

@interface MailNotificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,postValueDelegate>{
    //,postValueDelegate
    
    UITableView *MailTableView;
    NSString *str;
    
    UITableView *MailNotificationTableView;
    
    UILabel *pnavLabel;
    UIButton *navbackBtn;
    UIButton *navselectBtn;
    UIButton *navdeleteBtn;
    UIButton *navcancelBtn;
    
    NSMutableArray *tableviewSelectTag;
    UIButton *addMBtn;
    UIView *memberline;
    
}

@property (nonatomic,retain)UITableView *MailNotificationTableView;
@property(strong,nonatomic) UITableView *MailTableView;
@property(strong,nonatomic) NSString *str;
@property(strong,nonatomic) NSString *nameString;
@property(strong,nonatomic) NSString *emailString;
@property(nonatomic,retain) NSArray *person;
@property BOOL navSelectBtn_isSelected;



// 定義一個全局變數來接收行數
@property(assign,nonatomic)int number;

@end

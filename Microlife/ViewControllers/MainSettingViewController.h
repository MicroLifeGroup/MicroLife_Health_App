//
//  MainSettingViewController.h
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MViewController.h"
#import "MainOverviewViewController.h"
#import "MyDeviceController.h"


@interface MainSettingViewController : MViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UIScrollView *settingSV;
    UIView *syncview;
    UIButton *bpmbBtn;
    UITableView *DeviceManagementTV;
    
    
}

@property (nonatomic,retain) UIScrollView *settingSV;
@property (nonatomic,retain) UIView *syncview;
@property (nonatomic,retain) UIButton *bpmbBtn;
@property (nonatomic,retain) UITableView *DeviceManagementTV;



@end

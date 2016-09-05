//
//  ReminderListViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/2.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "ReminderListViewController.h"
#import "CustomAlarmCell.h"

@interface ReminderListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ReminderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initParameter];
    [self initInterface];
    
}

-(void)initInterface{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToReminderVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UITableView *alarmTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    alarmTable.delegate = self;
    alarmTable.dataSource = self;

    [self.view addSubview:alarmTable];
    
}

-(void)initParameter{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //custom cell 需要給 height 才能顯示
    return 100.0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"AlarmCell";
    
    CustomAlarmCell *customCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (customCell == nil) {
        customCell = [[CustomAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    customCell.frame = CGRectMake(customCell.frame.origin.x, customCell.frame.origin.y, self.view.frame.size.width, customCell.frame.size.height);

    return customCell;
    
}

-(void)backToReminderVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

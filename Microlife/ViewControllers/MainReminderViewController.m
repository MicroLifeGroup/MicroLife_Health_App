//
//  MainReminderViewController.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MainReminderViewController.h"
#import "CustomAlarmCell.h"
#import "SetAlarmViewController.h"

@interface MainReminderViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *alarmTable;
}

@end

@implementation MainReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
    
}

-(void)initParameter{
    
}

-(void)initInterface{
    
    self.navigationItem.title = @"Reminder";
    
    //設定leftBarButtonItem(profileBt)
    UIButton *leftItemBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    
    [leftItemBt setImage:[UIImage imageNamed:@"all_btn_a_menu"] forState:UIControlStateNormal];
    
    [leftItemBt addTarget:self action:@selector(profileBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemBt];
    
    
    float clockImgWidth = 303/self.imgScale;
    float clockImgHeight = 316/self.imgScale;
    
    UIImageView *clockImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-clockImgWidth/2, self.view.frame.size.height*0.123, clockImgWidth, clockImgHeight)];
    
    clockImage.image = [UIImage imageNamed:@"reminder_pic"];
    
    [self.view addSubview:clockImage];
    

    UILabel *reminderIntro = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.78/2, clockImage.frame.origin.y+clockImage.frame.size.height+SCREEN_HEIGHT*0.029, self.view.frame.size.width*0.78, self.view.frame.size.height*0.187)];
    
    UIFont *font = [UIFont systemFontOfSize:18.0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setLineSpacing: 10.0];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Set the time to remind you of doing\nnecessary things you may forget.\nJust tap add button to\ncreate new alarm." attributes:attributes];
    
    [reminderIntro setAttributedText: attributedString];
    
    reminderIntro.textAlignment = NSTextAlignmentCenter;
    
    reminderIntro.numberOfLines = 0;
    
    [self.view addSubview:reminderIntro];
    
    UIButton *addAlarmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-SCREEN_WIDTH*0.2/2, reminderIntro.frame.origin.y+reminderIntro.frame.size.height+SCREEN_HEIGHT*0.029, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.2)];

    [addAlarmBtn setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_add_m"] forState:UIControlStateNormal];
    
    [addAlarmBtn addTarget:self action:@selector(addAlarmAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addAlarmBtn];
    
    
    UIButton *navAddButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [navAddButton setBackgroundImage:[UIImage imageNamed:@"reminder_icon_a_add"] forState:UIControlStateNormal];
    
    [navAddButton addTarget:self action:@selector(addAlarmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navAddButton];
    
    alarmTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    alarmTable.delegate = self;
    alarmTable.dataSource = self;
    
    [self.view addSubview:alarmTable];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //custom cell 需要給 height 才能顯示
    //return SCREEN_HEIGHT*0.176;
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"AlarmCell";
    
    CustomAlarmCell *alarmCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (alarmCell == nil) {
        alarmCell = [[CustomAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        alarmCell.iconImage.image = [UIImage imageNamed:@"reminder_icon_a_bp"];
        alarmCell.typeTitle.text = @"BP";
        alarmCell.timeLabel.text = @"08:12";
        alarmCell.measureWeek.text = @"World Measure, Weekdays";
        
    }
    
    if (indexPath.row == 1) {
        alarmCell.iconImage.image = [UIImage imageNamed:@"reminder_icon_a_we"];
        alarmCell.typeTitle.text = @"Weight";
        alarmCell.timeLabel.text = @"08:13";
        alarmCell.measureWeek.text = @"World Measure, Weekdays";
        
    }
    
    if (indexPath.row == 2) {
        alarmCell.iconImage.image = [UIImage imageNamed:@"reminder_icon_a_bt"];
        alarmCell.typeTitle.text = @"Body Temp.";
        alarmCell.timeLabel.text = @"08:14";
        alarmCell.measureWeek.text = @"World Measure, Weekdays";
        
    }
    
    
    return alarmCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SetAlarmViewController *setAlarmVC = [[SetAlarmViewController alloc] init];
    
    setAlarmVC.isCreate = NO;
    
    [self.navigationController pushViewController:setAlarmVC animated:YES];
}

#pragma mark - Navigation Action

-(void)backToReminderVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAlarmAction{
    
    SetAlarmViewController *addReminderVC = [[SetAlarmViewController alloc] init];
    
    addReminderVC.isCreate = YES;
    
    [self.navigationController pushViewController:addReminderVC animated:YES];
    
}

-(void)editReminderAction{
    
    SetAlarmViewController *setAlarmVC = [[SetAlarmViewController alloc] init];
    
    setAlarmVC.isCreate = NO;
    
    [self.navigationController pushViewController:setAlarmVC animated:YES];
}

#pragma mark - profileBtAction (導覽列左邊按鍵方法)
-(void)profileBtAction {
    
    [self SidebarBtn];
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

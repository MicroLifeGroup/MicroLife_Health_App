//
//  MainReminderViewController.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MainReminderViewController.h"
#import "ReminderListViewController.h"

@interface MainReminderViewController ()

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
    
    [addAlarmBtn addTarget:self action:@selector(pushToAlermList) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addAlarmBtn];
}

-(void)pushToAlermList{
    
    ReminderListViewController *reminderListVC = [[ReminderListViewController alloc] init];
    
    [self.navigationController pushViewController:reminderListVC animated:YES];
    
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

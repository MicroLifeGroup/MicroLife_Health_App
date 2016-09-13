//
//  AlarmDetailViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/9.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "AlarmDetailViewController.h"

@interface AlarmDetailViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@end

@implementation AlarmDetailViewController

@synthesize weekArray,typeArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
    
}

-(void)initParameter{
    
    weekArray = [self.reminderDict objectForKey:@"week"];
    typeArray = [self.reminderDict objectForKey:@"type"];

}

-(void)initInterface{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *navTitle;
    
    switch (self.listType) {
        case 0:
            navTitle = @"Repeat";
            break;
        
        case 1:
            navTitle = @"Type";
            break;
            
        default:
            break;
    }
    
    
    self.navigationItem.title = navTitle;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToSetAlarmVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UITableView *optionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    optionTable.delegate = self;
    optionTable.dataSource = self;
    
    [self.view addSubview:optionTable];
    
}

-(void)backToSetAlarmVC{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger row = 0;
    
    if (self.listType == 0) {
        row = 7;
    }else{
        row = 5;
    }
    
    return row;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    switch (self.listType) {
            
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[[weekArray objectAtIndex:indexPath.row] objectForKey:@"weekName"]];
            
            BOOL choose = [[[weekArray objectAtIndex:indexPath.row] objectForKey:@"choose"] boolValue];
            
            if (choose) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            break;
        case 1:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[[typeArray objectAtIndex:indexPath.row] objectForKey:@"typeName"]];
            
            BOOL choose = [[[typeArray objectAtIndex:indexPath.row] objectForKey:@"choose"] boolValue];
            
            UIImage *typeChooseImg;
            if (choose) {
                typeChooseImg = [self resizeImage:[UIImage imageNamed:@"all_select_a_1"]];
            }else{
                typeChooseImg = [self resizeImage:[UIImage imageNamed:@"all_select_a_0"]];
            }
            
            cell.imageView.image = typeChooseImg;
            
            break;
        }
        default:
            break;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL choose;
    
    switch (self.listType) {
            
        case 0:
            choose = [[[weekArray objectAtIndex:indexPath.row] objectForKey:@"choose"] boolValue];
            
            if (!choose) {
                
                [[weekArray objectAtIndex:indexPath.row] setObject:@"1" forKey:@"choose"];
            }else{
                [[weekArray objectAtIndex:indexPath.row] setObject:@"0" forKey:@"choose"];
            }
            
            break;
        
        case 1:
            
            [[typeArray objectAtIndex:indexPath.row] setObject:@"1" forKey:@"choose"];
            
            for (int i=0; i<typeArray.count; i++) {
                
                if (i != indexPath.row) {
                    [[typeArray objectAtIndex:i] setObject:@"0" forKey:@"choose"];
                }
            }
            
            break;
            
        default:
            break;
    }
    
    [tableView reloadData];
    
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

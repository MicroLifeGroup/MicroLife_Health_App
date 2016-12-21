//
//  OverViewEditEventViewController.m
//  Microlife
//
//  Created by Rex on 2016/10/27.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "OverViewEditEventViewController.h"
#import "OverViewAddEventControllerViewController.h"

@interface OverViewEditEventViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *eventTable;
    NSMutableArray *eventArray;
    UIBarButtonItem *rightBarButton;
    BOOL editing;
}

@end

@implementation OverViewEditEventViewController

@synthesize cellImgAry;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
    
}

-(void)initParameter{
    
    eventArray = [[EventClass sharedInstance] selectAllData];
    
    editing = NO;
    
}

-(void)initInterface{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToOverviewVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnAction)];
    
    [rightBarButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"Event Management";
    
    eventTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    eventTable.delegate = self;
    eventTable.dataSource = self;
    
    [self.view addSubview:eventTable];
    
    if(_eventCount >= 5){
        
    }
    
}

-(void)rightBarBtnAction{
    
    if (editing) {
        [rightBarButton setTitle:@"Delete"];
        self.navigationItem.title = @"Edit Event";
    }else{
        [rightBarButton setTitle:@"Select"];
        self.navigationItem.title = @"Event Management";
    }
    
    
    
    
    editing = !editing;
}

-(void)backToOverviewVC{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return eventArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.0f;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (!editing) {
        
        cell.imageView.image = [cellImgAry objectAtIndex:indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSString *celltitle = [[eventArray objectAtIndex:indexPath.row] objectForKey:@"event"];
    
    cell.textLabel.text = celltitle;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 連結到 add Event 頁面
-(void)pushToAddEventVC:(BOOL)editing{
    
    OverViewAddEventControllerViewController *addEventVC = [[OverViewAddEventControllerViewController alloc]initWithAddEventViewController:self.view.frame];
    
    if (editing) {
        
    }
    
    [self.navigationController pushViewController:addEventVC animated:YES];
    
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

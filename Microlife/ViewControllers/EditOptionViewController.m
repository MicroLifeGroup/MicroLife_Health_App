//
//  EditOptionViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/14.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EditOptionViewController.h"

@interface EditOptionViewController (){
    
    UITextField *insertField;
    
}

@end

@implementation EditOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
}

-(void)initParameter{
    
}

-(void)initInterface{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToAlarmDetailVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveCustomStr)];
    
    [saveButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    UIView *txtFieldBase = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.063)];
    
    txtFieldBase.backgroundColor = [UIColor whiteColor];
    
    insertField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT*0.063)];
    
    self.view.backgroundColor = TABLE_BACKGROUND;
    
    insertField.text = self.customStr;
    
    [txtFieldBase addSubview:insertField];
    [self.view addSubview:txtFieldBase];
}

-(void)saveCustomStr{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"customStr" object:insertField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backToAlarmDetailVC{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    
    return cell;
    
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

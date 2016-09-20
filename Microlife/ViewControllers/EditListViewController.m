//
//  EditListViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/19.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EditListViewController.h"

@interface EditListViewController ()

@end

@implementation EditListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initparameter];
    [self initInterface];
    
}

-(void)initparameter{
    
}

-(void)initInterface{
    
    self.navigationItem.title = @"Edit";
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNoteAction)];
    
    [saveButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

-(void)backToListVC{
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveNoteAction{
    
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

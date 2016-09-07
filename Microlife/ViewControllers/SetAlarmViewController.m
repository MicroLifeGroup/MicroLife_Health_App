//
//  SetAlarmViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/5.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "SetAlarmViewController.h"

@interface SetAlarmViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>


@end

@implementation SetAlarmViewController

@synthesize isCreate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
}

-(void)initParameter{

}

-(void)initInterface{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToReminderVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    if (isCreate) {
        self.navigationItem.title = @"Add reminder";
    }else{
        self.navigationItem.title = @"Edit reminder";
    }
    
    UIPickerView *timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.322)];
    timePicker.delegate = self;
    timePicker.dataSource = self;
    
    [timePicker selectRow:0 inComponent:0 animated:NO];
    [timePicker selectRow:0 inComponent:1 animated:NO];
    
    [self.view addSubview:timePicker];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    NSInteger rowCount = 0;
    
    if(component == 0){
        rowCount =  24;
    }
    else if(component == 1){
        rowCount =  60;
    }
    
    return rowCount;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *hourArray = [NSMutableArray new];
    NSMutableArray *minArray = [NSMutableArray new];
    
    for (int i=0; i<24; i++) {
        
        NSNumber *hourNum = [NSNumber numberWithInt:i];
        
        [hourArray addObject:hourNum];
    }
    
    for (int i=0; i<60; i++) {
        
        NSNumber *minNum = [NSNumber numberWithInt:i];
        
        [minArray addObject:minNum];
    }
    
    NSString *rowTitle;
    
    if(component == 0){
        rowTitle = [NSString stringWithFormat:@"%02d",[[hourArray objectAtIndex:row] intValue]];
    }
    
    if(component == 1){
        rowTitle = [NSString stringWithFormat:@"%02d",[[minArray objectAtIndex:row] intValue]];
    }

    return rowTitle;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:40]];
        //[tView setTextAlignment:UITextAlignmentLeft];
        tView.numberOfLines = 1;
    }
    
    NSMutableArray *hourArray = [NSMutableArray new];
    NSMutableArray *minArray = [NSMutableArray new];
    
    for (int i=0; i<24; i++) {
        
        NSNumber *hourNum = [NSNumber numberWithInt:i];
        
        [hourArray addObject:hourNum];
    }
    
    for (int i=0; i<60; i++) {
        
        NSNumber *minNum = [NSNumber numberWithInt:i];
        
        [minArray addObject:minNum];
    }
    
    NSString *rowTitle;
    
    if(component == 0){
        rowTitle = [NSString stringWithFormat:@"%02d",[[hourArray objectAtIndex:row] intValue]];
    }
    
    if(component == 1){
        rowTitle = [NSString stringWithFormat:@"%02d",[[minArray objectAtIndex:row] intValue]];
    }
    
    // Fill the label text here
    tView.text = rowTitle;
    return tView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    //return SCREEN_WIDTH*0.16;
    return 80;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    //return SCREEN_HEIGHT*0.06;
    return 50;
}

#pragma mark - Navigation Delegate
-(void)backToReminderVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

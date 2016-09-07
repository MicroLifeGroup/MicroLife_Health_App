//
//  SetAlarmViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/5.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "SetAlarmViewController.h"

@interface SetAlarmViewController ()<UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>


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
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(timePicker.frame.size.width/2-SCREEN_WIDTH*0.12/2, timePicker.frame.size.height/2-SCREEN_HEIGHT*0.06/2, SCREEN_WIDTH*0.12, SCREEN_HEIGHT*0.06)];
    hourLabel.text = @"hours";
    hourLabel.font = [UIFont systemFontOfSize:18];
    [timePicker addSubview:hourLabel];
    
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.74, timePicker.frame.size.height/2-SCREEN_HEIGHT*0.06/2, SCREEN_WIDTH*0.126, SCREEN_HEIGHT*0.06)];
    minLabel.text = @"min";
    minLabel.font = [UIFont systemFontOfSize:18];
    [timePicker addSubview:minLabel];
    
    UITableView *settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, timePicker.frame.origin.y+timePicker.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT*0.449) style:UITableViewStyleGrouped];
    
    settingTable.delegate = self;
    settingTable.dataSource = self;
    settingTable.scrollEnabled = NO;
    
    [self.view addSubview:settingTable];
}

#pragma mark - Table view delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *cellTitle;
    
    NSArray *titleAry = [NSArray arrayWithObjects:@"Repeat",@"Type",@"Measure Model", nil];

    cellTitle = [titleAry objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellTitle;
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-cell.accessoryView.frame.size.width-SCREEN_WIDTH*0.293, 0, SCREEN_WIDTH*0.293, cell.frame.size.height)];
    
    introLabel.textAlignment = NSTextAlignmentRight;
    introLabel.textColor = TEXT_COLOR;
    
    //[sender setImage:[UIImage imageNamed:@"image.png"] forSegmentAtIndex:sender.selectedSegmentIndex];
    
    NSArray *itemArray = [NSArray arrayWithObjects:
                          @"",
                          @"",
                          @"",
                          nil];
    
    UISegmentedControl *cellSegment = [[UISegmentedControl alloc] initWithItems:itemArray];
    
    cellSegment.frame = CGRectMake(cell.frame.size.width-SCREEN_WIDTH*0.64, cell.frame.size.height/2-29/2, SCREEN_WIDTH*0.64, 29);
    
    UIImage *onceActive;
    UIImage *recurringActive;
    UIImage *scheduledActive;

    
    if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
        onceActive = [[UIImage imageNamed:@"reminder_btn_a_bp_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        recurringActive = [[UIImage imageNamed:@"reminder_btn_a_we_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        scheduledActive = [[UIImage imageNamed:@"reminder_btn_a_bt_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
//    [UIImage imageNamed:@"reminder_btn_a_bp_0"],
//    [UIImage imageNamed:@"reminder_btn_a_we_0"],
//    [UIImage imageNamed:@"reminder_btn_a_bt_0"]
    
    cellSegment.selectedSegmentIndex = 0;
    cellSegment.tintColor = STANDER_COLOR;
    [cellSegment setImage:onceActive forSegmentAtIndex:0];
    [cellSegment setImage:recurringActive forSegmentAtIndex:1];
    [cellSegment setImage:scheduledActive forSegmentAtIndex:2];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == 0){
        introLabel.text = @"Never";
        [cell addSubview:introLabel];
    }
    
    if(indexPath.row == 1){
        introLabel.text = @"World Measure";
        [cell addSubview:introLabel];
    }
    
    if (indexPath.row == 2) {
        [cell addSubview:cellSegment];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Picker view delegate

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
    UILabel* pickTitle = (UILabel*)view;
    if (!pickTitle)
    {
        pickTitle = [[UILabel alloc] init];
        [pickTitle setFont:[UIFont fontWithName:@"Helvetica" size:35]];
        pickTitle.textAlignment = NSTextAlignmentCenter;
        pickTitle.numberOfLines = 1;
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
    pickTitle.text = rowTitle;
    return pickTitle;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    //return SCREEN_WIDTH*0.16;
    return 120;
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

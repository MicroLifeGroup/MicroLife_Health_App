//
//  SetAlarmViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/5.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "SetAlarmViewController.h"
#import "AlarmDetailViewController.h"

@interface SetAlarmViewController ()<UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *settingTable;
    NSMutableDictionary *reminderDict;
    UIPickerView *timePicker;
    UISegmentedControl *cellSegment;
    NSMutableArray *hourArray;
    NSMutableArray *minArray;
    
    NSMutableArray *typeArray;
    NSMutableArray *weekArray;
}

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
    
    if (isCreate) {
        [self initAlarmParameter];
    }else{
        reminderDict = [[LocalData sharedInstance] getReminderDataAtindex:self.alarmIndex];
    }
    
    NSLog(@"123");
    
}

-(void)initAlarmParameter{
    
    NSDate *currentDay = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm";
    
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:currentDay]);
    
    NSString *dateStr = [dateFormatter stringFromDate:currentDay];
    
    NSString *hourStr = [dateStr substringToIndex:2];
    
    NSString *minStr = [dateStr substringWithRange:NSMakeRange(3, 2)];
    
    NSLog(@"dateStr = %@, hourStr = %@, minStr = %@",dateStr,hourStr,minStr);
    
    
    weekArray = [[NSMutableArray alloc] initWithCapacity:0];
    typeArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *weekNameArray = [[NSArray alloc] initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    for (int i=0; i<weekNameArray.count; i++) {
        
        NSString *weekName = [NSString stringWithFormat:@"%@",[weekNameArray objectAtIndex:i]];
        
        NSMutableDictionary *weekDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:weekName,@"weekName",
                                         @"0",@"choose",nil];
        
        [weekArray addObject:weekDict];
        
    }
    
    NSArray *typeNameArray = [[NSArray alloc] initWithObjects:@"World Measure",@"Measure",@"Mdeicine",@"Doctor",@"Custom", nil];
    
    for (int i=0; i<typeNameArray.count; i++) {
        
        NSString *typeName = [NSString stringWithFormat:@"%@",[typeNameArray objectAtIndex:i]];
        
        NSNumber *chooseType;
        
        if (i==0) {
            chooseType = [NSNumber numberWithInt:1];
        }else{
            chooseType = [NSNumber numberWithInt:0];
        }
        
        
        
        NSMutableDictionary *typeDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:typeName,@"typeName",
                                         chooseType,@"choose",nil];
        
        [typeArray addObject:typeDict];
    }
    
    reminderDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:hourStr,@"hour",
                                  minStr,@"min",
                                  weekArray,@"week",
                                  typeArray,@"type",
                                  @"0",@"model",
                                  @"0",@"status",
                                  nil];
    
    hourArray = [NSMutableArray new];
    minArray = [NSMutableArray new];
}

-(void)initInterface{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToReminderVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveReminder)];
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    if (isCreate) {
        self.navigationItem.title = @"Add reminder";
    }else{
        self.navigationItem.title = @"Edit reminder";
    }
    
    timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.322)];
    timePicker.delegate = self;
    timePicker.dataSource = self;
    
    [self.view addSubview:timePicker];
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(timePicker.frame.size.width/2-SCREEN_WIDTH*0.12/2, timePicker.frame.size.height/2-SCREEN_HEIGHT*0.06/2, SCREEN_WIDTH*0.12, SCREEN_HEIGHT*0.06)];
    hourLabel.text = @"hours";
    hourLabel.font = [UIFont systemFontOfSize:15];
    [timePicker addSubview:hourLabel];
    
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.74, timePicker.frame.size.height/2-SCREEN_HEIGHT*0.06/2, SCREEN_WIDTH*0.126, SCREEN_HEIGHT*0.06)];
    minLabel.text = @"min";
    minLabel.font = [UIFont systemFontOfSize:15];
    [timePicker addSubview:minLabel];
    
    settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, timePicker.frame.origin.y+timePicker.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT*0.449) style:UITableViewStyleGrouped];
    
    settingTable.delegate = self;
    settingTable.dataSource = self;
    settingTable.scrollEnabled = NO;
    
    [self.view addSubview:settingTable];
}

-(void)viewWillAppear:(BOOL)animated{
    
    int hourRow = [[reminderDict objectForKey:@"hour"] intValue];
    int minRow = [[reminderDict objectForKey:@"min"] intValue];
    
    NSLog(@"hourRow = %d, minRow = %d",hourRow,minRow);
    
    [timePicker selectRow:hourRow inComponent:0 animated:NO];
    [timePicker selectRow:minRow inComponent:1 animated:NO];
    
    [settingTable reloadData];
}

-(void)saveReminder{
    
    NSString *hourStr = [NSString stringWithFormat:@"%@",[hourArray objectAtIndex:[timePicker selectedRowInComponent:0]]];
    
    NSString *minStr = [NSString stringWithFormat:@"%@",[minArray objectAtIndex:[timePicker selectedRowInComponent:1]]];
    
    NSString *modelStr = [NSString stringWithFormat:@"%ld",(long)cellSegment.selectedSegmentIndex];

    
    [reminderDict setValue:hourStr forKey:@"hour"];
    [reminderDict setValue:minStr forKey:@"min"];
    [reminderDict setValue:weekArray forKey:@"week"];
    [reminderDict setValue:typeArray forKey:@"type"];
    [reminderDict setValue:modelStr forKey:@"model"];
    [reminderDict setValue:@"1" forKey:@"status"];
    
    [[LocalData sharedInstance] saveReminderData:reminderDict atIndexPath:self.alarmIndex];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-SCREEN_WIDTH*0.5-SCREEN_WIDTH*0.1, 0, SCREEN_WIDTH*0.5, 44)];
    
    introLabel.textAlignment = NSTextAlignmentRight;
    introLabel.textColor = TEXT_COLOR;

    
    UIImage *segmentBpImg = [self resizeImage:[UIImage imageNamed:@"reminder_btn_a_bp_0"]];
    UIImage *segmentWeImg = [self resizeImage:[UIImage imageNamed:@"reminder_btn_a_we_0"]];
    UIImage *segmentBtImg = [self resizeImage:[UIImage imageNamed:@"reminder_btn_a_bt_0"]];
    
    NSArray *itemArray = [NSArray arrayWithObjects:
                          segmentBpImg,
                          segmentWeImg,
                          segmentBtImg,
                          nil];
    
    cellSegment = [[UISegmentedControl alloc] initWithItems:itemArray];
    
    cellSegment.frame = CGRectMake(self.view.frame.size.width-SCREEN_WIDTH*0.6-SCREEN_WIDTH*0.04, cell.frame.size.height/2-SCREEN_HEIGHT*0.044/2, SCREEN_WIDTH*0.6, SCREEN_HEIGHT*0.044);
    
    cellSegment.selectedSegmentIndex = [[reminderDict objectForKey:@"model"] intValue];
    
    cellSegment.tintColor = STANDER_COLOR;
    
    
    for (int i=0; i<itemArray.count; i++) {
        [cellSegment setImage:[itemArray objectAtIndex:i] forSegmentAtIndex:i];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:{
            
            NSMutableArray *chooseWeek = [reminderDict objectForKey:@"week"];
            
            NSString *weekStr;
            
            for (int i=0; i<chooseWeek.count; i++) {
                
                if([[[chooseWeek objectAtIndex:i] objectForKey:@"choose"] boolValue]){
                    weekStr = [weekStr stringByAppendingFormat:@"%@",[[chooseWeek objectAtIndex:i] objectForKey:@"weekName"]];
                    NSLog(@"weekStr = %@",weekStr);
                    
                    introLabel.text = weekStr;
                }
            }
            
            [cell addSubview:introLabel];
         }   
            break;
        
        case 1:{
            NSMutableArray *chooseType = [reminderDict objectForKey:@"type"];
            NSString *typeStr;
            
            for (int i=0; i<chooseType.count; i++) {
                
                if([[[chooseType objectAtIndex:i] objectForKey:@"choose"] boolValue]){
                    typeStr = [[chooseType objectAtIndex:i] objectForKey:@"typeName"];
                    
                    introLabel.text = typeStr;
                }
            }
            
            [cell addSubview:introLabel];
        }
            
            break;
        
        case 2:
            
            [cell addSubview:cellSegment];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        
            
        default:
            break;
    }
    
    return  cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlarmDetailViewController *detailVC = [[AlarmDetailViewController alloc] init];
    
    detailVC.listType = (int)indexPath.row;
    
    detailVC.reminderDict = reminderDict;
    
    if (indexPath.row != 2) {
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
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

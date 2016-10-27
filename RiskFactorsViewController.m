//
//  RiskFactorsViewController.m
//  Setting
//
//  Created by Ideabus on 2016/8/12.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "RiskFactorsViewController.h"
#import "ViewController.h"


@interface RiskFactorsViewController ()

@end

@implementation RiskFactorsViewController{
    UITableView *riskfactorsTableV;
    NSArray *rfItem;
    NSMutableArray *tableSelectTag;
}
@synthesize rfselectBtn;
@synthesize RFTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self RFView];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:240.0f/255.0f]];
    
    [self riskfactortableview];
    
    
    [self RFnav];
    
    [self initParameter];
}

-(void)initParameter{
    
    tableSelectTag = [NSMutableArray new];
    
    for (int i=0; i<14; i++) {
        
        NSString *selectStr = @"0";
        
        [tableSelectTag addObject:selectStr];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RFnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
//    UIView *tableviewbottomline = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.79-1, self.view.frame.size.width, 2)];
//    tableviewbottomline.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0];
//    [self.view addSubview:tableviewbottomline];
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Risk Factors";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal ];
        navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [navbackBtn addTarget:self action:@selector(gobackProfile) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navbackBtn];
    
//    UIButton *navsaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    navsaveBtn.frame = CGRectMake(self.view.frame.size.width*0.8, self.view.frame.size.height*0.02, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
//    [navsaveBtn setTitle:@"Save" forState:UIControlStateNormal];
//    [navsaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    navsaveBtn.titleLabel.font = [UIFont systemFontOfSize:21];
//    navsaveBtn.backgroundColor = [UIColor clearColor];
//    navsaveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
//    
//    [navsaveBtn addTarget:self action:@selector(gobackProfile) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [self.view addSubview:navsaveBtn];
    
    
    
}

-(void)gobackProfile{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)riskfactortableview{
    

    

     RFTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.09, self.view.frame.size.width, self.view.frame.size.height*0.91)];
    RFArray=[[NSMutableArray alloc]init];
    [RFArray addObject:@"Personal History of Hypertension"];
    [RFArray addObject:@"Personal History of Atrial Fibrillation"];
    [RFArray addObject:@"Personal History of Diabetes"];
    [RFArray addObject:@"Personal History of Cardiovascular diseases (CVD)"];
    [RFArray addObject:@"Personal History of Chronic Kidney Disease (CKD)"];
    [RFArray addObject:@"Personal History of Stroke/Transient Ischemic Attack (TIA)"];
    [RFArray addObject:@"Personal History of Dyslipidemia"];
    [RFArray addObject:@"Personal History of Snoring & Sleep Aponea"];
    [RFArray addObject:@"Drug Use–Oral Contraception"];
    [RFArray addObject:@"Drug Use–Anti-Hypertensive Drugs"];
    [RFArray addObject:@"Pregenancy - Normal"];
    [RFArray addObject:@"Pregnancy–Pre-Eclampsia"];
    [RFArray addObject:@"Smoking"];
    [RFArray addObject:@"Alcohol Intake"];
    
    
    
    
    RFTableView.delegate = self;
    RFTableView.dataSource = self;
    //self.RFTableView.scrollEnabled = NO;
    RFTableView.backgroundColor = [UIColor clearColor];
    RFTableView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0]);
    RFTableView.layer.borderWidth = 2;
    //RFTableView.pagingEnabled = true;
    RFTableView.allowsMultipleSelection = YES;
    //[RFTableView setEditing:YES animated:YES];
    
   // RFTableView.userInteractionEnabled = NO;
    
    [RFTableView registerNib:[UINib nibWithNibName:@"RiskFactorCell" bundle:nil] forCellReuseIdentifier:@"RFcell_ID"];
    
    
    [self.view addSubview:RFTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RFArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"RFcell_ID";

     RiskFactorCell *RFcell = [tableView dequeueReusableCellWithIdentifier:@"RFcell_ID" forIndexPath:indexPath];
    
    RFcell.m_superVC = self;
//    if (RFcell == nil) {
//        
//        RFcell = [[RiskFactorCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
//        
//        [RFcell refreshWithBt];
//    }
    
    RFcell.RFLabel.text = RFArray[indexPath.row];
    RFcell.RFLabel.numberOfLines = 2;
    
 
    
    
    
    
    
//    [ RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_1"] forState:UIControlStateSelected];
//    [ RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_0"] forState:UIControlStateNormal];
//    
//    if (RFcell.RFcheckbox.tag == 0) {
//        
//        [ RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_1"] forState:UIControlStateSelected];
//    }
//    else if (RFcell.RFcheckbox.tag == 1) {
//        
//        [ RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_0"] forState:UIControlStateNormal];
//    }
//    

    
    
    //RFcell.RFcheckbox.tag = (int)indexPath.row;
    //[RFcell.RFcheckbox addTarget:self action:@selector(RFcheckmarkClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    if (RFcell.isSelected == YES) {
//        
//        [RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_1"] forState:UIControlStateNormal];
//    }
//    else {
//        
//        [RFcell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_0"] forState:UIControlStateNormal];
//    }
    
    
    RFcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BOOL selected = [[tableSelectTag objectAtIndex:indexPath.row] boolValue];
    
    RFcell.RFcheckbox.image = [UIImage imageNamed:@"all_select_a_0"];
    
    if (selected) {
        RFcell.RFcheckbox.image = [UIImage imageNamed:@"all_select_a_1"];    }
    
    return RFcell;
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 ;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 3;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"user selected %@",[RFArray objectAtIndex:indexPath.row]);
    
    NSString *selectStr;
    
    //for (int i=0; i<tableSelectTag.count; i++) {
        
    BOOL selected = [[tableSelectTag objectAtIndex:indexPath.row] boolValue];
    
    selected = !selected;
    
    selectStr = [NSString stringWithFormat:@"%d",selected];
    //}
    
    [tableSelectTag replaceObjectAtIndex:indexPath.row withObject:selectStr];
    
//    RiskFactorCell *rfCell = [tableView cellForRowAtIndexPath:indexPath];
//    rfCell.accessoryView.hidden = NO;
//    [rfCell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_1"]  forState:UIControlStateNormal];
    
    [RFTableView reloadData];
    
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"user de-selected %@",[RFArray objectAtIndex:indexPath.row]);
//    RiskFactorCell *rfCell = [tableView cellForRowAtIndexPath:indexPath];
//    [rfCell.RFcheckbox setImage:[UIImage imageNamed:@"all_select_a_0"]  forState:UIControlStateNormal];
//    rfCell.accessoryView.hidden = YES;
    [RFTableView reloadData];
    
}






@end

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
}
@synthesize rfselectBtn;
@synthesize RFTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self RFView];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:240.0f/255.0f]];
    
    [self riskfactortableview];
    
    
    [self RFnav];
    
    
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
    
    RFTableView = [[UITableView alloc] initWithFrame:CGRectMake(-2, self.view.frame.size.height*0.09-2, self.view.frame.size.width, 470)];
    RFArray=[[NSMutableArray alloc]init];
    [RFArray addObject:@"Diabetes"];
    [RFArray addObject:@"Hypertension"];
    [RFArray addObject:@"Heart Faulure"];
    [RFArray addObject:@"Stroke"];
    [RFArray addObject:@"COPD"];
    [RFArray addObject:@"Hyperthyroidism"];
    [RFArray addObject:@"TIA"];
    [RFArray addObject:@"Myocardial Infarction"];
    [RFArray addObject:@"Left Ventricular Hypertrophy"];
    [RFArray addObject:@"Pregenancy"];
    
    
    self.RFTableView.delegate=(id)self;
    self.RFTableView.dataSource=(id)self;
    self.RFTableView.scrollEnabled = NO;
    RFTableView.backgroundColor = [UIColor clearColor];
    RFTableView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0]);
    RFTableView.layer.borderWidth = 2;
    
    //[RFTableView setEditing:YES animated:YES];
    
   // RFTableView.userInteractionEnabled = NO;
    
    [self.view addSubview:RFTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RFArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RFcell_ID";
    RiskFactorCell *RFcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (RFcell == nil) {
        //cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RiskFactorCell"owner:self options:nil];
        RFcell = [nib objectAtIndex:0];
        
        RFcell.RFLabel.text = self->RFArray[indexPath.row];
        RFcell.RFcheckbox.tag = (int)indexPath.row;
        // [cell.checkboxBtn addTarget:self action:@selector(memberselect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    RFcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return RFcell;
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47 ;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"user selected %@",[RFArray objectAtIndex:indexPath.row]);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"user de-selected %@",[RFArray objectAtIndex:indexPath.row]);
}




@end

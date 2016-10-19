//
//  OverViewAddEventControllerViewController.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/14.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "OverViewAddEventControllerViewController.h"


@interface OverViewAddEventControllerViewController () {
    
    UITextField *nameTextField;
    UITextField *typeTextField;
    UITextField *dateTextField;
    
    UIDatePicker *datePickerView;
    
}

@end

@implementation OverViewAddEventControllerViewController

@synthesize ary_userDataStr;

-(id)initWithAddEventViewController:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarbuttonItem];
    
    [self createViews];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if (ary_userDataStr != nil || ary_userDataStr.count != 0) {
        
        [ary_userDataStr removeAllObjects];
        
        ary_userDataStr = nil;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)createBarbuttonItem {
    
    //title
    self.navigationItem.title = @"Add Event";
    
    
    //設定leftBarButtonItem
    UIButton *leftItemBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35 , 35)];
    
    [leftItemBt setImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal];
    
    [leftItemBt addTarget:self action:@selector(pushToMainOverViewVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemBt];
    
    
    //設定rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserData)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
}


-(void)createViews {
    
    //datePickerView
    datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
    datePickerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewHeight = self.view.frame.size.height/15;
    
    CGFloat space = 2.5;
    
    NSMutableArray<UIView *> *ary_bgview = [[NSMutableArray alloc] init];
    
    //生成三個底圖白色的view
    for (int i = 0; i < 3; i++) {
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight*(i+1)+space*i, self.view.frame.size.width, viewHeight)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:bgview];
        
        [ary_bgview addObject:bgview];
    }
    
    
    
    CGFloat labelWidth = ary_bgview[0].frame.size.width/5;
    CGFloat labelHeight = ary_bgview[0].frame.size.height;
    
    //nameLabel
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, labelWidth, labelHeight)];
    nameLabel.text = @"Person";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [ary_bgview[0] addSubview:nameLabel];
    
    //typeLabel
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, labelWidth, labelHeight)];
    typeLabel.text = @"Type";
    typeTextField.textAlignment = NSTextAlignmentLeft;
    [ary_bgview[1] addSubview:typeLabel];
    
    //dateLabel
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, labelWidth, labelHeight)];
    dateLabel.text = @"Date";
    dateTextField.textAlignment = NSTextAlignmentLeft;
    [ary_bgview[2] addSubview:dateLabel];
    

    
    CGFloat textFieldWidth = (ary_bgview[0].frame.size.width - labelWidth) * 0.8;
    CGFloat textFieldHeight = ary_bgview[0].frame.size.height *0.88;
    CGFloat textFieldSpace = ary_bgview[0].frame.size.height - textFieldHeight;
    
    //將nameTextField 加到 ary_bgView[0] 上
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), textFieldSpace/2, textFieldWidth, textFieldHeight)];
    [ary_bgview[0] addSubview:nameTextField];
    
    //將typeTextField 加到 ary_bgView[1] 上
    typeTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeLabel.frame), textFieldSpace/2, textFieldWidth, textFieldHeight)];
    [ary_bgview[1] addSubview:typeTextField];
    
    //將dateTextField 加到 ary_bgView[2] 上
     dateTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dateLabel.frame), textFieldSpace/2, textFieldWidth, textFieldHeight)];
    [ary_bgview[2] addSubview:dateTextField];
    dateTextField.inputView = datePickerView;
    
}

#pragma mark - pushToMainOverViewVC
-(void)pushToMainOverViewVC {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - saveUserData
-(void)saveUserData {
    
    ary_userDataStr = [[NSMutableArray alloc] init];
    [ary_userDataStr addObject: nameTextField.text];
    [ary_userDataStr addObject: typeTextField.text];
    [ary_userDataStr addObject: dateTextField.text];
    
    NSLog(@"ary_userDataStr:%@",ary_userDataStr);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end

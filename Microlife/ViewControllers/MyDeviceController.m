//
//  MyDeviceController.m
//  Microlife
//
//  Created by Idea on 2016/10/7.
//  Copyright © 2016年 Rex. All rights reserved.
//MyDevice的頁面

#import "MyDeviceController.h"

@interface MyDeviceController (){
    
    NSMutableDictionary *errorArr;
    NSArray *errorArray;
    NSMutableArray *microlifeData;
    
}

@end

@implementation MyDeviceController
@synthesize deviceLabel;
@synthesize deviceStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    errorArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    errorArr =  [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    
    
    [errorArr setObject:@"血壓量測ERROR1" forKey:@"5"];
    [errorArr setObject:@"血壓量測ERROR1" forKey:@"5"];
    [errorArr setObject:@"血壓量測ERROR1" forKey:@"5"];
    [errorArr setObject:@"血壓量測ERROR1" forKey:@"5"];
    [errorArr setObject:@"血壓量測ERROR1" forKey:@"5"];

    
    [self MyDeviceView];
    
    
    [self MyDevicenav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MyDeviceView{
    
    float md_Y = self.view.frame.size.height*0.17;
    float md_H = self.view.frame.size.height*0.07;
    float md_X = self.view.frame.size.width*0.5;
    float md_W = self.view.frame.size.width*0.48;
    float mdx = self.view.frame.size.width*0.05;
    
    //Microlife 001
    deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(mdx+md_H, md_Y-md_H , md_W , md_H)];
    [deviceLabel setTextColor:[UIColor blackColor ]];
    deviceLabel.backgroundColor = [UIColor clearColor];
    deviceLabel.text = deviceStr;
    deviceLabel.font = [UIFont systemFontOfSize:22];
    deviceLabel.alpha = 1.0;
    deviceLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:deviceLabel];

    //Microlife 001圖
    UIImageView *deviceImgV = [[UIImageView alloc] initWithFrame:CGRectMake(mdx, md_Y-md_H*0.9, md_H*0.8, md_H*0.8)];
    UIImage *deviceImg= [UIImage imageNamed:@"setting_icon_a_product"];
    deviceImgV.image = deviceImg;
    deviceImgV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview :deviceImgV];
    
    
    //產品序號
    UILabel *numtittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mdx, md_Y , md_W , md_H)];
    [numtittleLabel setTextColor:[UIColor blackColor ]];
    numtittleLabel.backgroundColor = [UIColor clearColor];
    numtittleLabel.text = @"產品序號";
    numtittleLabel.font = [UIFont systemFontOfSize:22];
    numtittleLabel.alpha = 1.0;
    numtittleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:numtittleLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(md_X, md_Y , md_W , md_H)];
    [numLabel setTextColor:[UIColor blackColor ]];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.text = @"NO.1234";
    numLabel.font = [UIFont systemFontOfSize:22];
    numLabel.alpha = 1.0;
    numLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:numLabel];
    
    //產品序號
    UILabel *timestittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mdx, md_Y+md_H , md_W , md_H)];
    [timestittleLabel setTextColor:[UIColor blackColor ]];
    timestittleLabel.backgroundColor = [UIColor clearColor];
    timestittleLabel.text = @"量測次數";
    timestittleLabel.font = [UIFont systemFontOfSize:22];
    timestittleLabel.alpha = 1.0;
    timestittleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:timestittleLabel];
    
    UILabel *timesLabel = [[UILabel alloc] initWithFrame:CGRectMake(md_X, md_Y+md_H , md_W , md_H)];
    [timesLabel setTextColor:[UIColor blackColor ]];
    timesLabel.backgroundColor = [UIColor clearColor];
    timesLabel.text = @"999";
    timesLabel.font = [UIFont systemFontOfSize:22];
    timesLabel.alpha = 1.0;
    timesLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:timesLabel];
    
    
    MeasureTV = [[UITableView alloc]initWithFrame:CGRectMake(-1, md_Y+md_H*2, self.view.frame.size.width+2, (errorArray.count)*md_H)];
    
    MeasureTV.delegate = self;
    MeasureTV.dataSource = self;
//    MeasureTV.layer.borderWidth = 1;
//    MeasureTV.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    MeasureTV.pagingEnabled = false;
    MeasureTV.scrollEnabled = NO;
    MeasureTV.bounces = NO;
    [self.view addSubview:MeasureTV];
    
    
    [MeasureTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MeasureCell_ID"];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(mdx, md_Y , self.view.frame.size.width*0.95, 1)];
    line1.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0];
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(mdx, md_Y+md_H*1 , self.view.frame.size.width*0.95, 1)];
    line2.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0];
    [self.view addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(mdx, md_Y+md_H*2 , self.view.frame.size.width*0.95, 1)];
    line3.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0];
    [self.view addSubview:line3];
    
    
    
    
}


-(void)MyDevicetableview{
    
    
}



-(void)MyDevicenav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"MyDevice";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal ];
    navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [navbackBtn addTarget:self action:@selector(gobackSetting) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navbackBtn];
    
    
    
}

-(void)gobackSetting{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - 代理方法  顯示選中行的單元格信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - 設置顯示分區數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 數據源 每個分區對應的函數設置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return errorArray.count;
}

#pragma mark - 數據源 每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *cellIdentity=@"mailcell";
    //    UITableViewCell *mailcell=[tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
    //    mailcell.textLabel.text=self.person[indexPath.row];
    //
    //    return mailcell;
    
    static NSString *CellIdentifier = @"Measurecell";
    MeasureCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MeasureCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.errortittle.text = @"血壓量測ERROR1";
        cell.errortimes.text = @"5";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}




#pragma mark - 實現代理的方法
-(void)postValue:(NSString *)stringp
{
    //[self.person replaceObjectAtIndex:self.number withObject:stringp];
    [self->MeasureTV reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height*0.07 ;
}





@end

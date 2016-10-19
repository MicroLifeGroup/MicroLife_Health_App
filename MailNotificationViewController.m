//
//  MailNotificationViewController.m
//  Setting
//
//  Created by Ideabus on 2016/8/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "MailNotificationViewController.h"
#import "EditMailNotificationViewController.h"

@interface MailNotificationViewController (){
    
    NSMutableDictionary *memberArray;
     NSMutableArray *list;
}



@end

@implementation MailNotificationViewController{
    NSArray *mailtItem;
}

@synthesize MailTableView;
@synthesize person;
@synthesize str;

@synthesize MailNotificationTableView;




- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0]];
    self.person=[NSMutableArray array];
    for (int i=1; i<15; i++) {
        [self.person addObject:[NSString stringWithFormat:@"第%d個聯繫人",i]];
    }
    
    [self maileTableView];
    
    
    //mailItem = [["1","2"],[],[],[],[]];
    
    
    [self mailnotificationnav];
    
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    memberArray =  [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    
    
    [memberArray setObject:@"Eva" forKey:@"eva@gmail.com"];
    [memberArray setObject:@"Mary" forKey:@"mary@gmail.com"];
    [memberArray setObject:@"Sale" forKey:@"sale@gmail.com"];
    [memberArray setObject:@"Ellie" forKey:@"ellie@gmail.com"];
    [memberArray setObject:@"Simple" forKey:@"simple@gmail.com"];
    
    
    
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MailTableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mailnotificationnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Mail Notification";
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
    
    UIButton *navselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navselectBtn.frame = CGRectMake(self.view.frame.size.width*0.8, self.view.frame.size.height*0.017, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navselectBtn setTitle:@"Select" forState:UIControlStateNormal];
    [navselectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navselectBtn.titleLabel.font = [UIFont systemFontOfSize:21];
    navselectBtn.backgroundColor = [UIColor clearColor];
    navselectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [navselectBtn addTarget:self action:@selector(selectmemberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navselectBtn];
    
    
    UIButton *addMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMBtn.frame = CGRectMake((self.view.frame.size.width-self.view.frame.size.height*0.09)*0.95, self.view.frame.size.height*0.87, self.view.frame.size.height*0.09, self.view.frame.size.height*0.09);
    [addMBtn setImage:[UIImage imageNamed:@"overview_btn_a_add_s"] forState:UIControlStateNormal ];
    
    addMBtn.backgroundColor = [UIColor clearColor];
    addMBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [addMBtn.layer setMasksToBounds:YES];
//    [addMBtn.layer setCornerRadius:self.view.frame.size.height*0.09/2];
//    [addMBtn.layer setShadowColor:[UIColor blackColor].CGColor];
//    [addMBtn.layer setShadowOffset:CGSizeMake(10, 10)];
//    [addMBtn.layer setShadowOpacity:YES];
    
    [addMBtn addTarget:self action:@selector(addMail) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:addMBtn];
    
    
    
}




//點選選擇成員
-(void)selectmemberBtnClick{
    
    UIViewController *EditMemberController = [[UIViewController alloc ]init];
    EditMemberController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMemberController"];
    //ProfileV.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    EditMemberController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:EditMemberController animated:nil completion:nil];
    
    
}




-(void)gobackSetting{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)addMail{
    
    UIViewController *AddMailNotification = [[UIViewController alloc ]init];
    AddMailNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"AddMailNotification"];
    
    AddMailNotification.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:AddMailNotification animated:true completion:nil];


}


-(void)maileTableView{
    
    self.MailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.09, self.view.frame.size.width, self.view.frame.size.height*0.91)];
    
    self.MailTableView.delegate = self;
    self.MailTableView.dataSource = self;
    
    [self.view addSubview:self.MailTableView];
    
    
    [self.MailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mailcell"];
    
    
    
    
    
}

#pragma mark - 跳轉下一頁的方法
//-(void)nextPage
//{
//    EditMailNotificationViewController *editV = [[EditMailNotificationViewController alloc] init];
//    editV.str = self.str;
//    [self.navigationController pushViewController:editV animated:YES];
//    
//  
//}

#pragma mark - 代理方法  顯示選中行的單元格信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.person[indexPath.row]);
    
   // self.str=self.person[indexPath.row];
    EditMailNotificationViewController *editV = [[EditMailNotificationViewController alloc]init];
    editV = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMailNotificationViewController"];
    editV.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    editV.editNameTextField.text = self.person[indexPath.row];
    
  //  editV.str = self.str;
    editV.delegate = self;
    
    self.number=(int)indexPath.row;
    
    [self presentViewController:editV animated:true completion:nil];
    //[self.navigationController pushViewController:editV animated:YES];
}

#pragma mark - 設置顯示分區數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 數據源 每個分區對應的函數設置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return memberArray.count;
}

#pragma mark - 數據源 每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentity=@"mailcell";
    UITableViewCell *mailcell=[tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
  //  mailcell.textLabel.text = memberArray[indexPath.row];
    
    return mailcell;
    
//    static NSString *CellIdentifier = @"cellMember";
//    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        //cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MemberCell"owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//        
//        cell.MemberL.text = self.person[indexPath.row];
//        cell.checkboxBtn.tag = (int)indexPath.row;
//       // [cell.checkboxBtn addTarget:self action:@selector(memberselect:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//    return cell;
}



#pragma mark - 實現代理的方法
-(void)postValue:(NSString *)str
{
    [self.person replaceObjectAtIndex:self.number withObject:str];
    [self.MailTableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height*0.7/10 ;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"mailcell"])
//    {
//        NSIndexPath *indexPath = (NSIndexPath *)sender;
//        EditMailNotificationViewController *editV = segue.destinationViewController;
//        editV.str = [mailItem objectAtIndex:indexPath.row];
//    }
    
    
}





@end

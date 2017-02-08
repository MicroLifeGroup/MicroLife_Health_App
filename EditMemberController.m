//
//  EditMemberController.m
//  Microlife
//
//  Created by Ideabus on 2016/10/4.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EditMemberController.h"

@interface EditMemberController (){
    
    NSMutableArray *MyMember_Array;
    
}

@end



@implementation EditMemberController{
   
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TABLE_BACKGROUND;

    self.person=[NSMutableArray array];
    for (int i=1; i<15; i++) {
       // [self.person addObject:[NSString stringWithFormat:@"第%d個聯繫人",i]];
    }
    
    [self editmailTableView];
    
    //mailItem = [["1","2"],[],[],[],[]];
    
    
    [self editmailnotificationnav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editmailnotificationnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Edit";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navcancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navcancelBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navcancelBtn setImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal ];
    navcancelBtn.backgroundColor = [UIColor clearColor];
    navcancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [navcancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navcancelBtn];
    
    UIButton *navdeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navdeleteBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.017, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navdeleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [navdeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navdeleteBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    navdeleteBtn.backgroundColor = [UIColor clearColor];
    navdeleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [navdeleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navdeleteBtn];
    
    
    
}




//點選選擇成員
-(void)deleteBtnClick{
    
    
   [self.presentingViewController dismissViewControllerAnimated:nil completion:NULL];
    
}




-(void)cancelBtnClick{
    
    [self.presentingViewController dismissViewControllerAnimated:nil completion:NULL];
    
}




-(void)editmailTableView{
    
    self.MailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.09, self.view.frame.size.width, self.view.frame.size.height*0.91)];
    
    self.MailTableView.delegate = self;
    self.MailTableView.dataSource = self;
    
    [self.view addSubview:self.MailTableView];
    
    
    [self.MailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mailcell"];
    
    
    
    
    
}

//#pragma mark - 跳轉下一頁的方法
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
    
    //  [self performSegueWithIdentifier:@"mailcell" sender:indexPath];
    
    self.str=self.person[indexPath.row];
    EditMailNotificationViewController *editV = [[EditMailNotificationViewController alloc]init];
    editV.str = self.str;
    editV.delegate = self;
    
    self.number=(int)indexPath.row;
    
    [self.navigationController pushViewController:editV animated:YES];
}

#pragma mark - 設置顯示分區數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 數據源 每個分區對應的函數設置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.person.count;
}

#pragma mark - 數據源 每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *cellIdentity=@"mailcell";
    //    UITableViewCell *mailcell=[tableView dequeueReusableCellWithIdentifier:cellIdentity forIndexPath:indexPath];
    //    mailcell.textLabel.text=self.person[indexPath.row];
    //
    //    return mailcell;
    
    static NSString *CellIdentifier = @"cellMember";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MemberCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        cell.MemberL.text = self.person[indexPath.row];
       // cell.checkboxBtn.tag = (int)indexPath.row;
        // [cell.checkboxBtn addTarget:self action:@selector(memberselect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

-(void)memberselect:(UIButton*)sender{
    
    NSLog(@"I Clicked a button %ld",(long)sender.tag);
    
}





#pragma mark - 實現代理的方法
-(void)postValue:(NSString *)stringp
{
  //  [self.person replaceObjectAtIndex:self.number withObject:stringp];
    [self.MailTableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height*0.7/10 ;
}



//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"mailcell"])
//    {
//        NSIndexPath *indexPath = (NSIndexPath *)sender;
//        EditMailNotificationViewController *editV = segue.destinationViewController;
//        editV.str = [mailItem objectAtIndex:indexPath.row];
//    }
//}
//
//



@end

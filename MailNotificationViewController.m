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
    
    //NSArray *MyMemberArray;
    NSMutableArray *MyMemberArray;
    NSMutableArray *deleteArr;
    
}



@end

@implementation MailNotificationViewController{
    
}

@synthesize MailTableView;
@synthesize str;
@synthesize person;
@synthesize MailNotificationTableView;
@synthesize nameString,emailString;
@synthesize navSelectBtn_isSelected;

static NSString *cellIdentity = @"mailcell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = TABLE_BACKGROUND;
    
    
//    MyMemberArray = [[NSDictionary alloc] initWithObjectsAndKeys:       nameString,@"name",
//        emailString,@"email",nil];
    
    
    
    
    
//    MyMemberArray = @[@{@"name":@"Eva",@"email":@"eva@gmail.com"},
//                       @{@"name":@"Hsuan",@"email":@"hsuan@gmail.com"},
//                       @{@"name":@"Ellie",@"email":@"ellie@gmail.com"},
//                       @{@"name":@"Mary",@"email":@"mary@gmail.com"},
//                       @{@"name":@"Simple",@"email":@"simple@gmail.com"}];
    
    
    
    [self addBtn];
    
    [MailTableView reloadData];
    
    
    [self mailnotificationnav];
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"[LocalData sharedInstance] returnMemberProfile] = %@",[[LocalData sharedInstance] returnMemberProfile]);
    
    MyMemberArray = [[LocalData sharedInstance] returnMemberProfile];
                     
    [MailTableView reloadData];
    
    [self memberTableView];
    
    [self initParameter];
    
    NSLog(@"目前的成員資料有%@",MyMemberArray);
    NSLog(@"目前的成員資料有%lu筆",(unsigned long)MyMemberArray.count);
  
    
    
}

-(void)initParameter{
    
    //MyMemberArray = [[NSDictionary alloc] init];
    tableviewSelectTag = [NSMutableArray new];
    navSelectBtn_isSelected = 0;
    deleteArr = [[NSMutableArray alloc] init];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)memberTableView{
    
    //int tableviewH = (int)MyMemberArray.count;
    
    
    UIView *mnview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    mnview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mnview];
    
    
    self.MailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.09, self.view.frame.size.width, self.view.frame.size.height*0.91)];
    self.MailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.MailTableView.delegate = self;
    self.MailTableView.dataSource = self;
    //self.MailTableView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.MailTableView];
    
    
    [self.MailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mailcell"];
    
    [MailTableView registerNib:[UINib nibWithNibName:@"MemberCell" bundle:nil] forCellReuseIdentifier:@"select_Cellid"];
    
    
    [self tableviewline];
    
    [MailTableView reloadData];
    
    
}

-(void)tableviewline{
    
    for (int i = 0; i <= MyMemberArray.count; i++) {
        
        if (i == 0) {
            
            
        }else{
            
            memberline = [[UIView alloc] initWithFrame:CGRectMake(0,53*i, self.view.frame.size.width, 1)];
            memberline.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0];
            [self.MailTableView addSubview:memberline];
            
            
            
        }
        
        NSLog(@"MyMemberArray count === %d",i);
        
    }

    
    [MailTableView reloadData];
    
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
   
    if (navSelectBtn_isSelected == 0) {
        // self.str=self.person[indexPath.row];
        EditMailNotificationViewController *editV = [[EditMailNotificationViewController alloc]init];
        editV = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMailNotificationViewController"];
        editV.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        NSString *name = [NSString stringWithFormat:@"%@",[[MyMemberArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        NSString *email = [NSString stringWithFormat:@"%@",[[MyMemberArray objectAtIndex:indexPath.row] objectForKey:@"email"]];
        
        
        editV.editNameStr = name;
        editV.editEmailStr = email;
        editV.editIndex = indexPath.row;
        editV.delegate = self;
        
        self.number=(int)indexPath.row;
        
        [self presentViewController:editV animated:true completion:nil];
        //[self.navigationController pushViewController:editV animated:YES];
        
    }else if (navSelectBtn_isSelected == 1){
        
        NSString *selectStr;
        
        BOOL selected = [[tableviewSelectTag objectAtIndex:indexPath.row] boolValue];
        selected = !selected;
        selectStr = [NSString stringWithFormat:@"%d",selected];
        [tableviewSelectTag replaceObjectAtIndex:indexPath.row withObject:selectStr];
        
        if (selected) {
            [deleteArr addObject:[MyMemberArray objectAtIndex:indexPath.row]];
            [deleteArr addObject:[tableviewSelectTag objectAtIndex:indexPath.row]];
            
            

        }else if (!selected){
             [deleteArr removeObject:[MyMemberArray objectAtIndex:indexPath.row]];
             [deleteArr removeObject:[tableviewSelectTag objectAtIndex:indexPath.row]];
            
            
            
        }
        
        
        //MailTableView.editing = !MailTableView.editing;
        
    }
    
     [MailTableView reloadData];
   
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [deleteArr removeObject:[MyMemberArray objectAtIndex:indexPath.row]];
    
    [MailTableView reloadData];
    
}



#pragma mark - 設置顯示分區數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - 數據源 每個分區對應的函數設置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"%lu",(unsigned long)MyMemberArray.count);
    return MyMemberArray.count;
}

#pragma mark - 數據源 每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *mailcell;
    NSString *name = [NSString stringWithFormat:@"%@",[[MyMemberArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    
    
    
    for (int i=0; i<MyMemberArray.count; i++) {
        
        NSString *selectStr = @"0";
        
        [tableviewSelectTag addObject:selectStr];
        
    }
    
    
    if (navSelectBtn_isSelected == 0) {
        
        if (mailcell == nil) {
            
            mailcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            NSLog(@"MyMemberArray ==== %@",MyMemberArray);
            
            
        }
        
        
        MailTableView.allowsMultipleSelectionDuringEditing = NO;
        mailcell.textLabel.font = [UIFont systemFontOfSize:22];
        mailcell.textLabel.text = name;
        

    }else if (navSelectBtn_isSelected == 1){
        
        MailTableView.allowsMultipleSelectionDuringEditing = YES;
        MemberCell *selectcell = [tableView dequeueReusableCellWithIdentifier:@"select_Cellid" forIndexPath:indexPath];
        selectcell.MemberL.text = name;
        
        
        BOOL selected = [[tableviewSelectTag objectAtIndex:indexPath.row] boolValue];
        selectcell.checkBox.image = [UIImage imageNamed:@"all_select_a_0"];
        
        if (selected) {
            selectcell.checkBox.image = [UIImage imageNamed:@"all_select_a_1"];
        }
        
        
        if (selectcell == nil) {
            
            
        }
        
        return selectcell;
        
        
    }
    
    
   
    
    //  mailcell.textLabel.text = memberArray[indexPath.row];
    
    //
    //    NSString *providerNameString = [self.providersDict objectForKey:@"provider"];
    //    NSString *providerIdString = [self.providersDict objectForKey:@"object"];
    //    cell.textLabel.text  = providerNameString;
    //    cell.detailTextLabel.text  = providerIdString;
    
    
    
    
    
    return mailcell;
    
    
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}






#pragma mark - 實現代理的方法
-(void)postValue:(NSString *)str
{
    //[self.person replaceObjectAtIndex:self.number withObject:str];
    [self.MailTableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53 ;
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

-(void)mailnotificationnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.navigationController.view addSubview:pnavview];
    //pnavview.hidden = YES;
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Mail Notification";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [pnavview addSubview:pnavLabel];
    
    
    navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_back"] forState:UIControlStateNormal ];
    navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [navbackBtn addTarget:self action:@selector(gobackSetting) forControlEvents:UIControlEventTouchUpInside];
    [pnavview addSubview:navbackBtn];
    
    
    navcancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navcancelBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navcancelBtn setImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal ];
    navcancelBtn.backgroundColor = [UIColor clearColor];
    navcancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [navcancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navcancelBtn.hidden = YES;
    [pnavview addSubview:navcancelBtn];
    
    
    navselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navselectBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.017, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navselectBtn setTitle:@"Select" forState:UIControlStateNormal];
    [navselectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navselectBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    navselectBtn.backgroundColor = [UIColor clearColor];
    navselectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [navselectBtn addTarget:self action:@selector(selectmemberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pnavview addSubview:navselectBtn];
    
    
    navdeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navdeleteBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.017, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navdeleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [navdeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navdeleteBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    navdeleteBtn.backgroundColor = [UIColor clearColor];
    navdeleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    navdeleteBtn.hidden = YES;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [navdeleteBtn addTarget:self action:@selector(deletememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pnavview addSubview:navdeleteBtn];
    
    
    
    
}

-(void)addBtn{
    
    addMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMBtn.frame = CGRectMake((self.view.frame.size.width-self.view.frame.size.height*0.09)*0.95, self.view.frame.size.height*0.87, self.view.frame.size.height*0.09, self.view.frame.size.height*0.09);
    [addMBtn setImage:[UIImage imageNamed:@"overview_btn_a_add_s"] forState:UIControlStateNormal ];
    
    addMBtn.backgroundColor = [UIColor clearColor];
    addMBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [addMBtn addTarget:self action:@selector(addMail) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.view addSubview:addMBtn];
    
    
    // [addMBtn.superview bringSubviewToFront:addMBtn];
    
}


//點選選擇成員
-(void)selectmemberBtnClick{
    
    pnavLabel.text = @"Edit";
    navbackBtn.hidden = YES;
    navselectBtn.hidden = YES;
    navdeleteBtn.hidden = NO;
    navcancelBtn.hidden = NO;
    addMBtn.hidden = YES;
    
    navSelectBtn_isSelected = 1;
    
    //[MailTableView setEditing:YES];
    [MailTableView reloadData];
    
    //    UIViewController *EditMemberController = [[UIViewController alloc ]init];
    //    EditMemberController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMemberController"];
    //    //ProfileV.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //    EditMemberController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //
    //    [self presentViewController:EditMemberController animated:nil completion:nil];
    
    
}

-(void)deletememberBtnClick:(UIButton *) button{
    
   // [MailTableView setEditing:YES];
    
    [MyMemberArray removeObjectsInArray:deleteArr];
    [tableviewSelectTag removeObjectsInArray:deleteArr];
    
    [memberline removeFromSuperview];
    
    for (int j = 0; j <= MyMemberArray.count; j++) {

        if (j == 0) {
            
        }else{
            [self tableviewline];
        }
        
    }
    
    [MailTableView reloadData];
    
//    [[LocalData sharedInstance] deleteMember:<#(NSDictionary *)#> atIndexPath:<#(int)#>]
//    [[LocalData sharedInstance] editMemberProfile:memberDict atIndexPath:self.editIndex];
//
    
    if (MailTableView.editing) {
        
        //删除
        
        
        
    }
    
    else return;
    
    
    
    
}

-(void)cancelBtnClick{
    
    pnavLabel.text = @"Mail Notification";
    navbackBtn.hidden = NO;
    navselectBtn.hidden = NO;
    navdeleteBtn.hidden = YES;
    navcancelBtn.hidden = YES;
    addMBtn.hidden = NO;
    
    navSelectBtn_isSelected = 0;
    [MailTableView reloadData];
    
    
    
    
    NSLog(@"deleteArr===%@",deleteArr);
    NSLog(@"LocalDate = = =%@",[[LocalData sharedInstance] returnMemberProfile]);
    
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



@end

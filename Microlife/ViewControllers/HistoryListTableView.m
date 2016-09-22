//
//  HistoryListTableView.m
//  Microlife
//
//  Created by Rex on 2016/8/30.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "HistoryListTableView.h"
#import "BPTableViewCell.h"
#import "WeightTableViewCell.h"
#import "BodyTempTableViewCell.h"

@implementation HistoryListTableView

@synthesize historyList,hideListBtn;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParameter];
        [self initInterface];
    }
    return self;
}

-(void)initParameter{
    if(IS_IPHONE_5){
        imgScale = 2.2;
    }else if(IS_IPHONE_6){
        imgScale = 2;
    }else if(IS_IPHONE_6P){
        imgScale = 1.75;
    }else{
        imgScale = 2.5;
    }

}

-(void)initInterface{
    
    self.backgroundColor = [UIColor whiteColor];
    
    float downListIconSize = 41/imgScale;
    
    //顯示歷史列表按鈕
    //hideListBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height*0.06)];
    
    hideListBtn = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height*0.06)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideListAction)];
    
    tapGesture.numberOfTapsRequired = 1;
    [hideListBtn addGestureRecognizer:tapGesture];
    
    [self addSubview:hideListBtn];
    
    historyList = [[UITableView alloc] initWithFrame:CGRectMake(0, hideListBtn.frame.origin.y+hideListBtn.frame.size.height, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    historyList.delegate = self;
    historyList.dataSource = self;
    historyList.separatorStyle = UITableViewCellSeparatorStyleNone;
    historyList.backgroundColor = [UIColor whiteColor];
    //historyList.allowsSelection = NO;
    
    [self addSubview:historyList];
    
    //列表向上箭頭icon
    UIImageView *downIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-downListIconSize/2, hideListBtn.frame.origin.y, downListIconSize, downListIconSize)];
    downIcon.image = [UIImage imageNamed:@"all_icon_a_arrow_down"];
    
    [self addSubview:downIcon];
    [self sendSubviewToBack:downIcon];
}

-(void)hideListAction{
    
    [self.delegate hideListButtonTapped];
    
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        //
    }];
    
}

#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 0;
    
    switch (self.listType) {
        case 0:
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7) {
                rowHeight = 120;
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                rowHeight = 150;
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                rowHeight = 170;
            }
            
            //120
            //150
            //170
            
            //record 20
            //image 30
            break;
        case 1:
            
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7) {
                rowHeight = 190;
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                rowHeight = 210;
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                rowHeight = 230;
            }
            break;
        case 2:
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7) {
                rowHeight = 120;
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                rowHeight = 150;
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                rowHeight = 170;
            }
    
            break;
        default:
            break;
    }
    
    
    return rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier;
    
    
    UITableViewCell *cell;
    
    switch (self.listType) {
        case 0:{
            identifier = @"BPCell";
            
            BPTableViewCell *BPCell;
            
            if (BPCell == nil) {
                BPCell = [[BPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UIImage *typeImage = [UIImage imageNamed:@"history_icon_a_list_bpm"];
            
            if (indexPath.row == 0) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_bpm_r"];
                BPCell.decorateLine.backgroundColor = CIRCEL_RED;
            }
            
            if (indexPath.row == 1) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_pad_r"];
                BPCell.decorateLine.backgroundColor = CIRCEL_RED;
            }
            
            if (indexPath.row == 3) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_pad"];
                BPCell.decorateLine.backgroundColor = TEXT_COLOR;
            }
            
            if (indexPath.row == 5) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_afib_r"];
                BPCell.decorateLine.backgroundColor = CIRCEL_RED;
            }
            
            if (indexPath.row == 7) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_afib"];
                BPCell.decorateLine.backgroundColor = TEXT_COLOR;
            }
            
            if (indexPath.row == 4 || indexPath.row == 7) {
                
                BPCell.hasRecord = YES;
                
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                
                BPCell.hasImage = YES;
                
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                
                BPCell.hasRecord = YES;
                BPCell.hasImage = YES;
            }
            
            BPCell.typeImage.image = typeImage;
            
            return BPCell;
        }
            
            break;
        case 1:{
            
            identifier = @"WeightCell";
            
            WeightTableViewCell *weightCell;
            
            if (weightCell == nil) {
                weightCell = [[WeightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UIImage *typeImage = [UIImage imageNamed:@"history_icon_a_list_ws"];
            
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_ws_r"];
                weightCell.decorateLine.backgroundColor = CIRCEL_RED;
            }
            
            
            if (indexPath.row == 4 || indexPath.row == 7) {
                
                weightCell.hasRecord = YES;
                
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                
                weightCell.hasImage = YES;
                
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                
                weightCell.hasRecord = YES;
                weightCell.hasImage = YES;
            }
            
            weightCell.typeImage.image = typeImage;
            
            return weightCell;
        }
            
        
            break;
        case 2:{
            identifier = @"TempCell";
            
            BodyTempTableViewCell *BDTempCell;
            
            if (BDTempCell == nil) {
                BDTempCell = [[BodyTempTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UIImage *typeImage = [UIImage imageNamed:@"history_icon_a_list_ncfr"];
            
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7) {
                typeImage = [UIImage imageNamed:@"history_icon_a_list_ncfr_r"];
                BDTempCell.decorateLine.backgroundColor = CIRCEL_RED;
            }
            
            
            if (indexPath.row == 4 || indexPath.row == 7) {
                
                BDTempCell.hasRecord = YES;
                
            }
            
            if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8) {
                
                BDTempCell.hasImage = YES;
                
            }
            
            if (indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9) {
                
                BDTempCell.hasRecord = YES;
                BDTempCell.hasImage = YES;
            }
            
            BDTempCell.typeImage.image = typeImage;
            

            
            BDTempCell.frame = CGRectMake(BDTempCell.frame.origin.x, BDTempCell.frame.origin.y, self.frame.size.width, BDTempCell.frame.size.height);
            
            return BDTempCell;
        }
            
            break;
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showEditVC" object:nil];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

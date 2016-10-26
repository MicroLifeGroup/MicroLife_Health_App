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

#define IMAGE_BPM [UIImage imageNamed:@"history_icon_a_list_bpm"];
#define IMAGE_BPM_RED [UIImage imageNamed:@"history_icon_a_list_bpm_r"];
#define IMAGE_PAD [UIImage imageNamed:@"history_icon_a_list_pad"];
#define IMAGE_PAD_RED [UIImage imageNamed:@"history_icon_a_list_pad_r"];
#define IMAGE_AFIB [UIImage imageNamed:@"history_icon_a_list_afib"];
#define IMAGE_AFIB_RED [UIImage imageNamed:@"history_icon_a_list_afib_r"];
#define IMAGE_WEIGHT [UIImage imageNamed:@"history_icon_a_list_ws"];
#define IMAGE_WEIGHT_RED [UIImage imageNamed:@"history_icon_a_list_ws_r"];
#define IMAGE_TEMP_NORMAL [UIImage imageNamed:@"history_icon_a_list_ncfr"];
#define IMAGE_FEVER [UIImage imageNamed:@"history_icon_a_list_ncfr_r"];

@implementation HistoryListTableView

@synthesize historyList,hideListBtn,listDataArray;

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
    
    //listDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    listDataArray = [[LocalData sharedInstance] getListData];
    
    NSLog(@"listDataArray = %@",listDataArray);
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
    
    return listDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 0;
    
    NSDictionary *cellDict = [listDataArray objectAtIndex:indexPath.row];
    
    NSString *photoPath = [cellDict objectForKey:@"photoPath"];
    //NSString *note = [cellDict objectForKey:@"note"];
    NSString *recordingPath = [cellDict objectForKey:@"recordingPath"];
    
    switch (self.listType) {
        case 0:
            
            if (![photoPath isEqualToString:@""]) {
                
                if (![recordingPath isEqualToString:@""]) {
                    rowHeight = 170;
                }else{
                    rowHeight = 150;
                }
                
            }else{
                rowHeight = 120;
            }
            
            //120
            //150
            //170
            
            //record 20
            //image 30
            break;
        case 1:
            
            if (![photoPath isEqualToString:@""]) {
                
                if (![recordingPath isEqualToString:@""]) {
                    rowHeight = 230;
                }else{
                    rowHeight = 210;
                }
                
            }else{
                rowHeight = 190;
            }
            
            break;
        case 2:
            
            if (![photoPath isEqualToString:@""]) {
                
                if (![recordingPath isEqualToString:@""]) {
                    rowHeight = 170;
                }else{
                    rowHeight = 150;
                }

            }else{
                rowHeight = 120;
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
    
    NSDictionary *cellDict = [listDataArray objectAtIndex:indexPath.row];
    
    NSString *photoPath = [cellDict objectForKey:@"photoPath"];
    NSString *note = [cellDict objectForKey:@"note"];
    NSString *recordingPath = [cellDict objectForKey:@"recordingPath"];
    
    BOOL hasImg = NO;
    BOOL hasRecord = NO;
    
    if (![photoPath isEqualToString:@""]) {
        hasImg = YES;
    }
    
    if (![recordingPath isEqualToString:@""]) {
        hasRecord = YES;
    }
    
    if ([note isEqualToString:@""]) {
        note = @"note...";
    }
    
    switch (self.listType) {
        case 0:{
            identifier = @"BPCell";
            
            BPTableViewCell *BPCell;
            
            if (BPCell == nil) {
                BPCell = [[BPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            int SYSValue = [[cellDict objectForKey:@"SYS"] intValue];
            int DIAValue = [[cellDict objectForKey:@"DIA"] intValue];
            int PULValue = [[cellDict objectForKey:@"PUL"] intValue];
            BOOL detecAFIB = [[cellDict objectForKey:@"AFIB"] boolValue];
            BOOL detecPAD = [[cellDict objectForKey:@"PAD"] boolValue];
            BOOL highSYS = NO;
            BOOL highDIA = NO;
            
            
            UIImage *typeImage = IMAGE_BPM;
            UIColor *lineColor = STANDER_COLOR;
            
            if (SYSValue > 135) {
                highSYS = YES;
                typeImage = IMAGE_BPM_RED;
                lineColor = CIRCEL_RED;
            }
            
            if (DIAValue > 85) {
                highDIA = YES;
                typeImage = IMAGE_BPM_RED;
                lineColor = CIRCEL_RED;
            }
            
            if (detecPAD){
                
                if (highDIA || highSYS) {
                    typeImage = IMAGE_PAD_RED;
                    lineColor = CIRCEL_RED;
                }else{
                    typeImage = IMAGE_PAD;
                    lineColor = TEXT_COLOR;
                }
            }
            
            if (detecAFIB) {
                
                if (highSYS || highDIA) {
                    lineColor = CIRCEL_RED;
                    typeImage = IMAGE_AFIB_RED;
                }else{
                    typeImage = IMAGE_AFIB;
                    lineColor = TEXT_COLOR;
                }
                
            }
            
            if (highSYS) {
                BPCell.SYSValueLabel.textColor = CIRCEL_RED;
            }
            
            if (highDIA) {
                BPCell.DIAValueLabel.textColor = CIRCEL_RED;
            }
            
            BPCell.decorateLine.backgroundColor = lineColor;
            
            BPCell.SYSValueLabel.text = [NSString stringWithFormat:@"%d",SYSValue];
            BPCell.DIAValueLabel.text = [NSString stringWithFormat:@"%d",DIAValue];
            BPCell.PULValueLabel.text = [NSString stringWithFormat:@"%d",PULValue];
            BPCell.noteTextView.text = note;
            BPCell.timeLabel.text = [cellDict objectForKey:@"date"];
            BPCell.hasImage = hasImg;
            BPCell.hasRecord = hasRecord;
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
            UIImage *typeImage = IMAGE_WEIGHT;
            UIColor *lineColor = STANDER_COLOR;
            
            
            float weight = [[cellDict objectForKey:@"weight"] floatValue];
            float BMI = [[cellDict objectForKey:@"BMI"] floatValue];
            float bodyFat = [[cellDict objectForKey:@"bodyFat"] floatValue];
            float water = [[cellDict objectForKey:@"water"] floatValue];
            float skeleton = [[cellDict objectForKey:@"skeleton"] floatValue];
            float muscle = [[cellDict objectForKey:@"muscle"] floatValue];
            float BMR = [[cellDict objectForKey:@"BMR"] floatValue];
            float organFat = [[cellDict objectForKey:@"organFat"] floatValue];
            
            if (BMI > [LocalData sharedInstance].standerBMI) {
                typeImage = IMAGE_WEIGHT_RED;
                lineColor = CIRCEL_RED;
                weightCell.BMIValue.textColor = CIRCEL_RED;
            }
            
            if (bodyFat > [LocalData sharedInstance].standerFat) {
                typeImage = IMAGE_WEIGHT_RED;
                lineColor = CIRCEL_RED;
                weightCell.bodyFatValue.textColor = CIRCEL_RED;
            }
            
            weightCell.hasImage = hasImg;
            weightCell.hasRecord = hasRecord;
            
            weightCell.weightValue.text = [NSString stringWithFormat:@"%.1f",weight];
            weightCell.BMIValue.text = [NSString stringWithFormat:@"%.1f",BMI];
            weightCell.bodyFatValue.text = [NSString stringWithFormat:@"%.1f",bodyFat];
            weightCell.waterValue.text = [NSString stringWithFormat:@"%.1f",water];
            weightCell.skeletonValue.text = [NSString stringWithFormat:@"%.1f",skeleton];
            weightCell.muscleValue.text = [NSString stringWithFormat:@"%.1f",muscle];
            weightCell.BMRValue.text = [NSString stringWithFormat:@"%.1f",BMR];
            weightCell.organFatVlaue.text = [NSString stringWithFormat:@"%.1f",organFat];
            weightCell.noteTextView.text = note;
            weightCell.timeLabel = [cellDict objectForKey:@"date"];
            
            
            return weightCell;
        }
            
        
            break;
        case 2:{
            identifier = @"TempCell";
            
            BodyTempTableViewCell *BDTempCell;
            
            if (BDTempCell == nil) {
                BDTempCell = [[BodyTempTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            float bodyTemp = [[cellDict objectForKey:@"bodyTemp"] floatValue];
            float roomTemp = [[cellDict objectForKey:@"roomTemp"] floatValue];
            
            UIImage *typeImage = IMAGE_TEMP_NORMAL;
            
            if (bodyTemp >= 37.5) {
                typeImage = IMAGE_FEVER;
                BDTempCell.decorateLine.backgroundColor = CIRCEL_RED;
                BDTempCell.bodyTempValue.textColor = CIRCEL_RED;
            }
            
            BDTempCell.hasImage = hasImg;
            BDTempCell.hasRecord = hasRecord;
            
            BDTempCell.typeImage.image = typeImage;
            BDTempCell.bodyTempValue.text = [NSString stringWithFormat:@"%.1f",bodyTemp];
            BDTempCell.roomTempValue.text = [NSString stringWithFormat:@"%.1f",roomTemp];
            BDTempCell.noteTextView.text = note;
            BDTempCell.timeLabel.text = [cellDict objectForKey:@"date"];
            
            //BDTempCell.frame = CGRectMake(BDTempCell.frame.origin.x, BDTempCell.frame.origin.y, self.frame.size.width, BDTempCell.frame.size.height);
            
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
    
    NSDictionary *listDict = [listDataArray objectAtIndex:indexPath.row];
    
    [[LocalData sharedInstance] setEditListDict:listDict];
    
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

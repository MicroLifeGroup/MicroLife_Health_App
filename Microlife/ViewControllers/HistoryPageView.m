//
//  HistoryPageView.m
//  Microlife
//
//  Created by Rex on 2016/7/27.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "HistoryPageView.h"


@implementation HistoryPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParameter];
        [self initInterface];
    }
    return self;
}

@synthesize chartView,healthStatusScroll,curveControlBase;

-(void)initParameter{
    
    screen = [UIScreen mainScreen];
    
    if(IS_IPHONE_5){
        imgScale = 2.2;
    }else if(IS_IPHONE_6){
        imgScale = 2;
    }else if(IS_IPHONE_6P){
        imgScale = 1.75;
    }else{
        imgScale = 2.5;
    }

    nameBtnAry = [[NSMutableArray alloc] initWithCapacity:0];
    circelSize = screen.bounds.size.width*0.3;
    dateIntervalIndex = 1;
}

-(void)initInterface{
    
    //Segment 底層
    segBase = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height*0.06)];
    segBase.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    
    
    CGFloat curveBtnSize = 41/imgScale;
    
    //時間Label
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.bounds.size.width/2-screen.bounds.size.width*0.533/2, segBase.frame.origin.y+segBase.frame.size.height+screen.bounds.size.height*0.01, screen.bounds.size.width*0.533, curveBtnSize)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = TEXT_COLOR;
    
    //上一圖表按鈕
    prevCurveBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeLabel.frame.origin.x-curveBtnSize, timeLabel.frame.origin.y , curveBtnSize, curveBtnSize)];
    [prevCurveBtn setImage:[UIImage imageNamed:@"all_icon_a_arrow_l"] forState:UIControlStateNormal];
    [prevCurveBtn addTarget:self action:@selector(prevCurveAction) forControlEvents:UIControlEventTouchUpInside];
    
    //下一圖表按鈕
    nextCurveBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeLabel.frame.origin.x+timeLabel.frame.size.width, timeLabel.frame.origin.y , curveBtnSize, curveBtnSize)];
    [nextCurveBtn setImage:[UIImage imageNamed:@"all_icon_a_arrow_r"] forState:UIControlStateNormal];
    [nextCurveBtn addTarget:self action:@selector(nextCurveAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //圖表顯示控制鈕底層
    curveControlBase = [[UIView alloc] initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+timeLabel.frame.size.height+screen.bounds.size.height*0.01, screen.bounds.size.width, screen.bounds.size.height*0.08)];
    
    //圖表Scroll
    chartView = [[UIView alloc] initWithFrame:CGRectMake(0,curveControlBase.frame.origin.y+curveControlBase.frame.size.height, screen.bounds.size.width, screen.bounds.size.height*0.28)];
    
    [self bringSubviewToFront:chartView];
    
    //未測量顯示區底層
    absentBase = [[UIView alloc] initWithFrame:CGRectMake(0, chartView.frame.origin.y+chartView.frame.size.height, screen.bounds.size.width, screen.bounds.size.height*0.041)];
    absentBase.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    
    float faceIconSize = 40/imgScale;
    
    //未測量label
    absentLabel = [[UILabel alloc] initWithFrame:CGRectMake(absentBase.frame.size.width/2-screen.bounds.size.width*0.31/2+faceIconSize, absentBase.frame.size.height/2-faceIconSize/2, screen.bounds.size.width*0.4, faceIconSize)];
    
    absentLabel.text = @"";
    absentLabel.textColor = TEXT_COLOR;
    absentLabel.font = [UIFont systemFontOfSize:15.0];
    
     //未測量icon圖示
    absentFace = [[UIImageView alloc] initWithFrame:CGRectMake(absentLabel.frame.origin.x-faceIconSize-5, absentBase.frame.size.height/2-faceIconSize/2, faceIconSize, faceIconSize)];
    
    absentFace.image = nil;
    
    //測量異常結果scroll
    healthStatusScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, absentBase.frame.origin.y+absentBase.frame.size.height, screen.bounds.size.width, screen.bounds.size.height*0.22)];

    [healthStatusScroll setPagingEnabled:NO];
    [healthStatusScroll setShowsHorizontalScrollIndicator:NO];
    [healthStatusScroll setShowsVerticalScrollIndicator:NO];
    [healthStatusScroll setScrollsToTop:NO];
    [healthStatusScroll setDelegate:self];
    
    float upListIconSize = 41/imgScale;
    
    //顯示歷史列表按鈕
    showListBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-screen.bounds.size.height*0.06, screen.bounds.size.width, screen.bounds.size.height*0.06)];
    showListBtn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:14.0];
    
    [showListBtn addTarget:self action:@selector(showListAction) forControlEvents:UIControlEventTouchUpInside];
    [showListBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    
    //分隔線
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, showListBtn.frame.origin.y-1, screen.bounds.size.width, 1)];
    lineView.backgroundColor = TEXT_COLOR;
    lineView.alpha = 0.5;
    
    //列表向上箭頭icon
    UIImageView *upIcon = [[UIImageView alloc] initWithFrame:CGRectMake(screen.bounds.size.width/2-upListIconSize/2, showListBtn.frame.origin.y-5, upListIconSize, upListIconSize)];
    upIcon.image = [UIImage imageNamed:@"all_icon_a_arrow_up"];
    
    
    [self lockNextCurveBtn];
    
    [self addSubview:timeLabel];
    [self addSubview:prevCurveBtn];
    [self addSubview:nextCurveBtn];
    [self addSubview:curveControlBase];
    [self addSubview:chartView];
    [self addSubview:absentBase];
    [absentBase addSubview:absentLabel];
    [absentBase addSubview:absentFace];
    [self addSubview:healthStatusScroll];
    [self addSubview:showListBtn];
    [self addSubview:lineView];
    [self addSubview:upIcon];
    
}

- (UIView *)snapshotViewWithInputView:(UIView *)inputView {
    
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    
    return snapshot;
}

-(void)showListAction{
    
    UIView *btnSnapShot = [self snapshotViewWithInputView:showListBtn];
    
    [self.delegate showListButtonTapped:btnSnapShot];
    
    int dataRange = 0;
    int dataCount = 0;
    
    //viewType 0=BloodPressure 1=Weight 2=Temperature
    
    NSLog(@"viewType = %d",self.viewType);
    if (self.viewType != 2) {
        switch (dateSegIndex) {
            case 0:
                dataRange = 1*dateIntervalIndex;
                dataCount = -1;
                break;
                
            case 1:
                dataRange = 7*dateIntervalIndex;
                dataCount = 7;
                break;
                
            case 2:
                dataRange = 30*dateIntervalIndex;
                dataCount = 30;
                break;
                
            case 3:
                dataRange = 12*dateIntervalIndex;
                dataCount = 12;
                break;
                
            default:
                break;
        }
    }else{
        
        switch (dateSegIndex) {
            case 0:
                dataRange = 1*dateIntervalIndex;
                dataCount = -1;
                break;
            case 1:
                dataRange = 4*dateIntervalIndex;
                dataCount = 4;
                break;
            case 2:
                dataRange = 24*dateIntervalIndex;
                dataCount = 24;
                
                break;
            default:
                break;
        }
        
    }
    
    NSNumber *postDataRange = [NSNumber numberWithInt:dataRange];
    NSNumber *postDataCount = [NSNumber numberWithInt:dataCount];
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                              postDataRange,@"dataRange",
                              postDataCount,@"dataCount", nil];
    
    switch (self.chartType) {
        case 0:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showBPList" object:nil userInfo:userInfo];
            
            break;
            
        case 1:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showWeightList" object:nil userInfo:userInfo];
            break;
            
        case 2:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showTempList" object:nil userInfo:userInfo];
            break;
            
        default:
            break;
    }

}


-(void)createChart:(int)chartType{
    
    NSInteger dataRange = 0;
    int dataCount = 0;
    
    if (chartType != 5) {
        switch (dateSegIndex) {
            case 0:
                dataRange = 1*dateIntervalIndex;
                dataCount = -1;
                break;
                
            case 1:
                dataRange = 7*dateIntervalIndex;
                dataCount = 7;
                break;
                
            case 2:
                dataRange = 30*dateIntervalIndex;
                dataCount = 30;
                break;
                
            case 3:
                dataRange = 12*dateIntervalIndex;
                dataCount = 12;
                break;
                
            default:
                break;
        }
    }else{
        
        switch (dateSegIndex) {
            case 0:
                dataRange = 1*dateIntervalIndex;
                dataCount = -1;
                break;
            case 1:
                dataRange = 4*dateIntervalIndex;
                dataCount = 4;
                break;
            case 2:
                dataRange = 24*dateIntervalIndex;
                dataCount = 24;
                
                break;
            default:
                break;
        }
        
    }
    
    chart = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, chartView.frame.size.width, chartView.frame.size.height) withChartType:chartType withDataCount:dataCount withDataRange:dataRange];
    
    chart.delegate = self;
    chart.indicatorMode = YES;
    chart.clipsToBounds = NO;
    
    [chartView addSubview:chart];
    
    [chartView bringSubviewToFront:chart];
}

-(void)setAbsentDaysText:(int)absentDays andFaceIcon:(UIImage *)iconImg{
    
    absentFace.image = iconImg;
    
    if (absentDays == 0) {
        absentLabel.text = @"";
        absentLabel.frame = CGRectZero;
        absentFace.frame = CGRectMake(absentBase.frame.size.width/2-absentFace.frame.size.width/2, absentFace.frame.origin.y, absentFace.frame.size.width, absentFace.frame.size.height);
        
    }else{
        absentLabel.text = [NSString stringWithFormat:@"Lasts %d days absent",absentDays];
        
        absentLabel.adjustsFontSizeToFitWidth = YES;
        
        absentLabel.frame = CGRectMake(absentBase.frame.size.width/2-absentLabel.frame.size.width/2+absentFace.frame.size.width, absentLabel.frame.origin.y, absentLabel.frame.size.width, absentLabel.frame.size.height);
        
        absentFace.frame = CGRectMake(absentLabel.frame.origin.x-absentFace.frame.size.width-5, absentFace.frame.origin.y, absentFace.frame.size.width, absentFace.frame.size.height);
    }
}

#pragma mark - BP Button and actions
-(void)initBPCurveControlButton{
    
    float BPTimeSize = 63/imgScale;
    
    [showListBtn setTitle:@"YOUR BLOOD PRESSURE LISTS" forState:UIControlStateNormal];
    
    BPTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, curveControlBase.frame.size.height/2-BPTimeSize/2-4, BPTimeSize, BPTimeSize)];
    
    [BPTimeBtn setImage:[UIImage imageNamed:@"history_icon_a_all"] forState:UIControlStateNormal];
    [BPTimeBtn addTarget:self action:@selector(switchBPCurveTime) forControlEvents:UIControlEventTouchUpInside];
    
    BPCurveTime = 0;
    
    float btnWidth = screen.bounds.size.width*0.22;
    
    SYSBtn = [[UIButton alloc] initWithFrame:CGRectMake(curveControlBase.frame.size.width/2-btnWidth-5, curveControlBase.frame.size.height/2-BPTimeSize/2, btnWidth, screen.bounds.size.height*0.041)];
    
    [SYSBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [SYSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SYSBtn setTitle:@"SYS/DIA" forState:UIControlStateNormal];
    [SYSBtn addTarget:self action:@selector(SYSBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    PULBtn = [[UIButton alloc] initWithFrame:CGRectMake(curveControlBase.frame.size.width/2+5, curveControlBase.frame.size.height/2-BPTimeSize/2, btnWidth, screen.bounds.size.height*0.041)];
    
    [PULBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [PULBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    [PULBtn setTitle:@"PUL" forState:UIControlStateNormal];
    [PULBtn addTarget:self action:@selector(PULBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [curveControlBase addSubview:BPTimeBtn];
    [curveControlBase addSubview:SYSBtn];
    [curveControlBase addSubview:PULBtn];
    
    [self createChart:0];
}

-(void)switchBPCurveTime{
    
    UIImage *BPTimeImage;
    
    switch (BPCurveTime) {
        case 0:
            BPTimeImage = [UIImage imageNamed:@"history_icon_a_all"];
            [BPCircle setCircleTitleText:@"ALL\nAvg.SYS/DIA"];
            [BPCircle setcircleValueText:@"150/90"];
            [BPCircle setCircleUnitText:@"mmHg"];
            
            [BPCircle setCircleValueFrame];
            break;
            
        case 1:
            BPTimeImage = [UIImage imageNamed:@"history_icon_a_am"];
            [BPCircle setCircleTitleText:@"AM\nAvg.SYS/DIA"];
            [BPCircle setcircleValueText:@"148/88"];
            [BPCircle setCircleUnitText:@"mmHg"];
            break;
            
        case 2:
            BPTimeImage = [UIImage imageNamed:@"history_icon_a_pm"];
            [BPCircle setCircleTitleText:@"PM\nAvg.SYS/DIA"];
            [BPCircle setcircleValueText:@"145/85"];
            [BPCircle setCircleUnitText:@"mmHg"];
            break;
            
        default:
            break;
    }
    
    if (BPCurveTime != 2) {
        BPCurveTime++;
    }else{
        BPCurveTime = 0;
    }
    
    [BPTimeBtn setImage:BPTimeImage forState:UIControlStateNormal];
    
}

-(void)SYSBtnAction{
    
    [SYSBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [SYSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [PULBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [PULBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    
    [chart removeFromSuperview];
    
    [self createChart:0];
    
}

-(void)PULBtnAction{
    
    [SYSBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [SYSBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    
    [PULBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [PULBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [chart removeFromSuperview];
    
    [self createChart:1];
}

-(void)initBPHealthCircle{
    
    int circleCount = 3;
    
    float totalWidth = 10+circleCount*(circelSize+10);
    
    [healthStatusScroll setContentSize:CGSizeMake(totalWidth, healthStatusScroll.frame.size.height)];
    
    
    BPCircle = [[StatusCircleView alloc] initWithFrame:CGRectMake(10, healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [BPCircle setCircleTitleText:@"ALL\nAvg.SYS/DIA"];
    [BPCircle setcircleValueText:@"150/90"];
    [BPCircle setCircleUnitText:@"mmHg"];
    
    [BPCircle setCircleValueFrame];
    [healthStatusScroll addSubview:BPCircle];
    //測試
    [self setBadgeNumberForCircle:BPCircle withNumber:15];
    
    
    
    StatusCircleView *AFIBCircle = [[StatusCircleView alloc] initWithFrame:CGRectMake(10+circelSize+10, healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [AFIBCircle setCircleTitleText:@"AFIB\nFrequency/DIA"];
    [AFIBCircle setTextColorWithRange:NSMakeRange(0, 4) withColor:CIRCEL_RED];
    [AFIBCircle setcircleValueText:@"14"];
    [AFIBCircle setCircleUnitText:@""];
    
    [AFIBCircle setCircleValueFrame];
    [healthStatusScroll addSubview:AFIBCircle];
    //測試
    [self setBadgeNumberForCircle:AFIBCircle withNumber:5];
    
    
    
    StatusCircleView *FreqCircle = [[StatusCircleView alloc] initWithFrame:CGRectMake(10+2*(circelSize+10), healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [FreqCircle setCircleTitleText:@"\nFrequency"];
    [FreqCircle setcircleValueText:@"15"];
    FreqCircle.PADImgView.hidden = NO;
    
    [FreqCircle setCircleValueFrame];
    [healthStatusScroll addSubview:FreqCircle];
    //測試
    [self setBadgeNumberForCircle:FreqCircle withNumber:100];
    
    
//    float startX = 0;
//    
//    for (int i=0; i < circleCount; i++) {
//        
//        if (i==0) {
//            startX += 10;
//        }
//        
//        CGRect circleFrame = CGRectMake(startX+i*(circelSize+10), healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize);
//        
//        StatusCircleView *BPCircle = [[StatusCircleView alloc] initWithFrame:circleFrame];
//        
//        switch (i) {
//            case 0:
//                [BPCircle setCircleTitleText:@"ALL\nAvg.SYS/DIA"];
//                [BPCircle setcircleValueText:@"150/90"];
//                [BPCircle setCircleUnitText:@"mmHg"];
//                break;
    
//            case 1:
//                [BPCircle setCircleTitleText:@"AM\nAvg.SYS/DIA"];
//                [BPCircle setcircleValueText:@"140/85"];
//                [BPCircle setCircleUnitText:@"mmHg"];
//                break;
//                
//            case 2:
//                [BPCircle setCircleTitleText:@"PM\nAvg.SYS/DIA"];
//                [BPCircle setcircleValueText:@"151/92"];
//                [BPCircle setCircleUnitText:@"mmHg"];
//                break;
                
//            case 1:
//                [BPCircle setCircleTitleText:@"AFIB\nFrequency/DIA"];
//                [BPCircle setTextColorWithRange:NSMakeRange(0, 4) withColor:CIRCEL_RED];
//                [BPCircle setcircleValueText:@"14"];
//                [BPCircle setCircleUnitText:@""];
//                break;
//                
//            case 2:
//                [BPCircle setCircleTitleText:@"\nFrequency"];
//                [BPCircle setcircleValueText:@"15"];
//                BPCircle.PADImgView.hidden = NO;
//                break;
//                
//            default:
//                break;
//        }
//        
//        [BPCircle setCircleValueFrame];
//        
//        [healthStatusScroll addSubview:BPCircle];
    
    
//    }
    
}

-(void)setBadgeNumberForCircle:(StatusCircleView*)circleView withNumber:(int)number{
    
    float badgeCircleSize = SCREEN_WIDTH*0.06;
    
    UIView *badgeNumberView = [[UIView alloc] initWithFrame:CGRectMake(circleView.frame.origin.x+SCREEN_WIDTH*0.015, circleView.frame.origin.y+SCREEN_WIDTH*0.01, badgeCircleSize, badgeCircleSize)];
    
    badgeNumberView.backgroundColor = STANDER_COLOR;
    badgeNumberView.layer.cornerRadius = badgeNumberView.frame.size.width/2;
    
    
    UILabel *badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, badgeCircleSize, badgeCircleSize)];
    
    badgeLabel.font = [UIFont systemFontOfSize:13.0];
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.text = [NSString stringWithFormat:@"%d",number];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    
    if (badgeLabel.text.length >= 3) {
        badgeLabel.adjustsFontSizeToFitWidth = YES;
        badgeNumberView.frame = CGRectMake(circleView.frame.origin.x, circleView.frame.origin.y+SCREEN_WIDTH*0.02, SCREEN_WIDTH*0.08, badgeCircleSize);
        
        badgeLabel.frame = CGRectMake(badgeLabel.frame.origin.x, badgeLabel.frame.origin.y, SCREEN_WIDTH*0.08, badgeCircleSize);
        
        badgeNumberView.layer.cornerRadius = 13.0;
    }
    
    [badgeNumberView addSubview:badgeLabel];
    [healthStatusScroll addSubview:badgeNumberView];
    [healthStatusScroll bringSubviewToFront:badgeNumberView];
}


#pragma mark - weight button and actions
-(void)initWeightCurveControlButton{
    
    [showListBtn setTitle:@"YOUR WEIGHT LISTS" forState:UIControlStateNormal];
    
    float btnWidth = screen.bounds.size.width*0.22;
    float btnHeight = screen.bounds.size.height*0.041;
    float btnYpoint = curveControlBase.frame.size.height/2-btnHeight/2;
    
    BMIBtn = [[UIButton alloc] initWithFrame:CGRectMake(curveControlBase.frame.size.width/2-btnWidth/2, btnYpoint, btnWidth, btnHeight)];
    
    weightBtn = [[UIButton alloc] initWithFrame:CGRectMake(BMIBtn.frame.origin.x-10-btnWidth, btnYpoint, btnWidth, btnHeight)];
    
    fatBtn = [[UIButton alloc] initWithFrame:CGRectMake(BMIBtn.frame.origin.x+btnWidth+10, btnYpoint, btnWidth, btnHeight)];
    
    [BMIBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [BMIBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    [BMIBtn setTitle:@"BMI" forState:UIControlStateNormal];
    [BMIBtn addTarget:self action:@selector(weightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [weightBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
    [weightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weightBtn setTitle:@"WEI" forState:UIControlStateNormal];
    [weightBtn addTarget:self action:@selector(weightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [fatBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
    [fatBtn setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    [fatBtn setTitle:@"FAT" forState:UIControlStateNormal];
    [fatBtn addTarget:self action:@selector(weightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [curveControlBase addSubview:BMIBtn];
    [curveControlBase addSubview:weightBtn];
    [curveControlBase addSubview:fatBtn];
    
    [self createChart:2];
}

-(void)weightBtnAction:(id)sender{
    
    UIButton *btn = sender;
    
    [self setWeightStatus:btn on:YES];
    
    if (btn == weightBtn) {
        [self setWeightStatus:BMIBtn on:NO];
        [self setWeightStatus:fatBtn on:NO];
        [chart removeFromSuperview];
        [self createChart:2];
        [weightCircle setCircleTitleText:@"Avg. WEI"];
        [weightCircle setcircleValueText:@"80"];
        [weightCircle setCircleUnitText:@"kg"];
        
    }
    
    if (btn == BMIBtn) {
        [self setWeightStatus:weightBtn on:NO];
        [self setWeightStatus:fatBtn on:NO];
        [chart removeFromSuperview];
        [self createChart:3];
        [weightCircle setCircleTitleText:@"Avg. BMI"];
        [weightCircle setcircleValueText:@"24"];
        [weightCircle setCircleUnitText:@""];
    }
    
    if (btn == fatBtn) {
        [self setWeightStatus:BMIBtn on:NO];
        [self setWeightStatus:weightBtn on:NO];
        [chart removeFromSuperview];
        [self createChart:4];
        [weightCircle setCircleTitleText:@"Avg. FAT"];
        [weightCircle setcircleValueText:@"20"];
        [weightCircle setCircleUnitText:@"%"];
    }
}

-(void)setWeightStatus:(UIButton*)button on:(BOOL)status{
    
    if (status == YES) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"all_btn_a_1"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        [button setBackgroundImage:[UIImage imageNamed:@"all_btn_a_0"] forState:UIControlStateNormal];
        [button setTitleColor:STANDER_COLOR forState:UIControlStateNormal];
    }
    
}

-(void)initWeightHealthCircle{
    
    weightCircle = [[StatusCircleView alloc] initWithFrame:CGRectMake(healthStatusScroll.frame.size.width/2-circelSize/2, healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [weightCircle setCircleTitleText:@"Avg. WEI"];
    [weightCircle setcircleValueText:@"80"];
    [weightCircle setCircleUnitText:@"kg"];
    [weightCircle setCircleValueFrame];
    
    [healthStatusScroll setContentSize:CGSizeMake(healthStatusScroll.frame.size.width, healthStatusScroll.frame.size.height)];
        
    [healthStatusScroll addSubview:weightCircle];
    
}

#pragma mark - Temperature button and actions
-(void)initTempCurveControlButtonWithArray:(NSMutableArray *)dataArray{
    
    [showListBtn setTitle:@"YOUR BODY TEMPERATURE LISTS" forState:UIControlStateNormal];
    
    float btnSize = 65/imgScale;
    
    float totalWidth = dataArray.count*(btnSize+10);
    
    float startX = 10+curveControlBase.frame.size.width/2-totalWidth/2;
    
    for (int i=0; i<dataArray.count; i++) {

        UIButton *nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(startX+i*(btnSize+10), curveControlBase.frame.size.height/2-btnSize/2, btnSize, btnSize)];
        
        nameBtn.tag = i+1;
        
        [nameBtnAry addObject:nameBtn];
        
        [nameBtn addTarget:self action:@selector(tempBtnActions:) forControlEvents:UIControlEventTouchUpInside];
        
        UIColor *btnBorderColor;
        UIColor *btnBackColor;
        UIColor *titleColor;
        
        if (i==0) {
            btnBorderColor = STANDER_COLOR;
            btnBackColor = STANDER_COLOR;
            titleColor = [UIColor whiteColor];
        }else{
            btnBorderColor = TEXT_COLOR;
            btnBackColor = [UIColor whiteColor];
            titleColor = TEXT_COLOR;
        }
        
        nameBtn.layer.cornerRadius = nameBtn.frame.size.width/2;
        nameBtn.layer.borderWidth = 1.5;
        nameBtn.layer.borderColor = btnBorderColor.CGColor;
        
        NSString *name = [[dataArray objectAtIndex:i] objectForKey:@"name"];
        
        name = [name substringToIndex:1];
        [nameBtn setTitle:name forState:UIControlStateNormal];
        [nameBtn setTitleColor:titleColor forState:UIControlStateNormal];
        [nameBtn setBackgroundColor:btnBackColor];
        
        [curveControlBase addSubview:nameBtn];
    }
    
    [self createChart:5];
    
}

-(void)initTempHealthCircle{
    
    //°C °F
    
    [healthStatusScroll setContentSize:CGSizeMake(healthStatusScroll.frame.size.width, healthStatusScroll.frame.size.height)];
    
    lastTemp = [[StatusCircleView alloc] initWithFrame:CGRectMake(healthStatusScroll.frame.size.width/2-circelSize-10, healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [lastTemp setCircleTitleText:@"Last\nBody Temp."];
    [lastTemp setcircleValueText:@"36.5°C"];
    [lastTemp setCircleUnitText:@""];
    [lastTemp setCircleValueFrame];
    
    
    avgTemp = [[StatusCircleView alloc] initWithFrame:CGRectMake(healthStatusScroll.frame.size.width/2+10, healthStatusScroll.frame.size.height/2-circelSize/2, circelSize, circelSize)];
    
    [avgTemp setCircleTitleText:@"Avg.\nBody Temp."];
    [avgTemp setcircleValueText:@"37.0°C"];
    [avgTemp setCircleUnitText:@""];
    [avgTemp setCircleValueFrame];
    
    [healthStatusScroll addSubview:lastTemp];
    [healthStatusScroll addSubview:avgTemp];
    
}

-(void)tempBtnActions:(id)sender{
    
    UIButton *nameBtn = sender;
    
    [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nameBtn setBackgroundColor:STANDER_COLOR];
    nameBtn.layer.borderColor = STANDER_COLOR.CGColor;
    
    for (int i=0; i<nameBtnAry.count; i++) {
        
        nameBtn = [nameBtnAry objectAtIndex:i];
        
        if (i != [sender tag]-1) {
            [nameBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
            [nameBtn setBackgroundColor:[UIColor whiteColor]];
            nameBtn.layer.borderColor = TEXT_COLOR.CGColor;
        }
    }
}

-(void)setTimeLabelTitle:(NSString *)title;{
    timeLabel.text = title;
}

-(void)setCurveScrollContent:(UIScrollView *)scrollView withPages:(int)pages{

    CGFloat curve_width, curve_height;
    
    curve_width = scrollView.frame.size.width;
    curve_height = scrollView.frame.size.height;
    
    [scrollView setContentSize:CGSizeMake(curve_width * pages, curve_height)];
    
    //測試用資料
    for (int i=0; i!=pages; i++) {
        
        //CGRect frame = CGRectMake(curve_width*i, 0, curve_width, curve_height);
        //UIView *view = [[UIView alloc]initWithFrame:frame];
        
        //chart = [[GraphView alloc]initWithFrame:frame withChartType:self.type];
        
        //chart.delegate = self;
        
        //chart.clipsToBounds = NO;
        
        //[self bringSubviewToFront:chart];
        
//        CGFloat r, g ,b;
//        r = (arc4random() % 10) / 10.0;
//        g = (arc4random() % 10) / 10.0;
//        b = (arc4random() % 10) / 10.0;
//        [view setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:0.3]];
//        
//        view.layer.borderWidth = 2.0f;
//        view.layer.borderColor = [[UIColor whiteColor] CGColor];
//        view.layer.cornerRadius = 5.0f;
        
        //UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
        
        //countLabel.text = [NSString stringWithFormat:@"view:%d",i];
        
        //[view addSubview:countLabel];
        
        //[scrollView addSubview:view];
    }
    
    
    [scrollView setScrollEnabled:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollsToTop:NO];
    [scrollView setDelegate:self];

}

-(void)setSegment:(NSArray *)array{
    
    topSegment = [[UISegmentedControl alloc] initWithItems:array];
    
    topSegment.frame = CGRectMake(5, segBase.frame.size.height/2-29/2, screen.bounds.size.width-10, 29);
    
    [topSegment addTarget:self action:@selector(dateSegmentAction:) forControlEvents:UIControlEventValueChanged];
    
    topSegment.tintColor = STANDER_COLOR;

    topSegment.selectedSegmentIndex = 0;
    
    dateSegIndex = topSegment.selectedSegmentIndex;
    
    UIFont *font = [UIFont systemFontOfSize:18.0f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [topSegment setTitleTextAttributes:attributes
                              forState:UIControlStateNormal];
    
    [self addSubview:segBase];
    
    [segBase addSubview:topSegment];
}

- (void)dateSegmentAction:(id)sender {
    
    UISegmentedControl *segment = sender;
    
    dateSegIndex = segment.selectedSegmentIndex;
    
    [chart removeFromSuperview];
    [self createChart:chart.chartType];
    
}

-(void)prevCurveAction{
    
    int currentType = chart.chartType;
    
    dateIntervalIndex += 1;
    
    [self lockNextCurveBtn];
    
    [chart removeFromSuperview];
    [self createChart:currentType];
    
}

-(void)nextCurveAction{
    
    int currentType = chart.chartType;
    
    
    if (dateIntervalIndex != 0) {
        dateIntervalIndex -= 1;
    }
    
    [self lockNextCurveBtn];
    
    [chart removeFromSuperview];
    [self createChart:currentType];
    
}

-(void)lockNextCurveBtn{
    
    if(dateIntervalIndex == 1){
        nextCurveBtn.enabled = NO;
    }else{
        nextCurveBtn.enabled = YES;
    }
    
}

-(void)TouchBeginGraphView{
    [self.delegate GraphViewScrollBegin];
}

-(void)TouchEndGraphView{
    [self.delegate GraphViewScrollEnd];
}

-(void)DidFinishLoadChartAndShowDate:(NSString *)datString{
    
    [self setTimeLabelTitle:datString];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

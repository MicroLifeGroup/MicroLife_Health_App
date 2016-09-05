//
//  HistoryPageView.h
//  Microlife
//
//  Created by Rex on 2016/7/27.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusCircleView.h"
#import "GraphView.h"
#import "HistoryListTableView.h"

@protocol HistoryPageViewDelegate <NSObject>

-(void)GraphViewScrollBegin;
-(void)GraphViewScrollEnd;

-(void)showListButtonTapped:(UIView *)btnSnapShot;

@end

@interface HistoryPageView : UIView<UIScrollViewDelegate,GraphViewDelegate>{
    
    int viewType;
    float imgScale;
    UIView *segBase;
    UIScreen *screen;
    UISegmentedControl *topSegment;
    UILabel *timeLabel;
    UIButton *prevCurveBtn;
    UIButton *nextCurveBtn;
    UIView *absentBase;
    UIImageView *absentFace;
    UILabel *absentLabel;
    UIButton *showListBtn;
    NSUInteger dateSegIndex;
    NSUInteger typSegIndex;
    NSTimer *tapTimer;
    BOOL canTap;
    float circelSize;
    //血壓機按鈕
    UIButton *SYSBtn;
    UIButton *PULBtn;
    
    UIButton *BPTimeBtn;
    int BPCurveTime; //0=all 1=am 2=pm
    
    //體重計按鈕
    UIButton *weightBtn;
    UIButton *BMIBtn;
    UIButton *fatBtn;
    NSMutableArray *weightBtnAry;
    GraphView *chart;
    
    StatusCircleView *weightCircle;
    StatusCircleView *lastTemp;
    StatusCircleView *avgTemp;
    //體溫按鈕
    NSMutableArray *nameBtnAry;

}

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UIScrollView *healthStatusScroll;
@property (nonatomic, strong) UIView *curveControlBase;
@property (nonatomic) int type;//0=BloodPressure 1=Weight 2=Temperature

-(void)setSegment:(NSArray *)array;
-(void)setTimeLabelTitle:(NSString *)title;
//-(void)setCurveScrollContent:(UIScrollView *)scrollView withPages:(int)pages;
-(void)setAbsentDaysText:(int)absentDays andFaceIcon:(UIImage *)iconImg;

-(void)initBPCurveControlButton;
-(void)initWeightCurveControlButton;
-(void)initTempCurveControlButtonWithArray:(NSMutableArray *)dataArray;

-(void)initBPHealthCircle;
-(void)initWeightHealthCircle;
-(void)initTempHealthCircle;


@property (weak)id<HistoryPageViewDelegate>delegate;

@end

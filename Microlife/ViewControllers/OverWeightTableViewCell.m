//
//  WeightTableViewCell.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/17.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "OverWeightTableViewCell.h"

@implementation OverWeightTableViewCell{
    //WEIGHT
    UILabel *weightLabel;
    UILabel *weightValueLabel;
    UILabel *weightUnitLabel;
    
    //BMI
    UILabel *bmiLabel;
    UILabel *bmiValueLabel;
    
    //BODY FAT
    UILabel *bodyFatLabel;
    UILabel *bodyFatValueLabel;
    UILabel *bodyFatUnitLabel;
}

@synthesize weightCellImgView,weightCellSperator,weightCellDateLabel,weightCellTimeLabel;

-(id)initWithWeightCellFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    //weightCellImgView
    weightCellImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/30, frame.size.height/20, frame.size.height/3.5,frame.size.height/3.5)];
    weightCellImgView.image = [UIImage imageNamed:@"reminder_icon_a_we"];
    [self addSubview:weightCellImgView];
    
    //weightCellSperator
    weightCellSperator = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(weightCellImgView.frame), CGRectGetMaxY(weightCellImgView.frame)+5, 1.0, frame.size.height/1.8)];
    weightCellSperator.backgroundColor = STANDER_COLOR;
    [self addSubview:weightCellSperator];
    
    //weightCellDateLabel
    weightCellDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weightCellImgView.frame)+5, CGRectGetMinY(weightCellImgView.frame),frame.size.width/6, frame.size.height/3)];
    weightCellDateLabel.text = @"Today";
    weightCellDateLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:weightCellDateLabel];
    
    //bpCellTimeLabel
    weightCellTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weightCellDateLabel.frame)+5, CGRectGetMinY(weightCellDateLabel.frame), frame.size.width/6, frame.size.height/3)];
    weightCellTimeLabel.text = @"at 23:24";
    weightCellTimeLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:weightCellTimeLabel];
    
    
    //WEIGHT
    //--------------------------------------------
    CGFloat labelWidth = frame.size.width/12;
    CGFloat labelHeight = frame.size.height/2.5;
    
    //weightLabel
    weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(weightCellDateLabel.frame), CGRectGetMaxY(weightCellDateLabel.frame), labelWidth, labelHeight)];
    weightLabel.text = @"wight";
    weightLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:weightLabel];
    
    //weightValueLabel
    weightValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weightLabel.frame), CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    weightValueLabel.text = @"68";
    weightValueLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:weightValueLabel];
    
    //weightUnitLabel
    weightUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weightValueLabel.frame), CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    weightUnitLabel.text = @"kg";
    weightUnitLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:weightUnitLabel];
    
    
    //BMI
    //--------------------------------------------
    //bmiLabel
    bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weightUnitLabel.frame)+labelWidth/2, CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    bmiLabel.text = @"BMI";
    bmiLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:bmiLabel];
    
    //bmiValueLabel
    bmiValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bmiLabel.frame), CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    bmiValueLabel.text = @"28";
    bmiValueLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:bmiValueLabel];
    
    
    //BODY FAT
    //--------------------------------------------
    //bodyFatLabel
    bodyFatLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bmiValueLabel.frame)+labelWidth, CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    bodyFatLabel.text = @"PUL";
    bodyFatLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:bodyFatLabel];
    
    //bodyFatValueLabel
    bodyFatValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bodyFatLabel.frame), CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    bodyFatValueLabel.text = @"65";
    bodyFatValueLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:bodyFatValueLabel];
    
    //bodyFatUnitLabel
    bodyFatUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bodyFatValueLabel.frame), CGRectGetMinY(weightLabel.frame), labelWidth, labelHeight)];
    bodyFatUnitLabel.text = @"%";
    bodyFatUnitLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:bodyFatUnitLabel];
    
    
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

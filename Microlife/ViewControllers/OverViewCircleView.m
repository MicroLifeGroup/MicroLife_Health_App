//
//  OverViewCircleView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/12.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "OverViewCircleView.h"

@implementation OverViewCircleView {
    
    UILabel *titleLabel;
    UILabel *valueLabel;
    UILabel *unitLabel;
    
}

@synthesize circleViewTitleString,circleViewValueString,circleViewUnitString,circleImgView;

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initParameter];
        [self initInterface];
    }
    
    return self;
}

-(void)initParameter {
    
    
}

-(void)initInterface {
    
    //圓
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 6.0f;
    self.layer.borderColor = [STANDER_COLOR CGColor];
    
    //titleLabel
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/4)];
    titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/4);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    //valueLabel
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.8, self.frame.size.height/3)];
    valueLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.font = [UIFont systemFontOfSize:valueLabel.frame.size.height * 0.68];
    valueLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:valueLabel];
    
    //unitLabel
    unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/4)];
    unitLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/4*3);
    unitLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:unitLabel];
    
    
    //circleImgView
    circleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.88, self.frame.size.width*0.88)];
    circleImgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:circleImgView];
    
}


-(void)setString {
    
    titleLabel.text = circleViewTitleString;
    
    valueLabel.text = circleViewValueString;
    
    unitLabel.text = circleViewUnitString;
}










@end

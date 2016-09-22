//
//  CirleView.m
//  MicroLifeApp
//
//  Created by 曾偉亮 on 2016/8/19.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "CirleView.h"

@implementation CirleView {
    
    CGContextRef m_contex;//畫筆
}

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

//配置繪圖顏色
-(void)setContentColor:(UIColor*)color {

    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGContextSetRGBStrokeColor(m_contex, components[0], components[1], components[2], 1.0f);
    
    CGContextSetRGBFillColor(m_contex, components[0], components[1], components[2], 1.0f);
}

// 設定線段粗細
-(void)setDrawLineWidth:(float)width {

    CGContextSetLineWidth(m_contex, width);
}


//畫圓
-(void)drawCircleFrom:(CGPoint)oriPoint size:(CGSize)circleSize isFill:(BOOL)filled {
    
    /*
     center:圓中心
     circle:圓大小
     isFill:圓中空還是填滿
     
    */
    CGContextAddEllipseInRect(m_contex, CGRectMake(oriPoint.x, oriPoint.y, circleSize.width, circleSize.height));
    
    if (filled) {
        
        CGContextFillPath(m_contex);
        
    }else {
        
        CGContextStrokePath(m_contex);
    }
    
}


//建立畫筆
-(void)drawRect:(CGRect)rect {

    m_contex = UIGraphicsGetCurrentContext();
    CGContextRetain(m_contex);
    
    //circle
    [self setContentColor:STANDER_COLOR];
    [self setDrawLineWidth:6];
    [self drawCircleFrom:CGPointMake(6, 6) size:CGSizeMake(self.frame.size.width - 12, self.frame.size.height - 12) isFill:NO];

}

@end

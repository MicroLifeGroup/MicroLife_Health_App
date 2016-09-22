//
//  BloodPressurePickerView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/10.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "BloodPressurePickerView.h"

@implementation BloodPressurePickerView {
    
    NSMutableArray *ary_bpData;
}

@synthesize m_pickerView;

-(id)initWithbloodPressurePickerViewFrame:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    //m_pickerView
    m_pickerView = [[UIPickerView alloc] initWithFrame:frame];
    
    m_pickerView.backgroundColor = [UIColor whiteColor];
    
    m_pickerView.delegate = self;
    
    m_pickerView.dataSource = self;
    
    m_pickerView.showsSelectionIndicator = YES;
    
    //ary_sys
    NSMutableArray *ary_sys = [[NSMutableArray alloc] init];
    for (int sysInt = 20; sysInt <= 280; sysInt++) {
        
        [ary_sys addObject:[NSString stringWithFormat:@"%d",sysInt]];
    }
    
    //ary_dia
    NSMutableArray *ary_dia = [[NSMutableArray alloc] init];
    for (int diaInt = 20; diaInt <= 280; diaInt++) {
        
        [ary_dia addObject:[NSString stringWithFormat:@"%d",diaInt]];
    }
    
    //ary_unit
    NSMutableArray *ary_unit = [NSMutableArray arrayWithObjects:@"mmHg",@"kPa", nil];

    //ary_bpData
    ary_bpData = [NSMutableArray arrayWithObjects:
                  [NSArray arrayWithObjects:@" ", nil],
                  ary_sys,
                  ary_dia,
                  ary_unit,nil];
    
    
    return self;
    
}


#pragma mark - PickerView DataSource & Delegate
//---------------------------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return ary_bpData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_bpData[component]];
    NSInteger count = ary.count;
    
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_bpData[component]];
    NSString *title = (NSString *)ary[row];
    
    return title;
}


@end

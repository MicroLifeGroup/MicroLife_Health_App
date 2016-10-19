//
//  ProfileViewController.h
//  Setting
//
//  Created by Ideabus on 2016/8/12.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIScrollView *profileScrollview;
    UITextField *nameTextField;
    UILabel *birthdayLabel;
    UIDatePicker *birDatepicker ;
    UIView *allPickerView ;
    UIButton *pickerB;
    NSString *birthdaydate;
    UILabel *heightLabel ;
    UILabel *weightLabel;
    UIPickerView *heightPickerView;
    UIView *topView;
    NSMutableArray *Height;
    NSMutableArray *Weight;
    UIPickerView *weightPickerView;
    NSArray *h_unit;
    NSArray *w_unit;
    
    NSArray *CuffSizeArr;
    NSArray *MeaArmArr;
    
    UILabel *kgLabel;
    UIPickerView  *sysPickerView;
    UIPickerView  *diaPickerView;
    UIPickerView  *wPickerView;
    UIPickerView  *bmiPickerView;
    UIPickerView  *bfPickerView;
    UIPickerView  *csPickerView;
    UIPickerView  *maPickerView;
    
    
    NSMutableArray *Sys;
    NSMutableArray *Dia;
    NSMutableArray *Ww;
    NSMutableArray *BMI;
    NSMutableArray *BF;
    UILabel *spLabel;
    UILabel *dpLabel;
    UILabel *wLabel;
    UILabel *bmiLabel;
    UILabel *bfLabel;
    
    NSString *stringH;
    NSString *stringS;
    NSString *stringD;
    NSString *stringW;
    NSString *stringBMI;
    NSString *stringBF;
    NSString *stringWei;
    NSString *stringCSize;
    NSString *stringArm;
   
    NSUInteger *pickRow;
    
    NSInteger *BFrow;
    UILabel *CuffSizeLabel;
    UILabel *MeaArmLabel;
    UILabel *mmHg1Label;
    UILabel *mmHg2Label;
    UILabel *cmLabel;
    UILabel *goalkgLabel;
    
    
}
@property (nonatomic,retain)  UIScrollView *profileScrollview;
@property (nonatomic,retain)  UITextField *nameTextField;
@property (nonatomic,retain)  UILabel *birthdayLabel;
@property (nonatomic,retain)  UIDatePicker *birDatepicker ;
@property (nonatomic,retain)  UIView *allPickerView;
@property (nonatomic,retain)  UIButton *pickerB;
@property (nonatomic,retain)  NSString *birthdaydate;
@property (nonatomic,retain)  UILabel *heightLabel;
@property (nonatomic,retain)  UILabel *weightLabel;
@property (nonatomic,retain)  UIPickerView *heightPickerView;
@property (nonatomic,retain)  UIView *topView;
@property (nonatomic,retain)  NSArray *height;
@property (nonatomic,retain)  NSArray *weight;
@property (nonatomic,retain)  NSArray *h_unit;
@property (nonatomic,retain)  NSArray *w_unit;
@property (nonatomic,retain)  UILabel *cmLabel;
@property (nonatomic,retain)  UIPickerView *weightPickerView;
@property (nonatomic,retain)  UILabel *kgLabel;
@property (nonatomic,retain)  UIPickerView *sysPickerView;
@property (nonatomic,retain)  UIPickerView *diaPickerView;
@property (nonatomic,retain)  UIPickerView *wPickerView;
@property (nonatomic,retain)  UIPickerView *bmiPickerView;
@property (nonatomic,retain)  UIPickerView *bfPickerView;
@property (nonatomic,retain)  UIPickerView  *csPickerView;
@property (nonatomic,retain)  UIPickerView  *maPickerView;
@property (nonatomic,retain)  NSArray *CuffSizeArr;
@property (nonatomic,retain)  NSArray *MeaArmArr;


@property (nonatomic,retain)  NSArray *sys;
@property (nonatomic,retain)  NSArray *dia;
@property (nonatomic,retain)  NSArray *ww;
@property (nonatomic,retain)  NSArray *bMI;
@property (nonatomic,retain)  NSArray *bF;
@property (nonatomic,retain)  UILabel *spLabel;
@property (nonatomic,retain)  UILabel *dpLabel;
@property (nonatomic,retain)  UILabel *wLabel;
@property (nonatomic,retain)  UILabel *bmiLabel;
@property (nonatomic,retain)  UILabel *bfLabel;
@property  NSUInteger *pickRow;
@property  int thresholdcount;



@end

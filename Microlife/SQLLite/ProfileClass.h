//
//  ProfileClass.h
//  Microlife
//
//  Created by Rex on 2016/10/28.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "DataBaseClass.h"

@interface ProfileClass : DataBaseClass

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int userGender;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic) float userHeight;
@property (nonatomic) float userWeight;
@property (nonatomic) int cuff_size;
@property (nonatomic) int bp_measurement_arm;
@property (nonatomic) int unit_type;
@property (nonatomic) int sys_unit;
@property (nonatomic) int sys;
@property (nonatomic) int sys_activity;
@property (nonatomic) int dia;
@property (nonatomic) int dia_activity;
@property (nonatomic) float goal_weight;
@property (nonatomic) int weight_activity;
@property (nonatomic) float bmi;
@property (nonatomic) int bmi_activity;
@property (nonatomic) float body_fat;
@property (nonatomic) int body_fat_activity;
@property (nonatomic) int threshold;
@property (nonatomic, strong) NSString *conditions;
@property (nonatomic) int date_format;

/*
 姓名 name
 性別 userGender; //0 = man 1=women
 生日 birthday;
 身高 userHeight;
 體重 userWeight;
 cuff_size 0(預設值)
 bp_measurement_arm 0(預設值)
 公英制 unit_type;//0 = KG CM   1=lb
 目標收縮壓單位 sys_unit 0(預設值) 0=mmHg   1=kpa;
 目標收縮壓 sys 135(預設值)
 是否開啟目標收縮壓 sys_activity ; 0(預設值), 0=OFF, 1=ON
 目標舒張壓 dia 85(預設值)
 是否開啟目標舒張壓 dia_activity; 0(預設值), 0=OFF, 1=ON
 目標體重 goal_weight 75(預設值)
 是否開啟目標體重 weight_activity; 0(預設值), 0=OFF, 1=ON
 目標BMI bmi 23(預設值)
 是否開啟目標 BMI bmi_activity 0(預設值), 0=OFF, 1=ON
 目標體脂 body_fat 20(預設值)
 是否開啟目標體脂 body_fat_activity; 0(預設值), 0=OFF, 1=ON
 正常值 threshold 1(預設值), 0=OFF, 1=ON
 疾病 conditions
 日期格式 date_format  0(預設值) 0 = yyyy/mm/dd  1 = mm/dd/yyyy
 */

+(ProfileClass*)sharedInstance;
-(NSDictionary *)selectPersonalData;
-(void)updateData;
-(void)insertData;
@end

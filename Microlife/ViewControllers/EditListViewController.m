//
//  EditListViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/19.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EditListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface EditListViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate>{
    UIView *actionBtnBase;      //功能列
    UITextView *noteTextView;   //文字輸入框
    UIScrollView *noteScroll;
    UIImagePickerController *imagePicker;
    UIImageView *photoImage;    //相簿圖片
    UIImage *tempImg;           //相簿圖片暫存
    float navHeight;
    UIButton *recordBtn;        //錄音鈕
    float keyboardHeight;
    UIView *recordView;         //錄音狀態列
    UIButton *deleteImgBtn;
    
    UIImageView *animateBase;   //錄音特效放大view-淺色
    UIImageView *animateView;   //錄音特效view-深色
    
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *audioRecoder;
    
    UIButton *playRecordBtn;
    NSString *recordTimeStr;
    UILabel *recordTimeLab;
    UIView *recordRedView;
    
    UILabel *playTimeLab;
    NSTimer *recordTimer;
    
    BOOL isRecord;
    BOOL isPlay;
}

@end

@implementation EditListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.title = @"Note";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToListVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNoteAction)];
    
    [saveButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self initParameter];
    [self initInterface];
    
}

-(void)initParameter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //錄音初始化
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    //提高音量
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),&audioRouteOverride);
    
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    audioRecoder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    audioRecoder.delegate = self;
    audioRecoder.meteringEnabled = YES;
    [audioRecoder prepareToRecord];
    
    isRecord = NO;
    isPlay = NO;
    
}

- (NSString *)getPathFile {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"sound.caf"];
    
    NSLog(@"%@",dbPath);
    return dbPath;
}

-(void)initInterface{
    
    navHeight = self.navigationController.navigationBar.bounds.size.height+20;
    
    UIColor *lineColor = [UIColor colorWithRed:231.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1];
    
    actionBtnBase = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-navHeight-SCREEN_HEIGHT*0.063, SCREEN_WIDTH, SCREEN_HEIGHT*0.063)];
    
    actionBtnBase.backgroundColor = [UIColor whiteColor];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, actionBtnBase.frame.size.width, 1)];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, actionBtnBase.frame.size.height, actionBtnBase.frame.size.width, 1)];
    
    topLineView.backgroundColor = lineColor;
    bottomLineView.backgroundColor = lineColor;
    
    [actionBtnBase addSubview:topLineView];
    [actionBtnBase addSubview:bottomLineView];
    
    float iconWidth = 46/self.imgScale;
    float iconHeight = 47/self.imgScale;
    float iconSpace = SCREEN_WIDTH*0.053;
    
    UIButton *cameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, actionBtnBase.frame.size.height/2-iconHeight/2, iconWidth, iconHeight)];
    
    [cameraBtn setImage:[UIImage imageNamed:@"history_icon_a_camera"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *albumBtn = [[UIButton alloc] initWithFrame:CGRectMake(cameraBtn.frame.origin.x+cameraBtn.frame.size.width+iconSpace, actionBtnBase.frame.size.height/2-iconHeight/2, iconWidth, iconHeight)];
    
    [albumBtn addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [albumBtn setImage:[UIImage imageNamed:@"history_icon_a_pic"] forState:UIControlStateNormal];
    
    recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(albumBtn.frame.origin.x+albumBtn.frame.size.width+iconSpace, actionBtnBase.frame.size.height/2-iconHeight/2, iconWidth, iconHeight)];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [recordBtn addGestureRecognizer:longPress];
    
    [recordBtn setImage:[UIImage imageNamed:@"history_icon_a_rec_0"] forState:UIControlStateNormal];
    

    
    recordTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.773, 0, SCREEN_WIDTH*0.16, actionBtnBase.frame.size.height)];
    
    recordTimeLab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    
    recordRedView = [[UIView alloc] initWithFrame:CGRectMake(recordTimeLab.frame.origin.x+recordTimeLab.frame.size.width+5, actionBtnBase.frame.size.height/2-5, 10, 10)];

    recordRedView.backgroundColor = CIRCEL_RED;
    recordRedView.layer.cornerRadius = recordRedView.frame.size.width/2;
    recordRedView.hidden = YES;
    
    float scrollHeight = self.view.frame.size.height-actionBtnBase.frame.size.height-navHeight;
    
    noteScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollHeight)];
    
    [noteScroll setContentSize:CGSizeMake(self.view.frame.size.width, noteScroll.frame.size.height-navHeight+100)];

    
    noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.9/2, 0, self.view.frame.size.width*0.9, SCREEN_HEIGHT*0.074)];
    [noteTextView setFont:[UIFont systemFontOfSize:15.0]];
    noteTextView.text = @"note...   ";
    noteTextView.scrollEnabled = NO;
    noteTextView.delegate = self;
    
    
    float deleteIconSize = 35/self.imgScale;
    
    photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.9/2, noteTextView.frame.origin.y+noteTextView.frame.size.height+self.view.frame.size.height*0.018, self.view.frame.size.width*0.9, 100)];
    
    photoImage.userInteractionEnabled = YES;
    
    deleteImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(photoImage.frame.size.width-5-deleteIconSize, 5, deleteIconSize, deleteIconSize)];
    
    [deleteImgBtn setImage:[UIImage imageNamed:@"history_icon_a_cancel"] forState:UIControlStateNormal];
    
    [deleteImgBtn addTarget:self action:@selector(deleteImg) forControlEvents:UIControlEventTouchUpInside];
    
    imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    recordView = [[UIView alloc] initWithFrame:CGRectMake(0, actionBtnBase.frame.origin.y-SCREEN_HEIGHT*0.063, SCREEN_WIDTH, SCREEN_HEIGHT*0.063)];
    
    recordView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:220.0/255.0 blue:238.0/255.0 alpha:1];
    
    recordView.hidden = YES;
    
    float recordIconSize = 66/self.imgScale;
    
    playRecordBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.03, recordView.frame.size.height/2-recordIconSize/2, recordIconSize, recordIconSize)];
    
    [playRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_note_play"] forState:UIControlStateNormal];
    [playRecordBtn addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
    
    float soundWidth = 29/self.imgScale;
    float soundHeight = 45/self.imgScale;
    
    playTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(recordView.frame.size.width/2-SCREEN_WIDTH*0.173/2+soundWidth, 0, SCREEN_WIDTH*0.173, recordView.frame.size.height)];
    
    playTimeLab.textColor = STANDER_COLOR;
    playTimeLab.text = @"00:00";
    playTimeLab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    
    UIImageView *soundIcon = [[UIImageView alloc] initWithFrame:CGRectMake(playTimeLab.frame.origin.x-soundWidth-5, recordView.frame.size.height/2-soundHeight/2, soundWidth, soundHeight)];
    
    soundIcon.image = [UIImage imageNamed:@"history_icon_a_voice"];
    
    UIButton *deleteRecordBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*0.026-deleteIconSize, recordView.frame.size.height/2-deleteIconSize/2, deleteIconSize, deleteIconSize)];
    
    [deleteRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_cancel"] forState:UIControlStateNormal];
    [deleteRecordBtn addTarget:self action:@selector(deleteReocrd) forControlEvents:UIControlEventTouchUpInside];
    
    if (tempImg == nil) {
        deleteImgBtn.hidden = YES;
    }else{
        deleteImgBtn.hidden = NO;
    }
    
    [self.view addSubview:noteScroll];
    [noteScroll addSubview:noteTextView];
    [noteScroll addSubview:photoImage];
    [photoImage addSubview:deleteImgBtn];
    
    [self.view addSubview:recordView];
    [recordView addSubview:playRecordBtn];
    [recordView addSubview:soundIcon];
    [recordView addSubview:playTimeLab];
    [recordView addSubview:deleteRecordBtn];
    
    
    [self.view addSubview:actionBtnBase];
    [actionBtnBase addSubview:cameraBtn];
    [actionBtnBase addSubview:albumBtn];
    [actionBtnBase addSubview:recordBtn];
    [actionBtnBase addSubview:recordTimeLab];
    [actionBtnBase addSubview:recordRedView];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    actionBtnBase.frame = CGRectMake(0, actionBtnBase.frame.origin.y-keyboardHeight-actionBtnBase.frame.size.height, actionBtnBase.frame.size.width, actionBtnBase.frame.size.height);
    
    recordView.frame = CGRectMake(0, actionBtnBase.frame.origin.y-recordView.frame.size.height, recordView.frame.size.width, recordView.frame.size.height);
}

-(void)viewDidAppear:(BOOL)animated{
    
    imagePicker.delegate = nil;
    
    if (tempImg != nil) {
        photoImage.image = tempImg;
        
        CGFloat img_width;
        CGFloat img_height;
        int scaleSize;
        
        if (tempImg.size.width > photoImage.frame.size.width) {
            scaleSize = tempImg.size.width / photoImage.frame.size.width;
            img_width = photoImage.frame.size.width;
            img_height = tempImg.size.height / scaleSize;
        }else{
            img_width = tempImg.size.width;
            img_height = tempImg.size.height;
        }
        
        NSLog(@"img_width = %f",img_width);
        NSLog(@"img_width = %f",img_height);
        
        NSLog(@"tempImg.size.width = %f",tempImg.size.width);
        NSLog(@"tempImg.size.height = %f",tempImg.size.height);
        
        photoImage.frame = CGRectMake(photoImage.frame.origin.x, photoImage.frame.origin.y,img_width, img_height);
        deleteImgBtn.hidden = NO;
    }else{
        deleteImgBtn.hidden = YES;
    }
}

#pragma mark - Button actions
-(void)playRecord{

    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioRecoder.url error:nil];
    [audioPlayer setDelegate:self];
    
    if (!isPlay) {
        isPlay = YES;
        playTimeLab.text = @"00:00";
        [playRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_note_stop"] forState:UIControlStateNormal];
        
        [audioPlayer play];
        
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trackRecordTime) userInfo:nil repeats:YES];
    }else{
        isPlay = NO;
        
        [playRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_note_play"] forState:UIControlStateNormal];
        
        [audioPlayer pause];
        
        [recordTimer invalidate];
    }
    
    NSLog(@"audioPlayer.currentTime = %f",audioPlayer.currentTime);
    
    NSLog(@"playRecord");
}

-(void)deleteReocrd{
    
    [playRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_note_play"] forState:UIControlStateNormal];
    [recordTimer invalidate];
    recordView.hidden = YES;
    [audioPlayer stop];
    isPlay = NO;
    
    NSLog(@"deleteReocrd");
}

-(void)deleteImg{
    
    photoImage.image = nil;
    deleteImgBtn.hidden = YES;
    
    NSLog(@"deleteImg");
    
}


-(void)openCamera{
    
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

-(void)openAlbum{
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    
    float recordCircelSize = 166/self.imgScale;
    
    CGRect circleFrame = CGRectMake(recordBtn.center.x-recordCircelSize/2, recordBtn.center.y-recordCircelSize/2, recordCircelSize, recordCircelSize);
    
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        NSLog(@"Long Press began");
        [recordTimer invalidate];
        isRecord = YES;
        recordView.hidden = YES;
        recordRedView.hidden = NO;
        recordTimeLab.text = @"00:00";
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [audioRecoder record];
        
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trackRecordTime) userInfo:nil repeats:YES];
        
        animateBase = [[UIImageView alloc] initWithFrame:circleFrame];
        
        animateBase.image = [UIImage imageNamed:@"history_ef_a_1"];
        
        
        animateView = [[UIImageView alloc] initWithFrame:circleFrame];
        
        animateView.image = [UIImage imageNamed:@"history_ef_a_2"];
        
        
        [actionBtnBase addSubview:animateBase];
        [actionBtnBase addSubview:animateView];
        [actionBtnBase bringSubviewToFront:animateBase];
        [actionBtnBase bringSubviewToFront:animateView];
        
        //UIViewKeyframeAnimationOptionAutoreverse |
        
        [UIView animateKeyframesWithDuration:2.0 delay:0.0 options: UIViewKeyframeAnimationOptionRepeat animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
                animateBase.alpha = 1;
                animateView.transform =  CGAffineTransformMakeScale(1.5, 1.5);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
                animateView.alpha = 0;
            }];
        } completion:nil];
    }
    
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        NSLog(@"Long Press end");
        isRecord = NO;
        [audioRecoder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        [recordTimer invalidate];
        
        [animateBase removeFromSuperview];
        [animateView removeFromSuperview];
        
        animateBase.hidden = YES;
        animateView.hidden = YES;
    }
}

-(void)trackRecordTime{
    
    int recordMin;
    int recordSec;
    
    if (isRecord) {
        
        recordMin = audioRecoder.currentTime/60;
        recordSec = audioRecoder.currentTime-recordMin*60;
        
        recordTimeStr = [NSString stringWithFormat:@"%02d:%02d",recordMin,recordSec];
        
        recordTimeLab.text = recordTimeStr;
        
        NSLog(@"recordTimeLab = %@",recordTimeLab.text);
        
    }else{
        recordMin = audioPlayer.currentTime/60;
        recordSec = audioPlayer.currentTime-recordMin*60;
        
        playTimeLab.text = [NSString stringWithFormat:@"%02d:%02d",recordMin,recordSec];
        NSLog(@"playTimeLab = %@",playTimeLab.text);
    }
    
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    
    playTimeLab.text = recordTimeStr;
    recordView.hidden = NO;
    recordRedView.hidden = YES;
    recordTimeLab.text = @"";
    NSLog(@"flag = %d",flag);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    playTimeLab.text = recordTimeStr;
    [playRecordBtn setImage:[UIImage imageNamed:@"history_icon_a_note_play"] forState:UIControlStateNormal];
    [recordTimer invalidate];
    isPlay = NO;
    NSLog(@"audioPlayerDidFinishPlaying");
}

#pragma mark - Photo delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *pickedImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    tempImg = pickedImg;

    photoImage.image = nil;
    
}

#pragma mark - TextView elegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([noteTextView.text isEqualToString:@"note...   "]) {
        noteTextView.text = @"";
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
    
    CGFloat fixedWidth = noteTextView.frame.size.width;
    CGSize newSize = [noteTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = noteTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    noteTextView.frame = newFrame;

    photoImage.frame = CGRectMake(photoImage.frame.origin.x, noteTextView.frame.origin.y+noteTextView.frame.size.height+self.view.frame.size.height*0.018, photoImage.frame.size.width, photoImage.frame.size.height);
    
    float scrollContent = noteTextView.frame.size.height+self.view.frame.size.height*0.018+photoImage.frame.size.height+100;
    
    [noteScroll setContentSize:CGSizeMake(self.view.frame.size.width, scrollContent)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [noteTextView resignFirstResponder];
        
        [UIView transitionWithView:self.view duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            
            actionBtnBase.frame = CGRectMake(-1, SCREEN_HEIGHT-navHeight-SCREEN_HEIGHT*0.063, SCREEN_WIDTH+2, SCREEN_HEIGHT*0.063);
            recordView.frame =  CGRectMake(0, actionBtnBase.frame.origin.y-SCREEN_HEIGHT*0.063, SCREEN_WIDTH, SCREEN_HEIGHT*0.063);
            
        } completion:^(BOOL finished) {
            //
        }];
    }
    
    return YES;
}

-(void)backToListVC{
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveNoteAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

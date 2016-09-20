//
//  EditListViewController.m
//  Microlife
//
//  Created by Rex on 2016/9/19.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "EditListViewController.h"

@interface EditListViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate>{
    UIView *actionBtnBase;
    UITextView *noteTextView;
    UIScrollView *noteScroll;
    UIImagePickerController *imagePicker;
    UIImageView *photoImage;
    UIImage *tempImg;
    float navHeight;
    UIButton *recordBtn;
    float keyboardHeight;
    
    UIImageView *animateBase;
    
    UIImageView *animateView;
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
    
}

-(void)initInterface{
    
    navHeight = self.navigationController.navigationBar.bounds.size.height+20;
    
    UIColor *lineColor = [UIColor colorWithRed:231.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1];
    
    actionBtnBase = [[UIView alloc] initWithFrame:CGRectMake(-1, SCREEN_HEIGHT-navHeight-SCREEN_HEIGHT*0.063, SCREEN_WIDTH+2, SCREEN_HEIGHT*0.063)];
//    actionBtnBase.layer.borderWidth = 1.0f;
//    actionBtnBase.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1].CGColor;
    
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
    
    float scrollHeight = self.view.frame.size.height-actionBtnBase.frame.size.height-navHeight;
    
    noteScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollHeight)];
    
    [noteScroll setContentSize:CGSizeMake(self.view.frame.size.width, noteScroll.frame.size.height-navHeight)];

    
    noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.9/2, 0, self.view.frame.size.width*0.9, SCREEN_HEIGHT*0.074)];
    [noteTextView setFont:[UIFont systemFontOfSize:15.0]];
    noteTextView.text = @"note...   ";
    noteTextView.scrollEnabled = NO;
    noteTextView.delegate = self;
    
    
    photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.9/2, noteTextView.frame.origin.y+noteTextView.frame.size.height+self.view.frame.size.height*0.018, self.view.frame.size.width*0.9, 100)];
    
    
    imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self.view addSubview:noteScroll];
    [self.view addSubview:actionBtnBase];
    [actionBtnBase addSubview:cameraBtn];
    [actionBtnBase addSubview:albumBtn];
    [actionBtnBase addSubview:recordBtn];
    [noteScroll addSubview:noteTextView];
    [noteScroll addSubview:photoImage];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    actionBtnBase.frame = CGRectMake(0, actionBtnBase.frame.origin.y-keyboardHeight-actionBtnBase.frame.size.height, actionBtnBase.frame.size.width, actionBtnBase.frame.size.height);
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
    }
}

#pragma mark - Button actions
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
        
        [animateBase removeFromSuperview];
        [animateView removeFromSuperview];
        
        animateBase.hidden = YES;
        animateView.hidden = YES;
    }
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
    
    float scrollContent = noteTextView.frame.size.height+self.view.frame.size.height*0.018+photoImage.frame.size.height;
    
    [noteScroll setContentSize:CGSizeMake(self.view.frame.size.width, scrollContent)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [noteTextView resignFirstResponder];
        
        actionBtnBase.frame = CGRectMake(-1, SCREEN_HEIGHT-navHeight-SCREEN_HEIGHT*0.063, SCREEN_WIDTH+2, SCREEN_HEIGHT*0.063);
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

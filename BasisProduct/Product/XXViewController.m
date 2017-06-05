//
//  XXViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXViewController.h"

#define USER_APPID           @"592e2a82"


@interface XXViewController () <UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,IFlyFaceRequestDelegate>

@property (nonatomic,retain) IFlyFaceRequest * iFlySpFaceRequest;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) NSString *resultStings;
@property (nonatomic,strong) UILabel *labelView;
@property (nonatomic,strong) UIImageView *showImageView;
@property (nonatomic,strong) UILabel *gidsLabel;

@property (weak, nonatomic) IBOutlet UITextField *auth_idTextField;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;


@end



@implementation XXViewController  {
    
    int _flag;
}



- (void)viewDidLoad {

    [super viewDidLoad];
    
    _flag = 0;
    self.resultStings  = [NSString string];
    //    self.gids = [NSString string];
    self.iFlySpFaceRequest = [IFlyFaceRequest sharedInstance];
    self.iFlySpFaceRequest.delegate = self;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 15, kScreenHeight / 2 - 15, 30, 30)];
    [self.view addSubview:self.activityIndicator];
    
    self.title = @"注册与验证";
    
    // Do any additional setup after loading the view.
   }
#pragma mark - //注册


- (IBAction)pushAction:(UIButton *)sender {
    
   
    _flag = 0;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"图片获取方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机
        if(![XXHelper isCapturePermissionGranted]){
            NSString* info=@"没有相机权限";
            NSLog(@"%@",info);
            return;
        }
        _labelView.text=@"";
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
                picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            
            picker.mediaTypes = @[(NSString*)kUTTypeImage];
            picker.allowsEditing = NO;//设置可编辑
            picker.delegate = self;
            

            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"设备不可用");
        }
        
    }];
    [alertVC addAction:cameraAction];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        if(![XXHelper isAssetsLibraryPermissionGranted]){
            NSString* info=@"没有相册权限";
            //            [self showAlert:info];
            NSLog(@"%@",info);
            return;
        }
        
    
        _labelView.text=@"";
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        if([UIImagePickerController isSourceTypeAvailable: picker.sourceType ]) {
            picker.mediaTypes = @[(NSString*)kUTTypeImage];
            picker.delegate = self;
            picker.allowsEditing = NO;
        }
        [self presentViewController:picker animated:YES completion:nil];

    }];
    [alertVC addAction:photoAction];
    alertVC.popoverPresentationController.sourceView = self.view;
    alertVC.popoverPresentationController.sourceRect = sender.frame;
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    

    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xxBttton:(UIButton *)sender {
    
    _flag = 1;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"图片获取方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机
        if(![XXHelper isCapturePermissionGranted]){
            NSString* info=@"没有相机权限";
            NSLog(@"%@",info);
            return;
        }
        _labelView.text=@"";
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
                picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            
            picker.mediaTypes = @[(NSString*)kUTTypeImage];
            picker.allowsEditing = NO;//设置可编辑
            picker.delegate = self;
            
            //            [self performSelector:@selector(presentImagePicker:) withObject:picker afterDelay:1.0f];
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            NSLog(@"设备不可用");
        }
        
    }];
    [alertVC addAction:cameraAction];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        if(![XXHelper isAssetsLibraryPermissionGranted]){
            NSString* info=@"没有相册权限";
            //            [self showAlert:info];
            NSLog(@"%@",info);
            return;
        }
        _labelView.text=@"";
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        if([UIImagePickerController isSourceTypeAvailable: picker.sourceType ]) {
            picker.mediaTypes = @[(NSString*)kUTTypeImage];
            picker.delegate = self;
            picker.allowsEditing = NO;
        }
        [self presentViewController:picker animated:YES completion:nil];
        //        [self performSelector:@selector(presentImagePicker:) withObject:picker afterDelay:1.0f];
    }];
    [alertVC addAction:photoAction];
    alertVC.popoverPresentationController.sourceView = self.view;
    alertVC.popoverPresentationController.sourceRect = sender.frame;
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    

}


#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    //    if(_imgToUseCoverLayer){
    //        _imgToUseCoverLayer.sublayers=nil;
    //        [_imgToUseCoverLayer removeFromSuperlayer];
    //        _imgToUseCoverLayer=nil;
    //    }
    //
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //    if (image) {
    //        NSLog(@"ok");
    //    }else{
    //        NSLog(@"no ok ");
    //    }
    
    UIImage* upLoadImage = [[image fixOrientation:image] imgCompressed:image targetWidth:300];//将图片压缩以上传服务器
    _imgV.image = upLoadImage;
    
    self.showImageView.image = upLoadImage;
    
    //压缩图片大小
    NSData* imgData = [upLoadImage compressedData];

    if (_flag == 0) {
        //注册
        [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_REG] forKey:[IFlySpeechConstant FACE_SST]];
        [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlySpeechConstant APPID]];
        [self.iFlySpFaceRequest setParameter:self.auth_idTextField.text forKey:[IFlySpeechConstant FACE_AUTH_ID]];
        
        //        self.auth_idLabel.text = self.auth_idTextField.text ;
        [self.iFlySpFaceRequest setParameter:@"del" forKey:@"property"];
        
        [self.iFlySpFaceRequest sendRequest:imgData];
        
    }else{
        //验证
        [self.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_VERIFY] forKey:[IFlySpeechConstant FACE_SST]];
        [self.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlySpeechConstant APPID]];
        [self.iFlySpFaceRequest setParameter:self.auth_idTextField.text  forKey:@"auth_id"];
        NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
        NSString* gid = [userDefaults objectForKey:self.auth_idTextField.text];
        
        [self.iFlySpFaceRequest setParameter:gid forKey:[IFlySpeechConstant FACE_GID]];
        [self.iFlySpFaceRequest setParameter:@"2000" forKey:@"wait_time"];
        //  压缩图片大小
        NSData* imgData=[upLoadImage compressedData];
        NSLog(@"verify image data length: %lu",(unsigned long)[imgData length]);
        [self.iFlySpFaceRequest sendRequest:imgData];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}






#pragma mark - Data Parser

-(void)praseRegResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:@"sst"];
            NSLog(@"%@",dic);
            
            //注册
            if([strSessionType isEqualToString:@"reg"]){
                NSString* rst=[dic objectForKey:@"rst"];
                NSString* ret=[dic objectForKey:@"reg"];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"注册错误\n错误码：%@",ret];
                }else{
                    if(rst && [rst isEqualToString:@"success"]){
                        NSString* gid=[dic objectForKey:@"gid"];
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n注册成功！"];
                        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                        [defaults setObject:gid forKey:self.auth_idTextField.text];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"gid:%@\n",gid];
                        //                        self.gids = [self.gids stringByAppendingFormat:@"gid:%@\n",gid];
                        self.gidsLabel.text = resultInfoForLabel;
                        
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n注册失败！"];
                    }
                }
            }
            _labelView.text=resultInfoForLabel;
            _labelView.textColor=[UIColor redColor];
            _labelView.hidden=NO;
            [_activityIndicator stopAnimating];
            [_activityIndicator setHidden:YES];
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
    
}

-(void)praseVerifyResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType=[dic objectForKey:@"sst"];
            
            if([strSessionType isEqualToString:@"verify"]){
                NSLog(@"%@",dic);
                
                
                NSString* rst=[dic objectForKey:@"rst"];
                NSString* ret=[dic objectForKey:@"ret"];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"验证错误\n错误码：%@",ret];
                }else{
                    
                    if([rst isEqualToString:@"success"]){
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n"];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n"];
                    }
                    
                    NSString* verf=[dic objectForKey:@"verf"];
                    NSString* score=[dic objectForKey:@"score"];
                    
                    
                    
                    if([verf boolValue]){
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"score:%@\n",score];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证成功!"];
                    }else{
                        
                        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
                        NSString* gid=[defaults objectForKey:@"gid"];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"last reg gid:%@\n",gid];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证失败!"];
                    }
                }
                
            }
            
            _labelView.text=resultInfoForLabel;
            _labelView.textColor=[UIColor redColor];
            _labelView.hidden=NO;
            [_activityIndicator stopAnimating];
            [_activityIndicator setHidden:YES];
            //            _backBtn.enabled=YES;
            //            _imgSelectBtn.enabled=YES;
            //            _settingBtn.enabled=YES;
            //            _funcSelectBtn.enabled=YES;
            
            if([resultInfo length]<1){
                resultInfo=@"结果异常";
            }
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
        
    }
    
    
}

#pragma mark - Perform results On UI

-(void)updateFaceImage:(NSString*)result{
    
    
    NSLog(@"%@",result);
    NSError* error;
    NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"%@",dic);
    
    if(dic){
        
        
        NSString* strSessionType=[dic objectForKey:@"sst"];
        
        //注册
        if([strSessionType isEqualToString:@"reg"]){
            [self praseRegResult:result];
        }
        
        //验证
        if([strSessionType isEqualToString:@"verify"]){
            [self praseVerifyResult:result];
        }
        
        
    }
}

-(void)showResultInfo:(NSString*)resultInfo{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    alert=nil;
}



#pragma mark - IFlyFaceRequestDelegate


/**
 * 消息回调
 * @param eventType 消息类型
 * @param params 消息数据对象
 */
- (void) onEvent:(int) eventType WithBundle:(NSString*) params{
    NSLog(@"onEvent | params:%@",params);
    
}

/**
 * 数据回调，可能调用多次，也可能一次不调用
 * @param data 服务端返回的二进制数据
 */
- (void) onData:(NSData* )data{
    
    NSLog(@"onData | ");
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",result);
    
    if (result) {
        //        self.resultStings = @"";
        //        self.resultStings=[self.resultStings stringByAppendingString:result];
        self.resultStings = result;
        NSLog(@"self.resultStings:%@",self.resultStings);
        
        
    }
    
}

/**
 * 结束回调，没有错误时，error为null
 * @param error 错误类型
 */
- (void) onCompleted:(IFlySpeechError*) error{
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidden:YES];
    //    _backBtn.enabled=YES;
    //    _imgSelectBtn.enabled=YES;
    //    _settingBtn.enabled=YES;
    //    _funcSelectBtn.enabled=YES;
    NSLog(@"onCompleted | error:%@",[error errorDesc]);
    NSString* errorInfo=[NSString stringWithFormat:@"错误码：%d\n 错误描述：%@",[error errorCode],[error errorDesc]];
    if(0!=[error errorCode]){
        [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:errorInfo waitUntilDone:NO];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateFaceImage:self.resultStings];
        });
    }
}


#pragma mark - 退出
- (IBAction)Loginout:(id)sender {
    
    
}







@end

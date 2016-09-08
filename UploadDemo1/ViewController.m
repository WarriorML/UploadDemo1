//
//  ViewController.m
//  UploadDemo1
//
//  Created by MengLong Wu on 16/9/8.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showPhoto:(id)sender
{
//    UIImagePickerController 图片选择器
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
//    是否允许编辑
    picker.allowsEditing = YES;
    
//    判断是否支持这个来源
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        设置图片来源为系统相册
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
//    设置代理
    picker.delegate = self;
    
//    弹出相册
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)uploadPic:(id)sender
{
    NSString *urlStr = @"http://localhost:8080/DownloadAndUpload/upload";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
//    把JPEG，JPG图片转化为二进制数据
//    NSData *data = UIImageJPEGRepresentation(_imageView.image, 0.5);
//    把PNG图片转化为二进制数据
    NSData *data = UIImagePNGRepresentation(_imageView.image);
    
    [request setHTTPMethod:@"POST"];
//    设置请求体
    [request setHTTPBody:data];
//    把数据的长度设置到请求头中
    [request setValue:[NSString stringWithFormat:@"%ld",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:nil];
    
    [connection start];
    
}

/*
//iOS 3.0 被弃用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    _imageView.image = image;
//    选择图片之后不会自动返回，需要手动调用返回的方法
    [self dismissViewControllerAnimated:YES completion:nil];
}
*/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取原图
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    获取编辑之后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    _imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}















@end

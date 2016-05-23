//
//  MoreViewController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    NSString *userName;
    UIImage *userIcon;
}

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更多";
    self.tableView.separatorColor = kTableViewSeColor;
    
    //NSHomeDirectory()通过这个方法 找到当前 文件的沙盒
    NSLog(@"沙盒路径：%@", NSHomeDirectory());
    
    //从沙盒中加载数据
    [self getDataFromSandBox];
    
    if (userName == nil) {
        userName = @"Volve";
    }
    if (userIcon == nil) {
        userIcon = [UIImage imageNamed:@"pig"];
    }
    
    
    //创建头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    headView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:userIcon forState:UIControlStateNormal];
    [button setTitle:@"编辑头像" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(25, 25, 100, 100);
    button.layer.cornerRadius = 50;
    button.layer.masksToBounds = YES;
    button.tag = 2016;
    
    [headView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, 150, 40)];
    label.text = userName;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.tag = 2017;
    
    [headView addSubview:label];
    
    self.tableView.tableHeaderView = headView;
}

//配置相片来源类型 -》 弹出相册 -》 选择图片 -》 返回选择的图片 —》 配置给button
- (void)buttonAction:(UIButton *)button {
    
    //图片来源
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
    
}
//获取图片的delegate 在相册中选择图片时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    userIcon = info[UIImagePickerControllerOriginalImage];
    
    UIButton *button = [self.tableView.tableHeaderView viewWithTag:2016];
    [button setImage:userIcon forState:UIControlStateNormal];
    
    UILabel *label = [self.tableView.tableHeaderView viewWithTag:2017];
    label.text = @"smart";
    userName = label.text;
    
    [self saveDataToSandBox];
}
//保存数据到沙盒当中
- (void)saveDataToSandBox {
    
    if (userIcon != nil || userName != nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
        
        NSData *data = UIImageJPEGRepresentation(userIcon, 0.8);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userIcon"];
        
        //同步数据
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

//从沙盒当中取数据
- (void)getDataFromSandBox {
    
        userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        
        userIcon = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"]];
        
        //同步数据
        [[NSUserDefaults standardUserDefaults] synchronize];
}



//找到缓存-》 计算大小 -》 点击这个cell ——》弹出AlertView -》 确定清除缓存 ——》 刷新界面

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self readCatchSize];
}

- (void)readCatchSize
{
    NSInteger fileSize = [self getCatchSize];
    
    NSLog(@"内存大小：%ld", fileSize);
    
    self.sizeLabel.text = [NSString stringWithFormat:@"%.2f MB", fileSize / 1024.0 / 1024.0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"确定清除缓存%@", self.sizeLabel.text] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.sizeLabel.text = @"0.0 MB";
            
            [self clearCatch];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
        
        [self presentViewController:alert animated:YES completion:NULL];
    }
}

- (NSInteger)getCatchSize
{
    NSInteger fileSize = 0;
    
    //拿到缓存文件夹  (PathComponent追加路径的方法，前面不需要加'/')
    NSString *catchPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    //拿到缓存文件夹下的所有文件的属性
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:catchPath];
    //拿到属性中的文件名，确定文件的路径，计算文件的大小
    for (NSString *fileName in fileEnumerator) {
        //确定文件的路径
        NSString *filePath = [catchPath stringByAppendingPathComponent:fileName];
        //获取文件的属性
        NSDictionary *attDic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //累加文件大小（文件属性中的getter方法得到文件的大小）
        fileSize += attDic.fileSize;
    }
    
    return fileSize;
}

- (void)clearCatch
{
    //拿到缓存文件夹
    NSString *catchPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    //清除缓存
    [[NSFileManager defaultManager] removeItemAtPath:catchPath error:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

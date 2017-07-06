//
//  GeradorViewController.m
//  QueryCodeObjective
//
//  Created by MakroTest on 06/07/17.
//  Copyright © 2017 Humberto Puccinelli. All rights reserved.
//

#import "GeradorViewController.h"

@interface GeradorViewController ()



@end

@implementation GeradorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Abriu A tela");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gerarQRCode:(id)sender {
    _codigoLabel.text = [self randomString:10];
    UIImage *qrImage = [self generateQrCode:_codigoLabel.text];
    if (qrImage != NULL)
    {
        _imageQRCOde.image = qrImage;
    }
    
    
    
//    _codigoLabel.text = [self randomString:10];
//    _imageQRCOde.image = [self gerateQrCode:_codigoLabel.text];
    
    
}

-(NSString *)randomString:(int)lenght{
    NSString * letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: lenght];
    
    for (int i=0; i<lenght; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
    
    
//    uint32_t len = (uint32_t)letters.length;
//    NSString *randomString = @"";
//    for (int i = 0; i < lenght; i++)
//    {
//        uint32_t rand = arc4random_uniform(len);
//        unichar nextChar = [letters characterAtIndex:rand];
//        randomString = [NSString stringWithCharacters:&nextChar length:9];
//    }
//    
//    return randomString;
    
    
    
//NSString * letters = @"123456789";
// uint32_t len = (uint32_t)letters.length;
//    NSString *randomString = @"";
//    for (int i = 0; i < lenght; i++)
//    {
//        uint32_t rand = arc4random_uniform(len);
//        unichar nextChar = [letters characterAtIndex:rand];
//        randomString = [NSString stringWithCharacters:&nextChar length:10];
//    }
//    
//    return randomString;
}

-(id)generateQrCode:(NSString *)string
{
    
    NSData *data = [string dataUsingEncoding:(NSASCIIStringEncoding)];
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    CGAffineTransform transforms = CGAffineTransformMakeScale(10, 10);
    CIImage *output = [[filter outputImage] imageByApplyingTransform:transforms];
    
    if (output != NULL)
    {
        return [UIImage imageWithCIImage:output];
    }
    
    return nil;
//    NSData *data = [string dataUsingEncoding:(NSASCIIStringEncoding)];
//    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [filter setValue:data forKey:@"inputMessage"];
//    CGAffineTransform transforms = CGAffineTransformMakeScale(10, 10);
//    CIImage *output = [[filter outputImage] imageByApplyingTransform:transforms];
//    
//    if (output != NULL)
//    {
//        return [UIImage imageWithCIImage:output];
//    }
//    
//    return nil;
    
}





@end

//
//  GeradorViewController.m
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 07/07/17.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserve
//

#import "GeradorViewController.h"
#import "Pessoa.h"

@interface GeradorViewController ()

@end

@implementation GeradorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    //  [UITextField resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gerarQRCode:(id)sender {
    
    Pessoa *p = [[Pessoa alloc]init];
    p.nome = self.txtNome.text;
    p.idade = self.txtIdade.text.intValue;
    p.senha = self.txtSenha.text;
    p.cpf = self.txtCpf.text;
 
    
    NSLog(@"%@", p.nome);
    UIImage *qrImage;
    qrImage = [self generateQrCode:_textCPF.text];
    if (qrImage != NULL)
    {
        _imageQRCOde.image = qrImage;
    }
}

-(NSString *)randomString:(int)lenght{
    NSString * letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: lenght];
    
    for (int i=0; i<lenght; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
    
    

}


-(NSString *)randomcodeman:(int)lenght{
    return nil;
}


-(id)generateQrCode:(NSString *)string
{
  
    [self dismissKeyboard];
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

    
}





@end

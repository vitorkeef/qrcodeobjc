
//
//  GeradorViewController.m
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 07/07/17.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserve
//
#import "AFURLSessionManager.h"

#import "GeradorViewController.h"
#import "Pessoa.h"

@interface GeradorViewController ()

@end
int i = 0;
@implementation GeradorViewController
NSString *codigoID;
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self chamarAlerta];
}
-(void) chamarAlerta{
    
    UIAlertController *aviso = [UIAlertController
                                alertControllerWithTitle:@"Escolha a modalidade"
                                message:@""
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *pegarDoJson = [UIAlertAction
                                  actionWithTitle:@"Pegar Usuário Existente"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                      //  [self getjson];
                                      [self escolherUsuario];
                                  }];
    UIAlertAction *gerarUmNovo = [UIAlertAction
                                  actionWithTitle:@"Gerar Um novo usuário "
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                      NSLog(@"Clicou no Json");
                                  }];
    
    
    [aviso addAction:pegarDoJson];
    [aviso addAction:gerarUmNovo];
    
    [self presentViewController:aviso animated:YES completion: nil];
    
    
    
}


-(void) escolherUsuario{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Text"
                                                                   message:@"Enter some text below"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       if (alert.textFields.count > 0) {
                                                           
                                                           UITextField *textField = [alert.textFields firstObject];
                                                           
                                                           NSLog(textField.text);
                                                           i = [textField.text intValue];
                                                           [self getjson];
                                         
                                                        }
                                             
                                                   }];
    
    [alert addAction:submit];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"something"; // if needs
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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

-(void)getjson{
    NSLog(@"chegou");
    _txtNome.enabled = false;
    _txtIdade.enabled = false;
    _txtSenha.enabled = false;
    _txtSenhaConfirmar.enabled = false;
    _txtCpf.enabled = false;
    _btncadastrar.titleLabel.text = @"Novo";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURL *URL = [NSURL URLWithString:@"http://www.json-generator.com/api/json/get/cnagmdryEO?indent=2"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
           
            self.data = responseObject;

            NSString *nome = [[self.data objectAtIndex:i]objectForKey:@"name"];
            NSString *idade = [[[self.data objectAtIndex:i]objectForKey:@"idade"]stringValue];
            NSString *senha = [[[self.data objectAtIndex:i]objectForKey:@"senha"]stringValue];
            NSString *cpf = [[[self.data objectAtIndex:i]objectForKey:@"cpf"]stringValue];
            
            
            NSLog(@"nome: %@, idade:%@, senha:%@, cpf:%@",nome, idade, senha, cpf);
            
            _txtNome.text = nome;
            _txtIdade.text =  idade;
            _txtSenha.text = senha;
            _txtSenhaConfirmar.text = senha;
            _txtCpf.text = cpf;
            
            
        }
        [self gerarQRCode:_txtCpf.text];
    }];
    [dataTask resume];
    
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

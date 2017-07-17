

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
@interface ViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL estaLendo;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.captureSession = nil;
    self.estaLendo = NO;
    
    [self lerCodigo:self];

  
}

-(void)dismissKeyboard {
    //  [UITextField resignFirstResponder];
    [self.view endEditing:YES];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)lerCodigo:(UIButton *)sender {
    
    // precisamos primeiramente verificar se nosso usuario já não esta lendo algum código
    
    if (!_estaLendo) {
        
        if ([self comecarALer]) {
            
            // self.botaoLerCodigo.enabled = NO;
            self.status.text = @"Escaneando código";
            _statusLabel.text = @"";
            _statusView.backgroundColor = UIColor.whiteColor;
        }else{
            [self parandoLeitura];
        }
        
    }
    
    // inverte o valor de nosso booleano para que nossa action possa ser executa de novo
    self.estaLendo = !self.estaLendo;
    
}




-(BOOL)comecarALer{
    
    NSError *error;
    
    // criamos nossas instancias de captura de imagem
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // Se acontecer algum erro vai dar um log no erro
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // inicia a captura de imagem
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    // Create um novo serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //inicia o video preview e atribui ele a nossa view.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.CapturaDela.layer.bounds];
    [self.CapturaDela.layer addSublayer:_videoPreviewLayer];
    
    
    // começa a captura de tela
    [self.captureSession startRunning];
    
    return YES;
    
}

-(void)parandoLeitura{
    // para a captura de video
    [self.captureSession stopRunning];
    self.captureSession = nil;
    
    // Remove o preview do video da view
    [self.videoPreviewLayer removeFromSuperlayer];
}



-(void)checagemCodigo{
    
    NSArray *array = @[@"teste", @"segunda palavra", @"terceiro", @"alianca"];
    
    BOOL hasString = [array containsObject:_status.text];
    if (hasString){
        //NSLog(@"%@", hasString);
        NSLog(@"tem string");
        _statusView.backgroundColor = UIColor.greenColor;
        _statusLabel.text = @"OK";
    }else if (!hasString){
        NSLog(@"nao tem");
        _statusView.backgroundColor = UIColor.redColor;
        _statusLabel.text = @"erro";
    }
    
    
    //    if ([_status.text  is2l: @"teste"]) {
    //        NSLog(@"OK");
    //        _statusView.backgroundColor = UIColor.greenColor;
    //        _statusLabel.text = @"OK";
    //    }
    //    else{
    //        NSLog(@"N OK");
    //        _statusView.backgroundColor = UIColor.redColor;
    //
    //    }
    
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // esse metodo é onde "ligamos" nossa camera para fazer a leitura
    NSLog(@"leu");
    
    // checa se o metadataObjects array não é vazio, e que contem ao menos 1 objeto
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            [self.status performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            [self performSelectorOnMainThread:@selector(parandoLeitura) withObject:nil waitUntilDone:NO];
            [self.botaoLerCodigo performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            self.estaLendo = NO;
            
            // lembra do primeiro metodo que criamos, então agora que utilizamo ele
            // verifica se nosso audio não for nil executa o som
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
    NSString *string1 = _status.text;
    
    
    if ([string1 hasSuffix: @"com"] | [string1 hasSuffix: @"br"] |[string1 hasSuffix: @"org"] ){
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:string1]
        NSString *linkFinal = @"http://";
        linkFinal = [linkFinal stringByAppendingString:string1];
        NSLog(@"%@", string1);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:  linkFinal]];
        ;}else if ([string1 hasPrefix:@"http://"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string1]
             ];}
    
    if ([string1 hasPrefix:@"SMS"]) {
        [self showSMS:@"teste"];
    }
    
    [self checagemCodigo];
    
}
- (void)showSMS:(NSString*)file {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    NSString *mensagem = _status.text;
    NSString *contato = [mensagem substringWithRange:NSMakeRange(6, 10)];
    float tamanhoMensagem = [mensagem length];
    
    //    NSString *textomensagem = [mensagem substringWithRange:NSMakeRange(10, 10 )];
    NSLog(@"%@", contato);
    NSLog(@"%f", tamanhoMensagem);
    //    NSLog(@"%@ textomensagem", textomensagem);
    NSLog(@"%@", mensagem);
    
    //SMSTO:1197992979:jj
    NSArray *recipents = @[contato];
    NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

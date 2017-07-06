//
//  ViewController.swift
//  qrcodeswift
//
//  Created by MakroTest on 05/07/17.
//  Copyright © 2017 MakroTest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var codigoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let n = randomString(length: 99)
//        print("String")
//        print (n)
//        imageDisplay.image = generateQrCode(string: n)
//        tfInput.text = n
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func generatebarcode(_ sender: Any) {
        //imageDisplay.image = generateBarcodeFromString(string: tfInput.text!)
        codigoLabel.text = randomString(length: 10)
        imageDisplay.image = generateBarcodeFromString(string: codigoLabel.text!)
    }

    @IBAction func generateqrcode(_ sender: Any) {
        codigoLabel.text = randomString(length: 10)
        imageDisplay.image = generateQrCode(string: codigoLabel.text!)
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func generateBarcodeFromString(string : String) -> UIImage? {
     
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
       // let transform = GAffineTransformMakeScale(10,10)
       let transforms =  CGAffineTransform(scaleX: 10, y: 10)
    
        let output = filter?.outputImage?.applying(transforms)
        if (output != nil) {
            return UIImage(ciImage:output!)
            
        }
        return nil;
    }
    
    func generateQrCode(string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        // let transform = GAffineTransformMakeScale(10,10)
        let transforms =  CGAffineTransform(scaleX: 10, y: 10)
        
        let output = filter?.outputImage?.applying(transforms)
        if (output != nil) {
            return UIImage(ciImage:output!)
            
        }
        return nil;
    }
    

}


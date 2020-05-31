//
//  ImageEditorViewController.swift
//  SlideshowApp
//
//  Created by Hiroki Sato on 2020/05/31.
//  Copyright © 2020 hiroki.sato. All rights reserved.
//

import UIKit

class ImageEditorViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var argImage:UIImage! = nil
    
    var scale:CGFloat = 1 //拡大率
    var width:CGFloat = 0 //画像の横幅
    var height:CGFloat = 0 //画像の縦幅
    var screenWidth:CGFloat = 0 //画面の横幅
    var screenHeight:CGFloat = 0 //画面の縦幅
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 引数の画像を設定
        imageView.image = argImage
        
        // 画面サイズ取得
        screenWidth = self.view.bounds.width
        screenHeight = self.view.bounds.height
        
        //画像サイズ取得
        width = imageView.bounds.width
        height = imageView.bounds.height
        // 比率
        scale = screenHeight/height
        
        //画像の初期ポジ設定
        let rect = CGRect(x:0,y: 0, width: 100*scale, height: 100*scale)
        imageView.frame = rect
        imageView.center = CGPoint(x:width/2, y:height/2)
        self.view.addSubview(imageView)
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func scaleButton(_ sender: Any) {
        scale += 1
        // 大きくしすぎた場合
        if scale > 5{
            //リセット
            scale = screenHeight/height
        }
        let rect = CGRect(x: 0,y:0, width: 100*scale, height: 100*scale)
        imageView.frame = rect
        imageView.center = CGPoint(x:width/2, y:height/2)
        self.view.addSubview(imageView)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

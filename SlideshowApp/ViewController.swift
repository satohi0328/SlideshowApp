//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Hiroki Sato on 2020/05/31.
//  Copyright © 2020 hiroki.sato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imageList:[String] = ["1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","9.png","10.png","11.png","12.png"]
    var imageNo:Int = 1 // 画像番号
    var repeatFlg:Bool = false // スライドショーの再生/停止フラグ
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    var timer: Timer! // タイマー
    var buttonColor:UIColor! //ボタンの色
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: imageList[0])
        // ボタンの色を保持
        buttonColor = startButton.backgroundColor
    }
    
    @IBAction func nextButton(_ sender: Any) {
        //表示する画像番号をインクリメント
        imageNo += 1
        // 画像番号が画像配列を超えた場合
        if imageNo > imageList.count {
            //画像番号初期化
            imageNo = 1
        }
        //画像表示
        showImage()
    }
    
    @IBAction func backButton(_ sender: Any) {
        //表示する画像番号をデクリメント
        imageNo -= 1
        // 画像番号が画像配列を超えた場合
        if imageNo < 1 {
            //画像番号を最後に設定
            imageNo = imageList.count
        }
        //画像表示
        showImage()
    }
    
    @IBAction func autoRepeatButton(_ sender: Any) {
        //再生/停止フラグを反転
        repeatFlg = !repeatFlg
        
        // 再生中の場合
        if repeatFlg {
            // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            }
            // 停止中の場合
        }else{
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil
        }
        
        //進む,戻るボタンの活性/非活性処理呼び出し
        editButton(!repeatFlg)
    }
    // 2秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        //表示する画像番号をインクリメント
        imageNo += 1
        // 画像番号が画像配列を超えた場合
        if imageNo > imageList.count {
            //画像番号初期化
            imageNo = 1
        }
        //画像表示
        showImage()
    }
    
    @IBAction func tapImage(_ sender: Any) {
        
        //スライドショー再生中の場合は一旦停止
        if repeatFlg {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil
        }
        // 画面遷移
        performSegue(withIdentifier: "imageEditor", sender: nil)
    }
    
    private func showImage(){
        // 画像表示(indexは画像番号-1)
        imageView.image = UIImage(named: imageList[imageNo - 1])
    }
    
    // 再生/停止ボタン押下時のボタン編集処理
    private func editButton(_ flg:Bool){
        startButton.isEnabled = flg
        backButton.isEnabled = flg
        if flg{
            startButton.backgroundColor = buttonColor
            backButton.backgroundColor = buttonColor
        }else{
            startButton.backgroundColor = UIColor.gray
            backButton.backgroundColor = UIColor.gray
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageEditor"{
            let imgEdtVC:ImageEditorViewController = segue.destination as! ImageEditorViewController
            
            //設定されている画像を次画面へ渡す
            imgEdtVC.argImage = imageView.image
        }
    }
    

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 画面に戻ってきたときに、スライドショー再生中だった場合
        if repeatFlg {
            // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            }
        }
    }
    
}


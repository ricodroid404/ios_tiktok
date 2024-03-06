//
//  ViewController.swift
//  ios_BRAIN_PUMP_UP
//
//  Created by r_murata on 2024/03/01.
//

import UIKit
import AVKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 一つのUIViewに要素を追加
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        scrollView.isPagingEnabled = true
        
        // containerViewの制約設定
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // 各動画のURLを定義した配列
        let videoURLs = [
            "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/flower.mp4",
            "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/test_30mb.mp4",
            "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/Video+MP4_Moon+-+testfile.org.mp4",
            "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/pexels-cristian-rossa-20208157+(Original).mp4",
            "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/file_example_MP4_1920_18MG.mp4"
        ]
        
        // 各動画を表示するAVPlayerViewControllerを作成して配置する
        var previousView: UIView?
        for videoURLString in videoURLs {
            guard let videoURL = URL(string: videoURLString) else {
                continue
            }
            
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            addChild(playerViewController)
            containerView.addSubview(playerViewController.view)
            playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                playerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                playerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                playerViewController.view.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? containerView.topAnchor),
                playerViewController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                playerViewController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
            
            playerViewController.didMove(toParent: self)
            player.play()
            
            previousView = playerViewController.view
        }
        
        // 最後の動画プレーヤーのbottomAnchorをcontainerViewのbottomAnchorに合わせる
        NSLayoutConstraint.activate([
            previousView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

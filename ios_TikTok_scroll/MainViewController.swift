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
        
        var previousView: UIView?
        var downloadedVideoURLs: [URL] = []
        
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
            URL(string: "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/flower.mp4")!,
            URL(string: "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/test_30mb.mp4")!,
            URL(string: "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/Video+MP4_Moon+-+testfile.org.mp4")!,
            URL(string: "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/pexels-cristian-rossa-20208157+(Original).mp4")!,
            URL(string: "https://test-pvg-video-contents-bucket.s3.ap-northeast-1.amazonaws.com/file_example_MP4_1920_18MG.mp4")!
        ]

        for url in videoURLs {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
            
            // downloadVideoメソッドを呼び出す
            downloadVideo(fromURLs: videoURLs) { success in
                if success {
                    print("すべての動画のダウンロードと保存が成功しました。")
                    
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    for url in videoURLs {
                        let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
                        downloadedVideoURLs.append(destinationURL)
                        print("ダウンロードされた動画のファイルパス: \(destinationURL)")
                    }
                           
                } else {
                    print("少なくとも1つの動画のダウンロードまたは保存に失敗しました。")
                }
            }
        }
        
        // 各動画を表示するAVPlayerViewControllerを作成して配置する
       
//        for videoURLString in videoURLs {
//            guard let videoURL = URL(string: videoURLString) else {
//                continue
//            }
//            
//            let player = AVPlayer(url: videoURL)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            addChild(playerViewController)
//            containerView.addSubview(playerViewController.view)
//            playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                playerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//                playerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//                playerViewController.view.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? containerView.topAnchor),
//                playerViewController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//                playerViewController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//            ])
//            
//            playerViewController.didMove(toParent: self)
//            player.play()
//            
//            previousView = playerViewController.view
//        }
//        
//        // 最後の動画プレーヤーのbottomAnchorをcontainerViewのbottomAnchorに合わせる
//        NSLayoutConstraint.activate([
//            previousView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        ])
    }
    
    // 動画ダウンロード
    func downloadVideo(fromURLs urls: [URL], completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        var success = true
        
        for url in urls {
            group.enter()
            let task = URLSession.shared.downloadTask(with: url) { (temporaryURL, response, error) in
                guard let temporaryURL = temporaryURL else {
                    success = false
                    group.leave()
                    return
                }
                
                do {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let destinationURL = documentsDirectory.appendingPathComponent(temporaryURL.lastPathComponent)
                    
                    // Remove file if it exists to allow overwriting
                    if FileManager.default.fileExists(atPath: destinationURL.path) {
                        try FileManager.default.removeItem(at: destinationURL)
                    }
                    
                    try FileManager.default.moveItem(at: temporaryURL, to: destinationURL)
                } catch {
                    success = false
                }
                
                group.leave()
            }
            task.resume()
        }
        
        group.notify(queue: .main) {
            completion(success)
        }
    }
}

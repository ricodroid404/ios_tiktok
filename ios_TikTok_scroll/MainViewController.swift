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
        
        scrollView.delegate = self
        
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
        
        let group = DispatchGroup()
        
        for url in videoURLs {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
            
            // グループに入る
            group.enter()
            
            // downloadVideoメソッドを呼び出す
            downloadVideo(fromURLs: videoURLs) { success in
                defer {
                    // グループから出る
                    group.leave()
                }
                
                if success {
                    print("ダウンロード成功: \(destinationURL)")
                    downloadedVideoURLs.append(destinationURL)
                } else {
                    print("ダウンロード失敗: \(url)")
                }
            }
        }
        
        
        // すべてのダウンロードが完了した時の処理
        group.notify(queue: .main) {
            // インジケーターを非表示にする
            // ここでインジケーターを非表示にするコードを追加
            
            if downloadedVideoURLs.count == videoURLs.count {
                print("すべての動画のダウンロードと保存が成功しました。")
                
                for videoURL in downloadedVideoURLs {
                    let playerItem = AVPlayerItem(url: videoURL)
                    let player = AVPlayer(playerItem: playerItem)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.addChild(playerViewController)
                    containerView.addSubview(playerViewController.view)
                    playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        playerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        playerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        playerViewController.view.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? containerView.topAnchor),
                        playerViewController.view.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                        playerViewController.view.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
                    ])
                    
                    playerViewController.didMove(toParent: self)
                    player.play()
                    
                    previousView = playerViewController.view
                }
                
                // 最後の動画プレーヤーのbottomAnchorをcontainerViewのbottomAnchorに合わせる
                NSLayoutConstraint.activate([
                    previousView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
                
            } else {
                print("少なくとも1つの動画のダウンロードまたは保存に失敗しました。")
            }
        }
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

// ページスクロールを検知する
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            print("currentPage:", scrollView.currentPage)
            print("contentSizeの確認1:", scrollView.contentSize)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("currentPage:", scrollView.currentPage)
        print("contentSizeの確認2:", scrollView.contentSize)
    }
}

extension UIScrollView {
    var currentPage: Int {
        let pageWidth = self.bounds.width
        let currentPage = Int((self.contentOffset.x + (0.5 * pageWidth)) / pageWidth)
        
        return currentPage + 1
    }
}


//
//  ViewController.swift
//  ios_BRAIN_PUMP_UP
//
//  Created by r_murata on 2024/03/01.
//

import UIKit

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
            
            // 各ビューの色を定義した配列
            let colors: [UIColor] = [.systemRed, .systemYellow, .systemOrange, .systemBlue, .systemGreen]
            
            // 各ビューを作成して配置する
            var previousView: UIView?
            for color in colors {
                let view = UIView()
                view.backgroundColor = color
                containerView.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                    view.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? containerView.topAnchor),
                    view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                    view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                ])
                
                previousView = view
            }
            
            // 最後のビューのbottomAnchorをcontainerViewのbottomAnchorに合わせる
            NSLayoutConstraint.activate([
                previousView!.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        }
    
}


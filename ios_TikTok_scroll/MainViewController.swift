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
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let v1 = UIView()
        v1.backgroundColor = .systemRed
        containerView.addSubview(v1)
        v1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            v1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            v1.topAnchor.constraint(equalTo: containerView.topAnchor),
            v1.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Width equals scrollView's width
            v1.heightAnchor.constraint(equalTo: scrollView.heightAnchor), // Height equals scrollView's height
        ])
        
        let v2 = UIView()
        v2.backgroundColor = .systemYellow
        containerView.addSubview(v2)
        v2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            v2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            v2.topAnchor.constraint(equalTo: v1.bottomAnchor),
            v2.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Width equals scrollView's width
            v2.heightAnchor.constraint(equalTo: scrollView.heightAnchor), // Height equals scrollView's height
        ])
        
        let v3 = UIView()
        v3.backgroundColor = .systemOrange
        containerView.addSubview(v3)
        v3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            v3.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            v3.topAnchor.constraint(equalTo: v2.bottomAnchor),
            v3.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Width equals scrollView's width
            v3.heightAnchor.constraint(equalTo: scrollView.heightAnchor), // Height equals scrollView's height
        ])
        
        let v4 = UIView()
        v4.backgroundColor = .systemBlue
        containerView.addSubview(v4)
        v4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v4.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            v4.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            v4.topAnchor.constraint(equalTo: v3.bottomAnchor),
            v4.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Width equals scrollView's width
            v4.heightAnchor.constraint(equalTo: scrollView.heightAnchor), // Height equals scrollView's height
        ])
        
        let v5 = UIView()
        v5.backgroundColor = .systemGreen
        containerView.addSubview(v5)
        v5.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v5.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            v5.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            v5.topAnchor.constraint(equalTo: v4.bottomAnchor),
            v5.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Width equals scrollView's width
            v5.heightAnchor.constraint(equalTo: scrollView.heightAnchor), // Height equals scrollView's height
            v5.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
}


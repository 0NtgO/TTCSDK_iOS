//
//  TTCBindViewController.swift
//  TTC_SDK
//
//  Created by Zhang Yufei on 2018/7/3  下午8:03.
//  Copyright © 2018年 tataufo. All rights reserved.
//

import UIKit
import TTC_SDK_NET

enum Language {
    case TTCWallet
    case Bind
    case AutomaticImportTTC
    
    func title(key: String) -> String {
        
        if key == "cn" {
            switch self {
            case .TTCWallet:
                return "TTC Connect"
            case .Bind:
                return "绑定"
            case .AutomaticImportTTC:
                return " 自动导入TTC"
            }
        } else {
            switch self {
            case .TTCWallet:
                return "TTC Connect"
            case .Bind:
                return "Bind"
            case .AutomaticImportTTC:
                return " Automatic import TTC"
            }
        }
    }
}

internal class TTCBindViewController: TTCViewController {
    
    let language: String
    
    let closeBtn = UIButton(frame: CGRect(x: 9, y: 19 + iPhoneXNavBarOffset, width: 44, height: 44))
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 22 + iPhoneXNavBarOffset, width: 50, height: 40))
    let walletIcon = TTCAppIcon()
    let appIcon = TTCAppIcon()
    let arrow = UIImageView(frame: CGRect(x: 170, y: 170, width: 36, height: 20))
    let bindBtn = UIButton(frame: CGRect(x: 20, y: 272, width: 335, height: 34))
    let importBtn = UIButton()
    
    init(language: String) {
        self.language = language
        super.init(nibName: nil, bundle: nil)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        
        view.addSubview(closeBtn)
        view.addSubview(titleLabel)
        view.addSubview(walletIcon)
        view.addSubview(arrow)
        view.addSubview(appIcon)
        view.addSubview(bindBtn)
        view.addSubview(importBtn)
        
        closeBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.setImage(UIImage.TTCImg(name: "close_normal"), for: .normal)
        closeBtn.setImage(UIImage.TTCImg(name: "close_highlighted"), for: .highlighted)
        closeBtn.addTarget(self, action: #selector(closeBtnClick(_:)), for: .touchUpInside)
        
        titleLabel.textAlignment = .center
        titleLabel.text = Language.Bind.title(key: language)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 43/255.0, green: 46/255.0, blue: 61/255.0, alpha: 1)
        
        walletIcon.setAppiconAndTitle(icon: UIImage.TTCImg(name: "TTCWallet"), title: Language.TTCWallet.title(key: language))
        var appName = ""
        let info = Bundle.main.infoDictionary
        if info != nil, ((info!["CFBundleDisplayName"] as? String) != nil) {
            appName = info!["CFBundleDisplayName"] as! String
        }
        //NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        var dappIcon = UIImage(named: "AppIcon60x60")
        if dappIcon == nil {
            dappIcon = UIImage(named: "AppIcon")
        }
        
        appIcon.setAppiconAndTitle(icon: dappIcon, title: appName)
        arrow.image = UIImage.TTCImg(name: "Relation")
        
        bindBtn.setTitle(Language.Bind.title(key: language), for: .normal)
        bindBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bindBtn.setTitleColor(UIColor.white, for: .normal)
        bindBtn.backgroundColor = UIColor(red: 1/255.0, green: 2/255.0, blue: 141/255.0, alpha: 1)
        bindBtn.layer.cornerRadius = 4.5
        bindBtn.layer.masksToBounds = true
        bindBtn.addTarget(self, action: #selector(bindBtnClick(_:)), for: .touchUpInside)
        
        importBtn.setTitle(Language.AutomaticImportTTC.title(key: language), for: .normal)
        importBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        importBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        importBtn.setTitleColor(UIColor(red: 43/255.0, green: 46/255.0, blue: 61/255.0, alpha: 1), for: .normal)
        importBtn.setImage(UIImage.TTCImg(name: "select"), for: .normal)
        importBtn.setImage(UIImage.TTCImg(name: "selected"), for: .selected)
        importBtn.isSelected = true
        importBtn.addTarget(self, action: #selector(importBtnClick(_:)), for: .touchUpInside)
        importBtn.frame = CGRect(x: 100, y: 318, width: (importBtn.currentTitle!.textWidth(font: importBtn.titleLabel!.font!) + 30), height: 42)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let x = self.view.bounds.size.width
        let y = self.view.bounds.size.height
        let iconX: CGFloat = (x - appIcon.frame.size.width*2 - arrow.bounds.size.width) / 2.0
        var iconY: CGFloat
        if x < y {

            iconY = 140 + iPhoneXNavBarOffset
            bindBtn.frame = CGRect(x: 20, y: iconY + walletIcon.frame.size.height + 40, width: x - 40, height: 34)
        } else {
            iconY = 100
            bindBtn.frame = CGRect(x: (x - 335) / 2.0, y: iconY + walletIcon.frame.size.height + 40, width: 335, height: 34)
        }
        titleLabel.frame = CGRect(x: (x - 50)/2.0, y: 22, width: 50, height: 40)
        walletIcon.frame = CGRect(origin: CGPoint(x: iconX, y: iconY), size: walletIcon.frame.size)
        let arrowY = iconY + (appIcon.appIcon.frame.size.height - arrow.frame.size.height) / 2.0 + appIcon.appIcon.frame.origin.y
        arrow.frame = CGRect(origin: CGPoint(x: iconX + appIcon.frame.size.width, y: arrowY), size: arrow.frame.size)
        appIcon.frame = CGRect(origin: CGPoint(x: iconX + appIcon.frame.size.width + arrow.frame.size.width, y: iconY), size: walletIcon.frame.size)
        importBtn.frame = CGRect(origin: CGPoint(x: (x - importBtn.frame.size.width) / 2.0, y: bindBtn.frame.maxY), size: importBtn.frame.size)
    }

    @objc private func bindBtnClick(_ sender: UIButton) {

        sender.isEnabled = false
        TTCNetworkManager.bindingDapp(isBind: true, walletAddress: TTCManager.shared.walletAddress!, autoTransaction: importBtn.isSelected) { (success, error) -> Void in
            sender.isEnabled = true
            
            if success {
                TTCPrint("bind - Bind successfully, address: \(TTCManager.shared.walletAddress!)")
                TTCManager.shared.backWallet(bindState: 1)
                self.dismiss(animated: true, completion: nil)
            } else {
                TTCPrint("bind - Bind failed: \(String(describing: error?.errorDescription))")
                TTCManager.shared.backWallet(bindState: 0)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func importBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc private func closeBtnClick(_ sender: UIButton) {
        
        TTCManager.shared.backWallet(bindState: -1)
        self.dismiss(animated: true, completion: nil)
    }
}

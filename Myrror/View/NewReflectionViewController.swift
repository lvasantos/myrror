//
//  NewReflectionViewController.swift
//  Myrror
//
//  Created by Lais Godinho on 08/09/22.
//

import UIKit
import Lottie

class NewReflectionViewController: UIViewController {
    var navigationTitle : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Primary")
        
        navigationController?.navigationBar.items?[1].backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        
        
        view.addSubview(pageTitle)
        configPageTitle()
        
        view.addSubview(confirmationButton)
        configConfirmationButton()
        
        view.addSubview(reflectionText)
        configReflectionText()
        
        view.addSubview(subTitle)
        configSubTitle()
        
        configTapGesture()
        view.addSubview(backgroundView)
        configBackgroundView()
    }
    
    lazy var pageTitle : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = navigationTitle
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    func configPageTitle() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    let reflectionText : UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 10, y: 10, width: 30, height: 10)
        textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textAlignment = .justified
        textView.backgroundColor = .systemFill
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func configReflectionText() {
        NSLayoutConstraint.activate([
            reflectionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reflectionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            reflectionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            reflectionText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            reflectionText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100)
        ])
    }
    
    let subTitle : UILabel = {
        let subTitle = UILabel()
        subTitle.text = "Como isso te faz se sentir?"
        subTitle.font = UIFont.boldSystemFont(ofSize: 20)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    
    func configSubTitle() {
        NSLayoutConstraint.activate([
            subTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            subTitle.topAnchor.constraint(equalTo: reflectionText.bottomAnchor, constant: 60),
        ])
    }
    
     let backgroundView : UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 8
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .systemFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let emojisName : [String] = ["raiva", "triste", "indiferente", "feliz", "confiante"]
        
        // MARK: Não esquecer de configurar!!!
        for i in 0...4 {
            let animationView = AnimationView()
            
            animationView.animation = Animation.named(emojisName[i])
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.accessibilityLabel = emojisName[i]
            animationView.isAccessibilityElement = true
            
            stackView.addArrangedSubview(animationView)
            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.widthAnchor.constraint(equalTo: animationView.heightAnchor).isActive = true
            stackView.isUserInteractionEnabled = true
        }
        
        return stackView
    }()

    func configTapGesture(){
        for emoji in backgroundView.arrangedSubviews {
            let tapRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(handleEmojiTap(sender: )))
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            emoji.addGestureRecognizer(tapRecognizer)
            emoji.isUserInteractionEnabled = true
        }
    }
    
    @objc func handleEmojiTap(sender: UITapGestureRecognizer) {
        guard let animationView = sender.view as? AnimationView else { return }
        if sender.state == .ended {
            animationView.play()
        }
    }
    
    func configBackgroundView() {
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            backgroundView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 35),
            backgroundView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    let confirmationButton : UIButton = {
        var configButton = UIButton.Configuration.filled()
        configButton.image = UIImage(systemName: "square.and.arrow.down")
        configButton.title = "Finalizar"
        configButton.imagePadding = 150
                
        let button = UIButton(type: .system)
        button.configuration = configButton
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft

        return button
    }()
    
    func configConfirmationButton () {
        NSLayoutConstraint.activate([
            confirmationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            confirmationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            confirmationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            confirmationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

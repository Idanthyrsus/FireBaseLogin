//
//  SceneDelegate.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(with: scene)
        checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            // Go to sign in screen
            self.goToController(with: LoginViewController())
        } else {
            // Go to home screen
            self.goToController(with: HomeViewController())
        }
    }
    
    private func goToController(with viewContoroller: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewContoroller)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
            }
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.window?.layer.opacity = 1
            }
        }
    }
}


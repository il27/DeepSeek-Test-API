//
//  KeyboardManager.swift
//  DeepSeek Test API
//
//  Created by Ильяс on 11.08.2025.
//

import UIKit

final class KeyboardManager {
    private weak var view: UIView?
    private weak var textFieldBottomConstraint: NSLayoutConstraint?
    private weak var buttonBottomConstraint: NSLayoutConstraint?

    private var keyboardWillShowObserver: NSObjectProtocol?
    private var keyboardWillHideObserver: NSObjectProtocol?

    init(
        view: UIView,
        textFieldBottomConstraint: NSLayoutConstraint,
        buttonBottomConstraint: NSLayoutConstraint
    ) {
        self.view = view
        self.textFieldBottomConstraint = textFieldBottomConstraint
        self.buttonBottomConstraint = buttonBottomConstraint
        subscribeToKeyboardNotifications()
    }

    deinit {
        unsubscribeFromKeyboardNotifications()
    }

    private func subscribeToKeyboardNotifications() {
        let nc = NotificationCenter.default
        keyboardWillShowObserver = nc.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillShow(notification: notification)
        }
        keyboardWillHideObserver = nc.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillHide(notification: notification)
        }
    }

    private func unsubscribeFromKeyboardNotifications() {
        let nc = NotificationCenter.default
        if let observer = keyboardWillShowObserver {
            nc.removeObserver(observer)
        }
        if let observer = keyboardWillHideObserver {
            nc.removeObserver(observer)
        }
    }

    private func keyboardWillShow(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let kbFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }

        let kbHeight = kbFrame.height

        // Поднимаем textField и кнопку на высоту клавиатуры
        textFieldBottomConstraint?.constant = -kbHeight - 8
        buttonBottomConstraint?.constant = -kbHeight - 8

        let options = UIView.AnimationOptions(rawValue: animationCurveRaw << 16)
        UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
            self.view?.layoutIfNeeded()
        }, completion: nil)
    }

    private func keyboardWillHide(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }

        // Возвращаем к исходному отступу
        textFieldBottomConstraint?.constant = -16
        buttonBottomConstraint?.constant = -16

        let options = UIView.AnimationOptions(rawValue: animationCurveRaw << 16)
        UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
            self.view?.layoutIfNeeded()
        }, completion: nil)
    }
}






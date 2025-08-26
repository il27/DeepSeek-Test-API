////
////  KeyboardManager.swift
////  DeepSeek Test API
////
////  Created by Ильяс on 11.08.2025.
////
//
//import UIKit
//
//final class KeyboardManager {
//    private weak var view: UIView?
//    private var scrollView: UIScrollView?
//    private var activeTextField: UITextField?
//    
//    init(view: UIView, scrollView: UIScrollView? = nil) {
//        self.view = view
//        self.scrollView = scrollView
//        setupTapGesture()
//        setupObservers()
//    }
//    
//    deinit {
//        removeObservers()
//    }
//    
//    private func setupTapGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view?.addGestureRecognizer(tap)
//    }
//    
//    private func setupObservers() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
//    }
//    
//    private func removeObservers() {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc private func dismissKeyboard() {
//        view?.endEditing(true)
//    }
//    
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard
//            let userInfo = notification.userInfo,
//            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//            let view = view,
//            let activeField = activeTextField
//        else { return }
//        
//        if let scrollView = scrollView {
//            handleScrollViewAdjustment(
//                scrollView: scrollView,
//                keyboardFrame: keyboardFrame,
//                activeField: activeField,
//                userInfo: userInfo
//            )
//        } else {
//            handleViewAdjustment(
//                view: view,
//                keyboardFrame: keyboardFrame,
//                activeField: activeField,
//                userInfo: userInfo
//            )
//        }
//    }
//    
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        if let scrollView = scrollView {
//            UIView.animate(withDuration: 0.3) {
//                scrollView.contentInset = .zero
//                scrollView.scrollIndicatorInsets = .zero
//            }
//        } else {
//            UIView.animate(withDuration: 0.3) {
//                self.view?.frame.origin.y = 0
//            }
//        }
//    }
//    
//    private func handleScrollViewAdjustment(
//        scrollView: UIScrollView,
//        keyboardFrame: CGRect,
//        activeField: UITextField,
//        userInfo: [AnyHashable: Any]
//    ) {
//        let keyboardFrameInView = view!.convert(keyboardFrame, from: nil)
//        let safeAreaFrame = view!.safeAreaLayoutGuide.layoutFrame
//        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
//        
//        scrollView.contentInset.bottom = intersection.height
//        scrollView.scrollIndicatorInsets.bottom = intersection.height
//        
//        let fieldFrame = activeField.convert(activeField.bounds, to: scrollView)
//        scrollView.scrollRectToVisible(fieldFrame, animated: true)
//    }
//    
//    private func handleViewAdjustment(
//        view: UIView,
//        keyboardFrame: CGRect,
//        activeField: UITextField,
//        userInfo: [AnyHashable: Any]
//    ) {
//        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
//        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
//        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
//        
//        let fieldFrame = activeField.convert(activeField.bounds, to: view)
//        let fieldBottom = fieldFrame.maxY
//        let keyboardTop = keyboardFrameInView.minY
//        
//        if fieldBottom > keyboardTop {
//            UIView.animate(withDuration: 0.3) {
//                view.frame.origin.y = -(fieldBottom - keyboardTop + 20)
//            }
//        }
//    }
//    
//    func setActiveTextField(_ textField: UITextField?) {
//        activeTextField = textField
//    }
//}
//

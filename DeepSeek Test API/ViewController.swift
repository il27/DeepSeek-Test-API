//
//  ViewController.swift
//  DeepSeek Test API
//
//  Created by Ильяс on 25.07.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let network = RequestDeepSeek()
    private var messages: [String] = [] // Изменяемый массив сообщений
    
    lazy var tableViewDeepSeek: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.separatorStyle = .none // Убираем разделители для красоты
        return $0
    }(UITableView())
    
    lazy var textPromtDeepSeek: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.placeholder = "Напиши промт"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0)) // Отступ слева
        $0.leftViewMode = .always
        return $0
    }(UITextField())
    
    lazy var buttonDeepSeek: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBlue
        $0.setTitle("→", for: .normal) // Стрелка вместо текста
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.addAction(UIAction { [weak self] _ in
            self?.sendMessage()
        }, for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupTapGesture() // Добавляем распознаватель тапов
        
        // Добавляем тестовое сообщение при запуске
        messages.append("🤖: Привет! Я твой помощник по Swift. Задай мне вопрос! hi")
        tableViewDeepSeek.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textPromtDeepSeek.layer.cornerRadius = textPromtDeepSeek.frame.height / 2
        buttonDeepSeek.layer.cornerRadius = buttonDeepSeek.frame.height / 2
    }
    
    private func setupTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.cancelsTouchesInView = false // Разрешаем передачу тапов дальше
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
            // Если клавиатура показана - скрываем её
            if textPromtDeepSeek.isFirstResponder {
                textPromtDeepSeek.resignFirstResponder()
            }
        }
    
    func setupUI() {
        view.addSubview(tableViewDeepSeek)
        view.addSubview(textPromtDeepSeek)
        view.addSubview(buttonDeepSeek)
        
        NSLayoutConstraint.activate([
            tableViewDeepSeek.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewDeepSeek.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewDeepSeek.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewDeepSeek.bottomAnchor.constraint(equalTo: textPromtDeepSeek.topAnchor, constant: -8),
            
            textPromtDeepSeek.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textPromtDeepSeek.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textPromtDeepSeek.trailingAnchor.constraint(equalTo: buttonDeepSeek.leadingAnchor, constant: -16),
            textPromtDeepSeek.heightAnchor.constraint(equalToConstant: 54),
            
            buttonDeepSeek.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonDeepSeek.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonDeepSeek.heightAnchor.constraint(equalToConstant: 54),
            buttonDeepSeek.widthAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func sendMessage() {
        guard let text = textPromtDeepSeek.text, !text.isEmpty else { return }
        
        // Очищаем поле ввода
        textPromtDeepSeek.text = nil
        
        // Добавляем сообщение пользователя
        messages.append("👤: \(text)")
        tableViewDeepSeek.reloadData()
        scrollToBottom()
        
        // Отправляем запрос
        network.sendRequest(message: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // Добавляем ответ ИИ
                    self?.messages.append("🤖: \(response)")
                case .failure(let error):
                    // Добавляем сообщение об ошибке
                    self?.messages.append("🚫: Ошибка: \(error.localizedDescription)")
                }
                self?.tableViewDeepSeek.reloadData()
                self?.scrollToBottom()
            }
        }
    }
    
    private func scrollToBottom() {
        guard !messages.isEmpty else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableViewDeepSeek.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Настройка ячейки
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = messages[indexPath.row]
        
        // Стилизация в зависимости от отправителя
        if messages[indexPath.row].hasPrefix("👤") {
            // Сообщение пользователя
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .darkText
            cell.contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        } else if messages[indexPath.row].hasPrefix("🚫") {
            // Ошибка
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .systemRed
            cell.contentView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        } else {
            // Сообщение ИИ
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .darkText
            cell.contentView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        }
        
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}



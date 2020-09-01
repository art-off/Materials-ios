//
//  TestViewController.swift
//  Materials
//
//  Created by art-off on 20.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController {
    
    // MARK: - Properties
    var materialId: Int!
    private var tests: [Test]!
    private var sections: [String]!

    private var currTestNumber: Int!
    private var currQuestion: String!
    private var currAnswers: [String]!
    private var currCorrectAnswer: Int!
    
    private var countCorrectAnswers: Int!
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    
    // MARK: - Initizlization
    convenience init(tests: [Test], materialId: Int) {
        self.init()
        
        self.tests = tests
        self.materialId = materialId
    }
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        tableView.backgroundColor = Colors.backgroupd
        tableView.separatorStyle = .none
        
        tableView.register(
            UINib(nibName: "LabelViewCell", bundle: nil),
            forCellReuseIdentifier: LabelViewCell.reuseIdentifier)
        tableView.register(
            CustomHeader.self,
            forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            "Вопрос",
            "Ответы"
        ]
        
        countCorrectAnswers = 0
        
        currTestNumber = -1
        updateCurrTest()
    }
    
    // MARK: - Private Methods
    private func updateCurrTest() {
        guard currTestNumber < tests.count - 1 else { return }
        currTestNumber += 1
        
        let test = tests[currTestNumber]
        
        currQuestion = test.question
        currAnswers = [
            test.answer1,
            test.answer2,
            test.answer3,
            test.answer4,
        ]
        currCorrectAnswer = test.correctAnswer
        
        navigationItem.title = "\(currTestNumber! + 1) / \(tests.count)"
        tableView.reloadData()
    }
    
    // MARK: Подведение итогов теста
    private func summarizingTest() {
        let isWin = (countCorrectAnswers == tests.count)
        
        DispatchQueue.main.async {
            self.startActivityIndicator()
        }
        
        if isWin {
            MaterialHelper.addMaterialToApiAndLocal(withMaterilaId: materialId) { isDone in
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    
                    let vc = SummarizingTestViewController(isWin: isWin, isUpload: isDone)
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
                    
                    // переносимся на начальный экран
                    self.navigationController?.popToRootViewController(animated: false)
                }
            }
        } else {
            stopActivityIndicator()
            
            let vc = SummarizingTestViewController(isWin: isWin, isUpload: false)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            // переносимся на начальный экран
            self.navigationController?.popToRootViewController(animated: false)
        }
    }

}


// MARK: - Table view data source
extension TestViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifier) as! CustomHeader
        
        view.title = sections[section]
        view.backgroundView?.backgroundColor = Colors.backgroupd
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // один вопрос
        if section == 0 { return 1 }
        // 4 ответа
        else { return 4 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelCell = tableView.dequeueReusableCell(withIdentifier: LabelViewCell.reuseIdentifier, for: indexPath) as! LabelViewCell
        
        if indexPath.section == 0 {
            // для вопроса
        labelCell.textInConteiner = currQuestion
            labelCell.textInConteinerLabel.textColor = .white
            labelCell.conteinerView.backgroundColor = Colors.transneftBlue
            labelCell.isUserInteractionEnabled = false
        } else if indexPath.section == 1 {
            // для ответов
            labelCell.textInConteiner = currAnswers[indexPath.row]
            labelCell.textInConteinerLabel.textColor = .black
            labelCell.conteinerView.backgroundColor = .white
            labelCell.textInConteinerLabel.font = UIFont(name: "System", size: 18)
        }
        
        return labelCell
    }
    
}


// MARK: - Table view delegate
extension TestViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // только для ответов
        guard indexPath.section == 1 else { return }
        
        // + 1 потому что нумерация правильного ответа с 1
        if currCorrectAnswer == indexPath.row + 1 {
            countCorrectAnswers += 1
        }
        
        // если вопросы кончились - подводим итоги
        if currTestNumber + 1 == tests.count {
            summarizingTest()
            return
        }
        
        updateCurrTest()
    }
    
}

// MARK: - Animating Network View Controller
extension TestViewController: AnimatingNetworkViewController {
    
    func animatingSuperViewForDisplay() -> UIView {
        return view
    }
    
    func animatingViewForDisableUserInteraction() -> UIView {
        if let tabBarController = tabBarController {
            return tabBarController.view
        } else if let navController = navigationController {
            return navController.view
        } else {
            return view
        }
    }
    
    func animatingActivityIndicatorView() -> ActivityIndicatorView {
        return activityIndicatorView
    }
    
    func animatingAlertView() -> AlertView {
        return alertView
    }
    
}

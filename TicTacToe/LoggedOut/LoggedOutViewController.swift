//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

// view가 interactor와 통신하기 위한 프로토콜
// view -> interactor 로의 통신
// 일반적으로 비즈니스 로직을 수행 하도록 값을 전달하는 메소드를 포함
protocol LoggedOutPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }

    // MARK: - Private

    private var player1Field: UITextField?
    private var player2Field: UITextField?

    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = UITextBorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }

        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = UITextBorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }

        return (player1Field, player2Field)
    }

    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player2Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }

    @objc private func didTapLoginButton() {
        self.listener?.login(withPlayer1Name: self.player1Field?.text, player2Name: self.player2Field?.text)
    }



}

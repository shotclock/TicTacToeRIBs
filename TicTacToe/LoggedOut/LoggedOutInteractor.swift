//
//  LoggedOutInteractor.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs
import RxSwift

// Router와 통신하기 위한 프로토콜
// interactor -> router 로의 통신
protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

// preseneter (view)
// interactor -> view 로의 통신
protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

// 인접한 다른 rib과 통신할 수 있도록 하는 프로토콜
// 이 프로토콜을 준수함으로써 다른 립과 통신이 가능해진다.
// 부모립인 root가 이 리스너를 담당한다.
protocol LoggedOutListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didLogin(withPlayer1Name player1Name: String, player2Name: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutPresentableListener

    func login(withPlayer1Name player1Name: String?, player2Name: String?) {
        let player1NameWithDefault = playerName(player1Name, withDefaultName: "Player 1")
        let player2NameWithDefault = playerName(player2Name, withDefaultName: "Player 2")

        listener?.didLogin(withPlayer1Name: player1NameWithDefault, player2Name: player2NameWithDefault)
    }

    private func playerName(_ name: String?, withDefaultName defaultName: String) -> String {
        if let name = name {
            return name.isEmpty ? defaultName : name
        } else {
            return defaultName
        }
    }
}

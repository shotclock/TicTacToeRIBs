//
//  LoggedOutRouter.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

//interactor와 통신하기 위한 프로토콜
//router -> interactor로 통신
protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

//View(controller)와 통신하기 위한 프로토콜
//router -> presenter와 통신
//뷰 계층을 수정하는 메소드들이 포함
protocol LoggedOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

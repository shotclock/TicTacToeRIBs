//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

// offgame의 리스너가 되기 위해 해당 프로토콜 추가
protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}


final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    // 자식 RIB인 OffGame RIB을 붙일 수 있도록 해당 buildable 프로토콜을 추가한다.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         ticTacToeBuilder: TicTacToeBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
        // 뷰가 없는 RIB에서 존재하는 메소드
        // 해당 립이 deattach 될 때 뷰를 지우기 위함.
        
        if let currentChild = self.currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable
    //라우팅 할 수 있는 객체
    private var currentChild: ViewableRouting?
    
    //라우터 로딩이 완료되었을때 호출
    override func didLoad() {
        attatchOffGame()
    }
    
    private func attatchOffGame(){
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
        
    }
    
    fileprivate func detachCurrentChild() {
        if let currentChild = self.currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
            self.currentChild = nil
        }
    }
    
    func routeToTicTacToe() {
        detachCurrentChild()
        
        let ticTacToeGame = ticTacToeBuilder.build(withListener: interactor)
        self.currentChild = ticTacToeGame
        attachChild(ticTacToeGame)
        viewController.present(viewController: ticTacToeGame.viewControllable)
    }
    
    func routeToOffGame() {
        detachCurrentChild()
        attatchOffGame()
    }
}

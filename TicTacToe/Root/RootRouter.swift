//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    
    // LoggedIn RIB을 붙이기 위해 LoggedInBuildable을 추가한다.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }

    // MARK: - Private

    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder : LoggedInBuildable
    private var loggedOut: ViewableRouting?
    
    
    // MARK: - RootRouting
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        // Detach LoggedOut RIB
        if let loggedOut = self.loggedOut {
            // 자식 립이 뷰 컨트롤러를 가지고 있는 경우, 부모 립은 그 뷰 컨트롤러를 보여주거나 제거해야 한다.
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        //부모 립의 interactor가 자식 립의 리스너가 된다.
        //RootInteractable에 새로이 생성된 rib의 listener 프로토콜을 준수하게 함으로 에러가 안나도록 할 수 있다.
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
    }
}

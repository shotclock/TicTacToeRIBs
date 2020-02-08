//
//  RootComponent+LoggedIn.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedIn scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoggedIn: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedIn scope.
}

extension RootComponent: LoggedInDependency {
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
    

    // TODO: Implement properties to provide for LoggedIn scope.
}

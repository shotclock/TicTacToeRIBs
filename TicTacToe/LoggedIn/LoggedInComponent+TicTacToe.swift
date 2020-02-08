//
//  LoggedInComponent+TicTacToe.swift
//  TicTacToe
//
//  Created by 이상호 on 2020/02/08.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the TicTacToe scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyTicTacToe: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the TicTacToe scope.
}

extension LoggedInComponent: TicTacToeDependency {

    // TODO: Implement properties to provide for TicTacToe scope.
}

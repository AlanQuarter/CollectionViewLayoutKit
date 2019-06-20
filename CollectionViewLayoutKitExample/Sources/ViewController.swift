//
// Created by Alan on 2019-06-19.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


final class ViewController: UIViewController {

    private let menuCellIdentifier = "menuCell"


    private weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "CollectionViewLayoutKit"

        self.tableView = {
            let view = UITableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.register(UITableViewCell.self, forCellReuseIdentifier: self.menuCellIdentifier)
            view.dataSource = self
            view.delegate = self

            self.view.addSubview(view)

            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            ])

            return view
        }()
    }

}


extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.allCases.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.menuCellIdentifier, for: indexPath)
        cell.textLabel?.text = Menu.allCases[indexPath.row].description

        return cell
    }

}


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(Menu.allCases[indexPath.row].viewController, animated: true)
    }

}


extension ViewController {

    enum Menu: String, CaseIterable, CustomStringConvertible {

        case waterfall = "Waterfall Layout"


        static let allCases: [Menu] = [.waterfall]


        var description: String {
            return self.rawValue
        }

        var viewController: UIViewController {
            let viewController: UIViewController

            switch self {
            case .waterfall:
                viewController = WaterfallViewController()
            }

            viewController.navigationItem.title = self.description
            return viewController
        }

    }

}

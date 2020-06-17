//
//  CustomSearchTextField.swift
//  IRWeather Forecast
//
//  Created by Rajshekhar on 17/06/20.
//  Copyright © 2020 Rajshekhar. All rights reserved.
//

import UIKit

class CustomSearchTextField: UITextField {

    var searchTableView: UITableView?
    var results: [CityModel] = []
    private var pendingRequestWorkItem: DispatchWorkItem?

    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        searchTableView?.removeFromSuperview()
    }

    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
    }

    //////////////////////////////////////////////////////////////////////////////
    // Text Field related methods
    //////////////////////////////////////////////////////////////////////////////

    @objc open func textFieldDidChange() {
        updateSearchTableView()
        searchTableView?.isHidden = false
        filter()
    }

    @objc open func textFieldDidBeginEditing() {
        print("Begin Editing")
    }

    @objc open func textFieldDidEndEditing() {
        print("End editing")

    }

    @objc open func textFieldDidEndEditingOnExit() {
        print("End on Exit")
    }

    // MARK: Filtering methods
    fileprivate func filter() {
        self.results.removeAll(keepingCapacity: true)
        let text = self.text!
        if text.count > 3 {
            let filterArray = cityModelArray.filter { $0.name.range(of: text, options: [ .caseInsensitive, .anchored ]) != nil }
            self.results.append(contentsOf: filterArray)

        }
        self.searchTableView?.reloadData()
    }
}

extension CustomSearchTextField: UITableViewDelegate, UITableViewDataSource {

    // MARK: TableView creation and updating
    // Create SearchTableview
    func buildSearchTableView() {

        if let tableView = searchTableView {
            tableView.register(CustomSearchTableViewCell.nib, forCellReuseIdentifier: CustomSearchTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)

        } else {
            searchTableView = UITableView(frame: CGRect.zero, style: .plain)
        }
        updateSearchTableView()
    }

    // Updating SearchtableView
    func updateSearchTableView() {
        if let tableView = searchTableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height

            // Set a bottom margin of 10p

            if tableView.contentSize.height > 200 {
                tableHeight = 200
            } else {
                if tableHeight < tableView.contentSize.height {
                    tableHeight -= 10
                }
            }
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.searchTableView?.frame = tableViewFrame
            })

            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor(red: 155/255, green: 232/255, blue: 255/255, alpha: 0.3)

            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
        }
    }

    // MARK: TableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    // MARK: TableViewDelegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchTableViewCell", for: indexPath) as? CustomSearchTableViewCell else {
            fatalError("Error in dequeing cell")
        }
        cell.backgroundColor = UIColor.clear
        cell.cityLbl?.text = results[indexPath.row].name
        cell.countryLbl.text = results[indexPath.row].country
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        self.endEditing(true)
    }
}

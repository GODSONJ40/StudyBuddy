//
//  SettingsViewController.swift
//  StudyBuddy
//
//  Created by Godson JEAN on 11/07/25.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var savedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        usernameTextField.text = Persistence.shared.loadUsername()
        savedLabel.isHidden = true
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        guard let text = usernameTextField.text, !text.isEmpty else {
            savedLabel.text = "Enter a username"
            savedLabel.isHidden = false
            return
        }
        Persistence.shared.saveUsername(text)
        savedLabel.text = "Saved!"
        savedLabel.isHidden = false
        // hide after 1.2s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.savedLabel.isHidden = true
        }
    }
}

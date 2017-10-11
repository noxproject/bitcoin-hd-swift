//
//  MasterViewController.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/14.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import CKMnemonic

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var objects = [Any]()


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = editButtonItem

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
		navigationItem.rightBarButtonItem = addButton
		if let split = splitViewController {
		    let controllers = split.viewControllers
		    detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		testKeys()
	}

	override func viewWillAppear(_ animated: Bool) {
		clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@objc func insertNewObject(_ sender: Any) {
		objects.insert(NSDate(), at: 0)
		let indexPath = IndexPath(row: 0, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
	}
	
	// MARK: - Key test
	func testKeys() {
//		let mnemonic = "弓 帽 次 剂 测 妈 凭 吏 涨 火 搞 装"
//		print(mnemonic)
//		let seed = "000102030405060708090a0b0c0d0e0f"
//		print(seed)
//		do {
//			let keychain = try Keychain(seedString: seed)
//			print(keychain.extendedPrivateKey)
//			print(keychain.extendedPublicKey)
//			
//			let childKeychain = try keychain.bitcoinMainnetKeychain()
//			print(childKeychain.extendedPrivateKey)
//			print(childKeychain.extendedPublicKey)
//			
//		} catch {
//			print(error)
//		}
//		do {
//			let language: CKMnemonicLanguageType = .chinese
//			let mnemonic = try CKMnemonic.generateMnemonic(strength: 128, language: language)
//			print(mnemonic)
//			let seed = try CKMnemonic.deterministicSeedString(from: mnemonic, passphrase: "Test", language: language)
//			print(seed)
//		} catch {
//			print(error)
//		}
	}

	// MARK: - Segues

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = tableView.indexPathForSelectedRow {
		        let object = objects[indexPath.row] as! NSDate
		        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
		        controller.detailItem = object
		        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return objects.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let object = objects[indexPath.row] as! NSDate
		cell.textLabel!.text = object.description
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
		    objects.remove(at: indexPath.row)
		    tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
		    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}


}


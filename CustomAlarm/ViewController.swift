//
//  ViewController.swift
//  CustomAlarm
//
//  Created by Daniel Yo on 9/6/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications
import IGListKit
import FirebaseFirestore

class ViewController: UIViewController {

    var player : AVAudioPlayer?
    var timer: Timer!
    var isAdmin:Bool = false
    var username:String?
    var password:String?
    var objects:Array = [ListDiffable]()
    var ref: DocumentReference? = nil

    lazy private var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    private var buttonLogout:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: UIControlState.normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonLogout_touchUpInside), for: .touchUpInside)
        return button
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.alwaysBounceVertical = true
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        if (self.username?.lowercased() == "admin") {
            self.isAdmin = true
            self.getDataForAdmin()
        } else {
            self.isAdmin = false
            self.getDataForUser()
        }
        
        // To hide this warning and ensure your app does not break, you need to add the following code to your app before calling any other Cloud Firestore methods:
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        ////////
        
        db.collection("fights").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setup() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.label)
        self.label.text = self.username
        self.label.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        })
        
        self.view.addSubview(self.buttonLogout)
        self.buttonLogout.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        })
        
        //collectionView
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.label.snp.bottom).offset(40)
            make.left.right.bottom.equalToSuperview()
        })
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
    }
    
    private func getDataForAdmin() {
        self.objects.append(FightAlarm.init(withName: "KSI VS Paul", date: "TODAY"))
        self.objects.append(FightAlarm.init(withName: "McGregor VS Mum", date: "12/25/2019"))
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    private func getDataForUser() {
        
        self.objects.append(FightAlarm.init(withName: "KSI VS Paul", date: "TODAY"))
        self.objects.append(FightAlarm.init(withName: "McGregor VS Mum", date: "12/25/2019"))

        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.init(named: "sound.mp3")
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    @objc func playSound() {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func buttonLogout_touchUpInside(sender:UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController:ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if (self.isAdmin) {
            let sectionController:LabelDateButtonSectionController = LabelDateButtonSectionController()
            sectionController.delegate = self
            
            return sectionController
        } else {
            let sectionController:LabelDateImageSectionController = LabelDateImageSectionController()
            sectionController.delegate = self
            
            return sectionController
        }

    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

extension ViewController:LabelDateButtonSectionControllerDelegate {

    func labelDateButtonSectionButtonPressed(button:UIButton) {
        print("\n\nButtonTapped")
        // send remote notification
    }
}

extension ViewController:LabelDateImageSectionControllerDelegate {
    
    func didSelectItem(item: FightAlarm) {
        
        // To hide this warning and ensure your app does not break, you need to add the following code to your app before calling any other Cloud Firestore methods:
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        if (item.isSubscribed) {
            let fightRef = db.collection("fights").document(item.title!)
            var updatedIDs:Array = [String]()
            // TODO: DANIEL
            // get a copy of the current registeredDeviceIDs
            fightRef.getDocument { (document, error) in
                if let fight = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Fight(dictionary: data)
                    })
                }) {
                    print("City: \(fight)")
                } else {
                    print("Document does not exist")
                }
            }
            
            
            // update registeredDeviceIDs
            fightRef.updateData([
                "registeredDeviceIDs": updatedIDs
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }

        item.isSubscribed = !item.isSubscribed
        for (index, element) in self.objects.enumerated() {
            let fightAlarm:FightAlarm = element as! FightAlarm
            
            if (item.title == fightAlarm.title) {
                self.objects[index] = item
            }
        }

        self.adapter.reloadData(completion: nil)
        
    }
}

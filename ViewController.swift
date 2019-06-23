//
//  ViewController.swift
//  IntruderAlert
//
//  Created by Leow Yenn Han on 14/08/2018.
//  Copyright © 2018 Leow Yenn Han. All rights reserved.
//

import UIKit
import AWSS3
import AWSCore


class ViewController: UIViewController  {

    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }*/
    
    let s3bucket = "final-year-project-1"
    let photokey = "plate.png"

    @IBOutlet weak var imageViewPicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let downloadedFile = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.jpg")
        let transferManager = AWSS3TransferManager.default()
        if let downloadRequest = AWSS3TransferManagerDownloadRequest(){
            
            downloadRequest.bucket = s3bucket
            downloadRequest.key = photokey
            downloadRequest.downloadingFileURL = downloadedFile
            
            transferManager.download(downloadRequest).continueWith {
                (task: AWSTask<AnyObject>)-> Any? in
                if let error = task.error{
                    print(error)
                }else{
                    if let data = NSData(contentsOf: downloadedFile){
                        print(data)
                        DispatchQueue.main.async(execute: {
                            self.imageViewPicture.image = UIImage(data: data as Data)
                        })
                    }
                }
                return nil
            }
        }
    }


}


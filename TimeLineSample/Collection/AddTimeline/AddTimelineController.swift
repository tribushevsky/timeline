//
//  AddTimelineController.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/31/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddTimelineController : UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var viewModel: AddTimelineViewModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    class func create(viewModel: AddTimelineViewModel) -> AddTimelineController {
        let controller = AddTimelineController(nibName: "AddTimelineController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
    
    private func setupBinding() {
        let saveNewTimeline : Driver<TimelineViewModel> =
            saveButton
            .rx.tap.asDriver()
            .withLatestFrom(inputTextView.rx.text.asDriver())
            .map { (text) -> TimelineViewModel in
                return TimelineViewModel(text: text ?? "", media: [UIImage(named: "7")!])
        }
        
        let input = AddTimelineViewModel.Input(saveTrigger: saveNewTimeline,
                                               closeTrigger: closeButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        output.support.drive().disposed(by: disposeBag)
    }
}

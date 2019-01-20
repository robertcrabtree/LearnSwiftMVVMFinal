
import RealmSwift
import UIKit

// Coordinators have a single method... start()

protocol Coordinator {
    func start()
}

class CallCoordinator: Coordinator {
    
    let contactUUID: String
    let presentingViewController: UIViewController
    
    var didClose: (() -> Void)?
    
    // Initialize with a view controller to present on
    
    init(contactUUID: String, presentingViewController: UIViewController) {
        self.contactUUID = contactUUID
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        
        // Load view controller
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let callController = storyboard.instantiateViewController(
            withIdentifier: "CallViewController") as! CallViewController
        
        // Connect view model to view controller
        
        callController.viewModel = CallViewModel(contactUUID: contactUUID)
        
        // Callback is necessary so we can dismiss the view controller
        
        callController.didFinish = { [weak self] in
            
            // Dismiss view controller
            
            self?.presentingViewController
                .dismiss(animated: true, completion: nil)
            
            // Let caller know that it's finished so it can release memory
            
            self?.didClose?()
        }
        
        // Present view controller
        
        presentingViewController.present(
            callController,
            animated: true,
            completion: nil
        )
    }
}

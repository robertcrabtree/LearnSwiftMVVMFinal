
import UIKit

class SomeViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var viewModel: SomeViewModel!

    private var firstNameBinding: UITextFieldBinding!
    private var lastNameBinding: UITextFieldBinding!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameBinding = UITextFieldBinding()
            .bind(firstNameTextField)
            .to(viewModel.firstName)
        lastNameBinding = UITextFieldBinding()
            .bind(lastNameTextField)
            .to(viewModel.lastName)
        
        // ...
    }
    
    // ...
}

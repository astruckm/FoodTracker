
import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var recipe: String?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let starSizeDimension = self.contentView.bounds.width / 12.0
        ratingControl.starSize.width = starSizeDimension
        ratingControl.starSize.height = starSizeDimension
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

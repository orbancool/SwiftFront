import Foundation

class News {
    
    var avatarNews: String
    var titleNews: String
    var timeNews: String
    var messageNews: String
    
    internal init(avatarNews: String, titleNews: String, timeNews: String, messageNews: String) {
        self.avatarNews = avatarNews
        self.titleNews = titleNews
        self.timeNews = timeNews
        self.messageNews = messageNews
    }

}

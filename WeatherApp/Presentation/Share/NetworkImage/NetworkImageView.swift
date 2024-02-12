import SwiftUI
import Combine

struct NetworkImageView<Placeholder: View, ProgressBlock: View>: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel: ImageViewModel
    
    let placeholder: Placeholder
    let progressBlock: ProgressBlock
    
    init(
        imageUrlString: String,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder progressBlock: () -> ProgressBlock
    ) {
        
        _viewModel = .init(wrappedValue: ImageViewModel(imageUrlString: imageUrlString))
        self.placeholder = placeholder()
        self.progressBlock = progressBlock()
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                progressBlock
            case .error:
                placeholder
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}

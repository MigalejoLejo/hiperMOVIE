import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
    
    private var name: String
    private var loopMode: LottieLoopMode = .loop
    

    init(name: String, loopMode: LottieLoopMode = .loop) {
        self.name = name
        self.loopMode = loopMode
    }
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: name, bundle: Bundle.main)
        animationView.contentMode = .scaleAspectFit

        animationView.loopMode = loopMode
        animationView.play()
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(animationView)
               
               NSLayoutConstraint.activate([
                   animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                   animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
               ])
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "Loading.json")
    }
}

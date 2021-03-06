import Combine
import ComposableArchitecture
import SwiftUI

public struct SplashView: View {
  private let store: Store<SplashState, SplashAction>
  private let statelessViewStore: ViewStore<Void, SplashAction>
  
  public init(store: Store<SplashState, SplashAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        Color.black.ignoresSafeArea()
        Text("Splash")
      }
    }
    .onAppear(perform: checkVersion)
  }
  
  private func checkVersion() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      statelessViewStore.send(.checkVersion)
    }
  }
}

#if DEBUG
struct Splash_Previews: PreviewProvider {
  static var previews: some View {
    SplashView(
      store: Store(
        initialState: SplashState(),
        reducer: splashReducer,
        environment: SplashEnvironment(mainQueue: .main)
      )
    )
  }
}
#endif

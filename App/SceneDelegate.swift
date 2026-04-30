import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }

    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        // Home
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        homeVC.tabBarItem.accessibilityIdentifier = "tab_home"

        // My Cats
        let catsVC = UINavigationController(rootViewController: CatsViewController())
        catsVC.tabBarItem = UITabBarItem(title: "Cats", image: UIImage(systemName: "cat.fill"), tag: 1)
        catsVC.tabBarItem.accessibilityIdentifier = "tab_cats"

        // Tasks
        let tasksVC = UINavigationController(rootViewController: TasksViewController())
        tasksVC.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "checkmark.circle.fill"), tag: 2)
        tasksVC.tabBarItem.accessibilityIdentifier = "tab_tasks"

        // Learn
        let learnVC = UINavigationController(rootViewController: LearnViewController())
        learnVC.tabBarItem = UITabBarItem(title: "Learn", image: UIImage(systemName: "book.fill"), tag: 3)
        learnVC.tabBarItem.accessibilityIdentifier = "tab_learn"

        // Profile
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
        profileVC.tabBarItem.accessibilityIdentifier = "tab_profile"

        tabBarController.viewControllers = [homeVC, catsVC, tasksVC, learnVC, profileVC]
        tabBarController.selectedIndex = 0

        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
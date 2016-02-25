---
layout: post 
title: Swift Coordinators
date: 2016-02-23 15:30:58 
author: Skye Freeman 
categories: Programming
---

This past week I came across an interesting blog post by Soroush Khanlou introducing the idea of using Coordinators when building iOS apps.  I decided to take a crack at the concept by building out a small login/sign up workflow using coordinators to drive my app logic, in short, the experience was a revelation.

To give a little back story, here's the idea behind coordinators:

Coordinators drive the navigation and business facing logic of your app. They handle navigation between view controllers, and respond to input from those view controllers.  This sounds simple enough, but isn't this just moving code from one file to another?

Essentially, yes.  But the benefits of doing this aren't immediately obvious.  Traditionally, view controllers have been the least reuseable parts of our apps.  In theory, a view controller should have one job, controlling the view.  In practice though, they tend to absorb functionality far beyond their scope. A few examples of what are 'beyond scope' are: model manipulation, navigation, triggering a web request etc... The iOS community has collectively come up with some great ways of decoupling view controllers in an attempt to combat 'Massive View Controller' syndrome.  But in my opinion, they are still doing too much.  What if View Controllers were just dumb objects like their Model and View comrads?

**Enter the Coordinator.**

A Coordinator strips the View Controller of it's priveledges, allowing the View Controller to only lay out their subviews, and let the Coordinator know about user input. By adding a protocol to the View Controller, we can also be explicit about the interactions our Coordinator needs to respond to. Put simply, the Coordinator bosses around the View Controller.

Let's walk through some examples.  Here's what an AppDelegate might look like when using a Coordinator:

{% highlight swift %}
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var appCoordinator: AppCoordinator = {
       return AppCoordinator(window: self.window!)
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        appCoordinator.start()
        return true
    }
}
{% endhighlight %}

Here we immediately pass off the responsibility of starting our app to the AppCoordinator.  The AppCoordinator is the top most Coordinator that is in charge of initializing and directing to child Coordinators. After first initializing our UIWindow object, we then lazily initialize our AppCoordinator passing the window. Next we call start() to signify the coordinator to start making decisions.  Here's what the AppCoordinator might look like:

{% highlight swift %}
class AppCoordinator: LoginCoordinatorDelegate,HomeCoordinatorDelegate {
    let window: UIWindow
    let rootViewController: UINavigationController
    let childCoordinators: NSMutableArray
    
    init(window: UIWindow) {
        self.childCoordinators = NSMutableArray()
        self.rootViewController = UINavigationController()
        
        self.window = window
        self.window.backgroundColor = UIColor.whiteColor()
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: self.rootViewController)
        self.childCoordinators.addObject(loginCoordinator)
        
        loginCoordinator.start()
    }
}
{% endhighlight %}

Nothing crazy. We hold a reference to the UIWindow just in case we want to manipulate it, then initialize and set a root view controller.  It may seem odd to do UIWindow's work here instead of the AppDelegate, and is totally optional.  I felt that trimming down the AppDelegate one step futher to be a big win.

The start method is where things get really interesting.  First the AppCoordinator initializes the LoginCoordinator while passing along the root view controller.  Next, the LoginCoordinator is added to a mutable array called childCoordinators. This part is necessary so the currently active Coordinator's don't get deallocated.  Lastly the start() method is called on loginCoordinator, beginning the cycle again.  Now the LoginCoordinator takes over control in setting up the first View Controller in our app.

{% highlight swift %}
class LoginCoordinator: LoginViewControllerDelegate {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        self.navigationController.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    // MARK: LoginViewControllerDelegate
    func loginButtonPressed(username: String, password: String) {
        if (username.characters.count == 0) { return }
        if (password.characters.count == 0) { return }

	print("Login pressed")
    }
    
    func signUpButtonPressed() {
        print("Sign up pressed")
    }
}
{% endhighlight %}

Here is where all the magic happends. In init() we store a reference to the root view controller which in this case is the navigation controller we defined in the AppCoordinator. Next in start() we initialize and push the loginViewController onto the stack, setting its delegate along the way.  Now all we do is wait until the user presses the Log in or Sign Up buttons defined in our LoginViewController, then respond to those messages as needed. By creating a protocol for our LoginViewController, we can easily pass along the relavent data the Coordinator needs to perform its tasks.  We can see that in action from this method:

{% highlight swift %}
func loginButtonPressed(username: String, password: String) {
     // Do login stuff
}
{% endhighlight %}

In a production app, the Coordinator would then presumably perform the necessary requests needed to login a user, then make the decision on the next step for the app.  For example, a logical next step would be to signal the AppCoordinator that the login process has finished, remove the LoginCoordinator from the coordinator stack, then instantiate a new coordinator and start the process all over again.

The biggest win we get from using Coordinators in my opinion is that we strip View Controller's of the ability to navigate and make decisions.  Before, it was common for View Controller's to be aware of their location on the navigation stack. Now, we totally strip down a View Controller's responsibility to the minimum, while also turning them into reuseable components.  By pushing the app's logic up one level into a Coordinator our code can be far more expressive, clean, and minimal.

It may be too soon to call it a best practice, but I can already see myself using Coordinater's extensively in my future projects. At the least, it's another powerful tool in the toolchain.
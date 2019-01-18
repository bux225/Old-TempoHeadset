### Step 1: Creating a new project

1. Open Xcode and create a new project. 
2. Select Single View Application as the template. 
3. Select Swift as the language for the app code. 

### Step 2: Adding the OpenTok library

Follow the steps below to use CocoaPods to add the OpenTok library and its dependencies to your app. If you would prefer not to use CocoaPods, follow [these instructions for using the SDK](https://tokbox.com/developer/sdks/ios/#using-the-sdk).

1. In the Terminal, navigate to the root directory of your project and enter:  
    `pod init`
    This creates a Podfile at the root of your project directory. 
2. Edit the Podfile and add the following line after the comment that says `# Pods for [YourProjectName]` (The podfile will not be visible in your XCode project, so you will need to open it from the project folder directly):   
    `pod OpenTok`
3. Save changes to the Podfile. 
4. Open your project's root directory in the Terminal and type:   
    `pod install`
5. Close your project in Xcode. Then reopen your project by double-clicking the new .xcworkspace file in the Finder (in the root directory of your project). 

For camera and microphone access you need to modify the Info.plist file:

1. In the lefthand navigator panel in Xcode, click the project file (with the name of your project) to open the center project panel. To the left of the General tab in the project panel, you should see your project name. If the name is something different from your project (such as [YourProjectName]Tests), click on it and set the target to your project name. 
2. Inside the panel, switch to the Info tab. 
3. Expand the Custom iOS Target Properties section if it’s collapsed 
4. Mouse over any key and click the + button to add a new key. Add a  `Privacy - Microphone Usage Description` key and assign it the following string:   
    `$(PRODUCT_NAME) uses the microphone.`
    The app displays these strings when the application first accesses the camera and microphone. (These security features were added in iOS 10.) 

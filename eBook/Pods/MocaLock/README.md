# MocaLock

![](images/mocalock_01.png)

This is a library for displaying password lock screen. It also supports biometrics (Face ID, TouchID).

- Prompt for entering and re-entering password with RegisterType. 

- Prompt for password input or biometric authentication with UnlockType.
  You can customize the design if you wish.

## Installation

- CocoaPods

  ```:Podfile
  pod 'MocaLock'
  ```

  

## Usage

Just create an instance of MocaLockViewController and perform screen transition to display the password lock screen.



Specify MocaLockType.register to display the password registration screen.

```Swift:ViewController.swift
let vc = MocaLockViewController.init(mocaLockType: .register)
vc.registerDelegate = self
self.present(vc, animated: true, completion: nil)
```

Receive events on MocaLockUnlockDelegate.



Specify MocaLockType.unlock to display the password entry screen.

```Swift:ViewController.swift
let vc = MocaLockViewController.init(mocaLockType: .unlock)
vc.unlockDelegate = self
vc.unlockPassword = "1234"
self.present(vc, animated: true, completion: nil)
```

Receive events on MocaLockUnlockDelegate.



To change the wording in MocaLockViewController, add MocaLockLocalized.strings to the project and describe the following items.

```strings:MocaLockLocalized.strings
// word
"delete" = "Delete";
"back" = "Back";
"faceId" = "Face ID";
"touchId" = "Touch ID";

// message
"enterRegisterPasswordMsg" = "Please enter a password to register.";
"enterUnlockPasswordMsg" = "Please enter your password.";
"enterPasswordAgainMsg" = "Please enter password again.";
"passwordNotMatchMsg" = "Passwords do not match.";
"passwordIncorrectMsg" = "Password is incorrect.";
"authFailedMsg" = "Authentication failed.";

"passwordLockReason" = "App unlock.";
```



If you want more customization, add MocaLockView to your ViewController and set MocaLockViewDataSource and MocaLockViewDelegate to MocaLockView.

MocaLockViewDataSource is responsible for generating UI components.
MocaLockViewDelegate is responsible for action callback on MocaLockView

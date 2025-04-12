# bypass-paddle
simple script to temporarily bypass apps with the Paddle framework by injecting a fake dylib that hides the paddle licensing window.
the code for the dylib is stored in fake_paddle.m and precompiled for your convenience into libPaddleOverride.dylib

The two shell scripts check that the application contains Paddle and if so injects the dylib. "All Apps" iterates through everything in /Applications where as "Only One App" takes the application folder (AppName.app) as input in the CLI (example below).
```
"Inject fake paddle into Only One App.sh" "/Applications/YourApp.app"
```

I am not responsible for how you use this framework. This is meant to be used for testing apps that you are developing that rely on the paddle payment system. **Using this on paid apps you don't own is piracy and is against the law!**

# Flutter examples
This repo containts some little flutter app examples about different topics.

## How to run

### All examples
Clone the repo:
```bash
git clone https://github.com/oscarnar/flutter_examples.git
```
Run any example:
```sh
cd flutter_examples
cd example_app
flutter pub get
flutter run
```

### A specific example
In Arch Linux, you can clone the specific example using [subversion](https://archlinux.org/packages/extra/x86_64/subversion/) package:

If the path of the example is:
https://github.com/oscarnar/flutter_examples/tree/main/little_app

Then, you need change 'tree/main' to 'trunk', so after that you can run it using:

```bash
svn checkout https://github.com/oscarnar/flutter_examples/trunk/little_app
```
Run the example:
```sh
cd little_app
flutter pub get
flutter run
```

# Enigma

A new Flutter project developed by Pocketdevs.

## **Developers:**
 - Chiekko Red
 - Thomas Rey

# Architecture

**`MVVM + Provider` - Model View View Models + Provider**

# Getting Started

## Create new directory

Directory folders are already arranged based on its purpose. So make sure to follow and insert your new directory or files on its designated path.

```
lib
 └── core
      └── models
      └── providers
      └── viewmodels
 └── utilities
      └── configs
      └── constants
 └── views
      └── commons
      └── screens
```

## Create new files inside a directory

`<filename>_<classtype>.dart`

_example:_
```
sample_model.dart
```
When naming a file, all characters must be in lowercase and separate filename and classtype with an <span style="color:red;">underscore (_) </span>. File naming must be in <span style="color:red;"> snake case </span> and to be strictly followed to avoid future conflicts.

## Naming a class
`class <Classname><Classtype> {}`

_example:_
```
class SampleModel {}
```
In naming a class, both class name and class type must be present. We will use <span style="color:red;"> pascal case </span> to delineate the class name.

## Naming a function
`<return callback> <function name>() {}`

_example:_
```
void sampleFunction() {}
```

Naming a function needs to be in <span style="color:red;"> camel case </span> to be easily used inside a class.

## Naming a variable
`<datatype> <variablename>`

_example:_

```
String testSample;
String _privateTestSample
```

Variable naming must strictly use <span style="color:red;"> camel case </span>. If a variable is private, add an underscore before the name to identify its independency.

## Quoting a String

We will use <span style="color:red;">one quote</span> in defining a String value;

_example:_
```
String sample = 'This is a string';
```

## Comments

Functions must be created with comments.

_example:_
```
/// A sample function
///
/// @param: text <Description>
/// @param: image <Description>
void SampleFunction (String text, String image) {}
```

If a code block needs to be explained, consider using // in commenting a short and precised explanation above the code.

_example:_
```
// Get date and time now for timestamp
DateTime now = new DateTime.now();
```
Reference Dart comments here: [Dart Comment Guides](https://dart.dev/guides/language/effective-dart/documentation)

# Directories

## `lib/core`
Core files that completes the **MVVM Architecture**.

## `lib/core/models`
Data model class are created here.

## `lib/core/providers`
Provider class with ChangeNotifiers are created here.

## `lib/core/viewmodels`
View Model class are created here.

## `lib/utilities`
Utilities such as app configurations for backend and app constants like colors, fonts and icons.

## `lib/utilities/configs`
App Configurations are gathered here for backend and API purposes.

## `lib/utilities/constants`
App constants like color scheme, theming, font styles and other constant values are gathered here.

## `lib/views`
Screens, pages and custom widgets are created here for UI.

## `lib/view/commons`
Reusable and custom widgets are created here.

## `lib/view/screens`
Pages and screen navigations are created here for rendering UI.
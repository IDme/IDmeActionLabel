# IDmeActionLabel
### Adds Target-Action Support for UILabel

---
### About
**IDmeActionLabel** is an extension of `UILabel` that adds the target-action design paradigm to the `UILabel` class. It is made to specifically work with labels that utilize an instance of`NSAttributedString`.

### Changelog (v1.0.0)
- Initial Release

### Current Features
- Support for adding multiple target-actions (via `NSInvocation`) to a `UILabel`
- Support for Labels that use `NSAttirubtedString`

### Future Features
- Change NSAttributedString properties on tap.

### Installation Instructions

```
pod 'IDmeActionLabel'
```

### Methods	
There are only two methods:

```obj-c
// Adds and NSInvocation to the UILabel for a given substring
- (void)addInvocation:(NSInvocation *)invocation forSubstring:(NSString *)substring;

// Removes an existing NSInvocation from the UILabel for a given substring
- (void)removeInvocationForSubstring:(NSString *)substring;
```

### Sample Project
A sample project has been provided to demo the capability of this app.

### Final Notes
This project was created to solve a very specific problem. Feel free to fork and abstract this project as needed. I'll make a conserted effort to examine and merge any pull-requests that come in.

### Created and maintained by
[Arthur Ariel Sabintsev](http://www.sabintsev.com/) 

# Smart Forms

The idea of this project is build forms using entitys.

In this case the project use Firestore like database from where is obtained the forms with the necessary parameters for the dynamic build.

You can find in the [main.dart](lib/main.dart) a simple request using Stream for the list of **smart_forms** obtained fomr the Firestore Collection.

The data of this documents is the next:

```json
{
    "name": "<Form Name>",
    "button": "<Label to show on submit button>",
    "fields": [
        {
            "label": "<Label to show>",
            "error_message": "<The error message to show in case is necessary>",
            "required": true || false,
            "type": "<Type of field from the options>"
        }
    ]
}
```

## Field Types

The first types added to the builder are:

- text
- multiline
- email
- number
- phone
- url

Inside the builder exist a regex validator for each field of type.

## Pieces

The logic between the builder is separated using the files:

### [smart_form.dart](lib/smart_form.dart)

Makes the decision of form and render all the files with the necessary EditingControllers.

### [custom_form_field.dart](lib/custom_form_field.dart)

This build only a field of the form with the requested feauture by type, the focus and more.

## Implementation

For implementation with Firebase you need to make the process for each platform:

- [Web](https://github.com/FirebaseExtended/flutterfire/blob/master/packages/cloud_firestore/cloud_firestore_web/README.md)
- [Android](https://firebase.google.com/docs/android/setup)
- [iOS](https://firebase.google.com/docs/ios/setup)

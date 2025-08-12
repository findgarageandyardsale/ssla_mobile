# Widgets Documentation

## DateInputField

A reusable date input field component built with `FormBuilderTextField` that provides consistent styling and validation for date inputs across the application.

### Features

- **Consistent Styling**: Maintains the same visual appearance across all date inputs
- **FormBuilder Integration**: Built on top of `FormBuilderTextField` for better form management
- **Customizable**: Supports custom colors, borders, padding, and validation
- **Accessibility**: Includes proper labels and hint text
- **Validation**: Built-in required field validation with customizable validators

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'widgets/date_input_field.dart';

class MyForm extends StatelessWidget {
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DateInputField(
      name: 'myDate',
      controller: _dateController,
      onTap: () {
        // Show date picker
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
      },
    );
  }
}
```

### Advanced Usage with Custom Styling

```dart
DateInputField(
  name: 'customDate',
  label: 'Select Date',
  hintText: 'Choose a date',
  controller: _dateController,
  onTap: _onDateTap,
  focusedBorderColor: Colors.purple,
  enabledBorderColor: Colors.purple[300],
  fillColor: Colors.purple[50],
  borderRadius: 12,
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  isRequired: true,
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `name` | `String` | **Required** | Form field name for FormBuilder |
| `label` | `String?` | `null` | Label text above the field |
| `hintText` | `String?` | `'dd/mm/yyyy'` | Placeholder text |
| `controller` | `TextEditingController?` | `null` | Text controller |
| `onTap` | `VoidCallback?` | `null` | Callback when field is tapped |
| `readOnly` | `bool` | `true` | Whether field is read-only |
| `validator` | `String? Function(String?)?` | `null` | Custom validation function |
| `isRequired` | `bool` | `false` | Whether field is required |
| `contentPadding` | `EdgeInsetsGeometry?` | `EdgeInsets.symmetric(horizontal: 12, vertical: 12)` | Internal padding |
| `borderRadius` | `double?` | `8` | Border radius |
| `borderColor` | `Color?` | `Colors.grey[300]` | Default border color |
| `focusedBorderColor` | `Color?` | `Colors.green` | Border color when focused |
| `enabledBorderColor` | `Color?` | `Colors.green[300]` | Border color when enabled |
| `fillColor` | `Color?` | `Colors.white` | Background fill color |
| `hintColor` | `Color?` | `Colors.grey[400]` | Hint text color |
| `iconColor` | `Color?` | `Colors.grey[600]` | Calendar icon color |
| `iconSize` | `double?` | `20` | Calendar icon size |

### Validation

The component includes built-in validation for required fields. You can also provide custom validation:

```dart
DateInputField(
  name: 'myDate',
  controller: _dateController,
  onTap: _onDateTap,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please select a date';
    }
    // Add custom validation logic
    return null;
  },
)
```

### Integration with FormBuilder

The `DateInputField` works seamlessly with `FormBuilder`:

```dart
FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      DateInputField(
        name: 'birthDate',
        controller: _birthDateController,
        onTap: _onBirthDateTap,
        isRequired: true,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formData = _formKey.currentState!.value;
            print('Form data: $formData');
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

### Migration from TextFormField

To migrate existing `TextFormField` date inputs to `DateInputField`:

**Before:**
```dart
TextFormField(
  controller: _dateController,
  readOnly: true,
  onTap: _onDateTap,
  decoration: InputDecoration(
    hintText: 'dd/mm/yyyy',
    // ... other decoration properties
  ),
)
```

**After:**
```dart
DateInputField(
  name: 'dateField',
  controller: _dateController,
  onTap: _onDateTap,
  // Customize colors if needed
  focusedBorderColor: Colors.blue,
  enabledBorderColor: Colors.blue[300],
)
```

### Examples

See `date_input_field_example.dart` for comprehensive usage examples including:
- Basic implementation
- Custom styling
- Validation
- Form integration
- Date picker integration

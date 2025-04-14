# DiagnosticOS

Welcome to the DiagnosticOS documentation page!

Everything you see here is currently incomplete and subject to change, as the kernel still needs to be properly implemented and tested.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

DiagnosticOS is a free, open-source Operating System meant to be flashed onto a USB to diagnose internal and external computer components.

## Installation

To install DiagnosticOS, follow these steps:

1. Head to the "releases" tab

2. Download the latest iso file (I.e, DiagnosticOS_v1.1.iso)

3. Use a tool such as rufus, balena etcher, or an ISO flashing tool to flash the ISO onto a desired medium (i.e, USB stick)

4. Restart the computer you want it on, head to the boot menu (i.e, by pressing F11), and select the drive with diagnosticOS on it.

NOTE: For step 4, boot menu keys vary by manufacturer, so check your motherboard manual or search online for what boot key your manufacturer uses.

## Custom installation
1. Clone the repository:
    ```sh
    git clone https://github.com/ArandomHitman/DiagnosticOS.git
    ```
2. Navigate to the project directory:
    ```sh
    cd DiagnosticOS
    ```
3. Install the dependencies:
    ```sh
    npm install
    ```

## Usage

To start using DiagnosticOS, run the following command:
```sh
npm start
```

## Contributing

We welcome contributions! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

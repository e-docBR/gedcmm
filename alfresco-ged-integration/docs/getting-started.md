# Getting Started with Alfresco GED Integration

Welcome to the Alfresco GED Integration project! This guide will help you get started with integrating your Alfresco instance with the GED (Gerenciamento Eletrônico de Documentos) system. Follow the steps below to set up and configure the integration.

## Prerequisites

Before you begin, ensure you have the following:

- A running instance of Alfresco Community Edition.
- Basic knowledge of Alfresco and its architecture.
- Access to the Alfresco repository and administrative privileges.

## Installation

1. **Clone the Repository**

   Start by cloning the Alfresco GED Integration repository to your local machine:

   ```
   git clone <repository-url>
   cd alfresco-ged-integration
   ```

2. **Install Dependencies**

   Navigate to the project directory and install the necessary dependencies. If you are using Node.js, run:

   ```
   npm install
   ```

3. **Configure Alfresco**

   Update the `alfresco-global.properties` file with your specific configurations. You can find an example configuration in the `config/alfresco-global.properties.example` file.

4. **Deploy the AMP Module**

   Use the provided scripts to build and deploy the AMP module to your Alfresco instance. Run the following command:

   ```
   python scripts/amp_builder.py
   ```

   After building, deploy the generated AMP file to your Alfresco installation.

## Usage

Once the integration is set up, you can start using the features provided by the Alfresco GED Integration. Here are some key functionalities:

- **Custom Document Types**: Create and manage custom document types using the provided templates.
- **Web Scripts**: Utilize the web scripts for various operations, such as retrieving and updating documents.
- **Workflows**: Implement custom workflows to automate document management processes.

## Examples

Refer to the `examples` directory for practical implementations of custom document types, advanced search, and workflows. These examples will help you understand how to leverage the integration effectively.

## Troubleshooting

If you encounter any issues during the installation or usage, check the `docs/troubleshooting.md` file for common problems and their solutions.

## Best Practices

For best practices on developing and maintaining your integration, refer to the `docs/best-practices.md` file.

## Contribution

We welcome contributions! Please read the `CONTRIBUTING.md` file for guidelines on how to contribute to the project.

## License

This project is licensed under the terms of the MIT License. See the `LICENSE` file for details.

---

With this guide, you should be well on your way to successfully integrating Alfresco with your GED system. Happy coding!
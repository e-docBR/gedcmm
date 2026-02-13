# Deployment Guide for Alfresco GED Integration

## Introduction
This deployment guide provides step-by-step instructions for deploying the Alfresco GED Integration project. It covers the necessary prerequisites, deployment steps, and post-deployment verification to ensure a successful integration with Alfresco Community Edition.

## Prerequisites
Before deploying the Alfresco GED Integration, ensure that you have the following prerequisites in place:

1. **Alfresco Community Edition**: Ensure that you have a running instance of Alfresco Community Edition. You can download it from the [Alfresco website](https://www.alfresco.com/).

2. **Java Development Kit (JDK)**: Install JDK 8 or higher. Set the `JAVA_HOME` environment variable to point to your JDK installation.

3. **Maven**: Install Apache Maven to build the AMP module. Ensure that Maven is added to your system's PATH.

4. **Git**: Install Git to clone the repository and manage version control.

## Deployment Steps

### Step 1: Clone the Repository
Clone the Alfresco GED Integration repository to your local machine using the following command:
```
git clone <repository-url>
cd alfresco-ged-integration
```

### Step 2: Build the AMP Module
Navigate to the project directory and build the AMP module using Maven:
```
mvn clean install
```
This command compiles the project and generates the AMP file in the `target` directory.

### Step 3: Deploy the AMP Module
1. Locate the generated AMP file in the `target` directory.
2. Use the `amp-builder.py` script to deploy the AMP module to your Alfresco instance:
```
python scripts/amp_builder.py <path-to-amp-file>
```

### Step 4: Restart Alfresco
After deploying the AMP module, restart your Alfresco instance to apply the changes. This can typically be done using the following command:
```
<alfresco-home>/bin/alfresco.sh restart
```

### Step 5: Verify Deployment
To verify that the deployment was successful:
1. Log in to the Alfresco Share interface.
2. Navigate to the relevant areas where the integration features should be available.
3. Check the Alfresco logs for any errors or warnings during startup.

## Post-Deployment
After successful deployment, you may want to configure additional settings or customize the integration further. Refer to the following documents for more information:
- [Content Modeling Guide](../references/content_model_guide.md)
- [Webscript Development Guide](../docs/webscript-development.md)
- [Workflow Configuration Guide](../docs/workflow-configuration.md)

## Troubleshooting
If you encounter issues during deployment, consult the [Troubleshooting Guide](../docs/troubleshooting.md) for common problems and their solutions.

## Conclusion
This guide provided the necessary steps to deploy the Alfresco GED Integration project. For further assistance, refer to the documentation or seek help from the community forums.
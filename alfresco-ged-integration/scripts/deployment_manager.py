# File: /alfresco-ged-integration/alfresco-ged-integration/scripts/deployment_manager.py

import os
import subprocess
import sys

class DeploymentManager:
    def __init__(self, module_path, alfresco_home):
        self.module_path = module_path
        self.alfresco_home = alfresco_home

    def build_module(self):
        print("Building the module...")
        try:
            subprocess.run(['ant', 'deploy', '-Dmodule.path=' + self.module_path], check=True)
            print("Module built successfully.")
        except subprocess.CalledProcessError as e:
            print(f"Error during module build: {e}")
            sys.exit(1)

    def deploy_module(self):
        print("Deploying the module...")
        try:
            # Assuming the module is built and ready for deployment
            module_file = os.path.join(self.module_path, 'dist', 'your-module.amp')
            subprocess.run(['alfresco-mmt', 'install', module_file, self.alfresco_home], check=True)
            print("Module deployed successfully.")
        except subprocess.CalledProcessError as e:
            print(f"Error during module deployment: {e}")
            sys.exit(1)

    def run(self):
        self.build_module()
        self.deploy_module()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python deployment_manager.py <module_path> <alfresco_home>")
        sys.exit(1)

    module_path = sys.argv[1]
    alfresco_home = sys.argv[2]

    manager = DeploymentManager(module_path, alfresco_home)
    manager.run()
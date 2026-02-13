# File: /alfresco-ged-integration/alfresco-ged-integration/tests/integration/test_deployment.py

import unittest
import subprocess

class TestDeployment(unittest.TestCase):

    def setUp(self):
        # Setup code to prepare for tests, if necessary
        self.alfresco_home = "/path/to/alfresco/home"  # Update with actual path
        self.module_name = "custom-module"  # Update with actual module name

    def test_deployment(self):
        # Test the deployment of the Alfresco module
        try:
            result = subprocess.run(
                ["./scripts/deployment_manager.py", self.module_name],
                cwd=self.alfresco_home,
                check=True,
                capture_output=True,
                text=True
            )
            self.assertIn("Deployment successful", result.stdout)
        except subprocess.CalledProcessError as e:
            self.fail(f"Deployment failed with error: {e.stderr}")

    def tearDown(self):
        # Cleanup code after tests, if necessary
        pass

if __name__ == "__main__":
    unittest.main()
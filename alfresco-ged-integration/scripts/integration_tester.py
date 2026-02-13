# integration_tester.py

import requests

class AlfrescoIntegrationTester:
    def __init__(self, base_url, auth):
        self.base_url = base_url
        self.auth = auth

    def test_api_endpoint(self, endpoint):
        response = requests.get(f"{self.base_url}/{endpoint}", auth=self.auth)
        if response.status_code == 200:
            print(f"Test passed for endpoint: {endpoint}")
            return response.json()
        else:
            print(f"Test failed for endpoint: {endpoint} with status code: {response.status_code}")
            return None

    def run_tests(self):
        print("Starting integration tests...")
        endpoints = [
            "api/-default-/public/alfresco/versions/1/nodes",
            "api/-default-/public/alfresco/versions/1/groups",
            "api/-default-/public/alfresco/versions/1/people"
        ]
        
        for endpoint in endpoints:
            self.test_api_endpoint(endpoint)

if __name__ == "__main__":
    BASE_URL = "http://localhost:8080/alfresco"
    AUTH = ('admin', 'admin')  # Replace with your Alfresco credentials

    tester = AlfrescoIntegrationTester(BASE_URL, AUTH)
    tester.run_tests()
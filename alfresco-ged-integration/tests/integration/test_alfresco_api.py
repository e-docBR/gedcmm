import requests
import unittest

class TestAlfrescoAPI(unittest.TestCase):
    BASE_URL = "http://localhost:8080/alfresco/api/-default-/public/alfresco/versions/1/nodes"

    def setUp(self):
        self.auth = ('admin', 'admin')  # Use appropriate credentials

    def test_get_nodes(self):
        response = requests.get(self.BASE_URL, auth=self.auth)
        self.assertEqual(response.status_code, 200)
        self.assertIn('entries', response.json())

    def test_create_node(self):
        data = {
            "name": "Test Document",
            "nodeType": "cm:content"
        }
        response = requests.post(self.BASE_URL, json=data, auth=self.auth)
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.json()['name'], "Test Document")

    def test_update_node(self):
        node_id = "your-node-id"  # Replace with a valid node ID
        data = {
            "name": "Updated Document"
        }
        response = requests.put(f"{self.BASE_URL}/{node_id}", json=data, auth=self.auth)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json()['name'], "Updated Document")

    def test_delete_node(self):
        node_id = "your-node-id"  # Replace with a valid node ID
        response = requests.delete(f"{self.BASE_URL}/{node_id}", auth=self.auth)
        self.assertEqual(response.status_code, 204)

if __name__ == '__main__':
    unittest.main()
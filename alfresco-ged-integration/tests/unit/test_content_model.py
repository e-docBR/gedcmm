import unittest
from your_module import ContentModel  # Substitua 'your_module' pelo nome do módulo que contém a classe ContentModel

class TestContentModel(unittest.TestCase):

    def setUp(self):
        self.content_model = ContentModel()

    def test_create_content_model(self):
        model = self.content_model.create_model("TestModel", {"property1": "value1"})
        self.assertIsNotNone(model)
        self.assertEqual(model.name, "TestModel")
        self.assertIn("property1", model.properties)

    def test_update_content_model(self):
        model = self.content_model.create_model("TestModel", {"property1": "value1"})
        updated_model = self.content_model.update_model(model.id, {"property1": "new_value"})
        self.assertEqual(updated_model.properties["property1"], "new_value")

    def test_delete_content_model(self):
        model = self.content_model.create_model("TestModel", {"property1": "value1"})
        result = self.content_model.delete_model(model.id)
        self.assertTrue(result)
        self.assertIsNone(self.content_model.get_model(model.id))

    def test_get_content_model(self):
        model = self.content_model.create_model("TestModel", {"property1": "value1"})
        fetched_model = self.content_model.get_model(model.id)
        self.assertEqual(fetched_model.id, model.id)

if __name__ == '__main__':
    unittest.main()
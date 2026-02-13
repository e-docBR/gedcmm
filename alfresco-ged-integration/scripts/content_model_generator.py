# File: /alfresco-ged-integration/alfresco-ged-integration/scripts/content_model_generator.py

import os
import xml.etree.ElementTree as ET

class ContentModelGenerator:
    def __init__(self, model_name, properties_file):
        self.model_name = model_name
        self.properties_file = properties_file
        self.model_path = os.path.join('templates', 'content-model', f'{model_name}.xml')
        self.properties_path = os.path.join('templates', 'content-model', f'{model_name}.properties')

    def generate_content_model(self):
        root = ET.Element('model', {'name': self.model_name})
        
        # Define the content model structure
        content_type = ET.SubElement(root, 'contentType', {'name': f'{self.model_name}Type'})
        ET.SubElement(content_type, 'title').text = f'{self.model_name} Document'
        ET.SubElement(content_type, 'description').text = f'This is a custom content model for {self.model_name}.'

        # Add properties from the properties file
        properties = self.load_properties(self.properties_file)
        for prop_name, prop_type in properties.items():
            prop = ET.SubElement(content_type, 'property', {'name': prop_name, 'type': prop_type})
            ET.SubElement(prop, 'title').text = prop_name.capitalize()
            ET.SubElement(prop, 'description').text = f'This is the {prop_name} property.'

        # Write the XML to file
        tree = ET.ElementTree(root)
        tree.write(self.model_path, encoding='utf-8', xml_declaration=True)

    def load_properties(self, properties_file):
        properties = {}
        with open(properties_file, 'r') as file:
            for line in file:
                if line.strip() and not line.startswith('#'):
                    name, type_ = line.strip().split('=')
                    properties[name.strip()] = type_.strip()
        return properties

if __name__ == '__main__':
    model_name = 'customModel'
    properties_file = 'path/to/properties/file.properties'  # Update with actual path
    generator = ContentModelGenerator(model_name, properties_file)
    generator.generate_content_model()
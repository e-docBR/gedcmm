# File: /alfresco-ged-integration/alfresco-ged-integration/scripts/webscript_generator.py

import os
import json

class WebscriptGenerator:
    def __init__(self, name, description, parameters, output_format):
        self.name = name
        self.description = description
        self.parameters = parameters
        self.output_format = output_format
        self.template_dir = os.path.join(os.path.dirname(__file__), '../templates/webscript')
        self.output_dir = os.path.join(os.path.dirname(__file__), '../examples')

    def generate_webscript(self):
        self.create_webscript_directory()
        self.create_description_file()
        self.create_js_file()
        self.create_json_template()
        self.create_html_template()

    def create_webscript_directory(self):
        webscript_path = os.path.join(self.output_dir, self.name)
        os.makedirs(webscript_path, exist_ok=True)

    def create_description_file(self):
        desc_file_path = os.path.join(self.output_dir, self.name, f"{self.name}.get.desc.xml")
        with open(desc_file_path, 'w') as desc_file:
            desc_content = f"""<webscript>
    <short-description>{self.description}</short-description>
    <description>{self.description}</description>
    <url>/api/{self.name}</url>
    <format>{self.output_format}</format>
    <authentication>guest</authentication>
    <permissions>
        <permission>ALL</permission>
    </permissions>
    <parameters>
"""
            for param in self.parameters:
                desc_content += f"        <parameter>{param}</parameter>\n"
            desc_content += """    </parameters>
</webscript>"""
            desc_file.write(desc_content)

    def create_js_file(self):
        js_file_path = os.path.join(self.output_dir, self.name, f"{self.name}.get.js")
        with open(js_file_path, 'w') as js_file:
            js_content = f"""function main() {{
    // Logic for {self.name} webscript
    var jsonResponse = {{
        message: "This is the response from {self.name} webscript"
    }};
    model.jsonResponse = jsonResponse;
}}
"""
            js_file.write(js_content)

    def create_json_template(self):
        json_template_path = os.path.join(self.output_dir, self.name, f"{self.name}.get.json.ftl")
        with open(json_template_path, 'w') as json_file:
            json_content = """{
    "response": "${jsonResponse.message}"
}
"""
            json_file.write(json_content)

    def create_html_template(self):
        html_template_path = os.path.join(self.output_dir, self.name, f"{self.name}.get.html.ftl")
        with open(html_template_path, 'w') as html_file:
            html_content = """<html>
<head>
    <title>${jsonResponse.message}</title>
</head>
<body>
    <h1>${jsonResponse.message}</h1>
</body>
</html>
"""
            html_file.write(html_content)

if __name__ == "__main__":
    # Example usage
    generator = WebscriptGenerator(
        name="exampleWebscript",
        description="An example webscript for demonstration purposes.",
        parameters=["param1", "param2"],
        output_format="json"
    )
    generator.generate_webscript()
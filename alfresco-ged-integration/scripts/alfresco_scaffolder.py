# Contents of /alfresco-ged-integration/alfresco-ged-integration/scripts/alfresco_scaffolder.py

import os
import shutil

def create_project_structure(base_path):
    # Define the directory structure
    directories = [
        'templates/amp-module',
        'templates/content-model',
        'templates/webscript',
        'templates/workflow',
        'templates/custom-action',
        'scripts',
        'examples/custom-document-type/model',
        'examples/custom-document-type/config',
        'examples/advanced-search/webscript',
        'examples/advanced-search/share',
        'examples/custom-workflow/process',
        'examples/custom-workflow/model',
        'examples/bulk-operations',
        'tests/unit',
        'tests/integration',
        'docs',
        'config'
    ]

    # Create directories
    for directory in directories:
        os.makedirs(os.path.join(base_path, directory), exist_ok=True)

def create_template_files(base_path):
    # Create template files with basic content
    template_files = {
        'templates/amp-module/module.properties': 'module.name=custom-module\nmodule.version=1.0\n',
        'templates/amp-module/module-context.xml': '<beans xmlns="http://www.springframework.org/schema/beans">\n</beans>',
        'templates/content-model/customModel.xml': '<model>\n</model>',
        'templates/content-model/customModel.properties': 'customModel.name=Custom Model\n',
        'templates/webscript/service.get.desc.xml': '<webscript>\n</webscript>',
        'templates/webscript/service.get.js': 'function main() {\n}\n',
        'templates/webscript/service.get.json.ftl': '{}',
        'templates/webscript/service.get.html.ftl': '<html>\n</html>',
        'templates/workflow/workflow-definition.bpmn20.xml': '<bpmn:process>\n</bpmn:process>',
        'templates/workflow/workflow-model.xml': '<workflow>\n</workflow>',
        'templates/custom-action/custom-action-context.xml': '<beans>\n</beans>',
        'templates/custom-action/CustomActionExecuter.java': 'public class CustomActionExecuter {\n}',
    }

    # Create template files
    for file_path, content in template_files.items():
        with open(os.path.join(base_path, file_path), 'w') as f:
            f.write(content)

def main():
    base_path = os.path.dirname(os.path.abspath(__file__))
    
    # Create project structure
    create_project_structure(base_path)
    
    # Create template files
    create_template_files(base_path)

if __name__ == '__main__':
    main()
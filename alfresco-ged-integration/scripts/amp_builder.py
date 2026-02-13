# File: /alfresco-ged-integration/alfresco-ged-integration/scripts/amp_builder.py

import os
import subprocess
import sys

def build_amp(module_name, output_dir):
    """
    Build the AMP module using the provided module name and output directory.
    """
    try:
        # Define the command to build the AMP
        command = [
            'mvn', 'clean', 'package', 
            '-DskipTests', 
            f'-DmoduleName={module_name}', 
            f'-DoutputDir={output_dir}'
        ]
        
        # Execute the command
        subprocess.check_call(command)
        print(f"AMP for module '{module_name}' built successfully and located in '{output_dir}'.")

    except subprocess.CalledProcessError as e:
        print(f"Error occurred while building AMP: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python amp_builder.py <module_name> <output_dir>")
        sys.exit(1)

    module_name = sys.argv[1]
    output_dir = sys.argv[2]

    build_amp(module_name, output_dir)
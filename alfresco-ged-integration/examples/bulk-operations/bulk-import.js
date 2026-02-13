// bulk-import.js
const fs = require('fs');
const path = require('path');
const alfrescoApi = require('alfresco-js-api-node');

const bulkImport = async (directoryPath) => {
    try {
        const files = fs.readdirSync(directoryPath);
        for (const file of files) {
            const filePath = path.join(directoryPath, file);
            const fileStat = fs.statSync(filePath);
            if (fileStat.isFile()) {
                await importFile(filePath);
            } else if (fileStat.isDirectory()) {
                await bulkImport(filePath);
            }
        }
    } catch (error) {
        console.error('Error during bulk import:', error);
    }
};

const importFile = async (filePath) => {
    try {
        const fileContent = fs.readFileSync(filePath);
        const fileName = path.basename(filePath);
        
        // Assuming the file is a document to be uploaded
        const uploadResponse = await alfrescoApi.core.nodesApi.uploadNode(
            'workspace://SpacesStore', // Replace with the appropriate destination
            fileName,
            fileContent,
            {},
            {}
        );
        
        console.log(`Successfully imported: ${fileName} with ID: ${uploadResponse.id}`);
    } catch (error) {
        console.error(`Failed to import file ${filePath}:`, error);
    }
};

// Start the bulk import process
const directoryToImport = process.argv[2] || './documents'; // Default directory
bulkImport(directoryToImport);
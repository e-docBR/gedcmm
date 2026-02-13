// bulk-metadata-update.js

const AlfrescoApi = require('alfresco-js-api-node');
const fs = require('fs');
const path = require('path');

// Alfresco API configuration
const alfrescoApi = new AlfrescoApi({
    hostEcm: 'http://localhost:8080/alfresco',
    hostBpm: 'http://localhost:8080/activiti',
    authType: 'basic',
    username: 'admin',
    password: 'admin'
});

// Function to update metadata in bulk
async function bulkUpdateMetadata(filePath) {
    try {
        // Read the metadata updates from a JSON file
        const updates = JSON.parse(fs.readFileSync(filePath, 'utf8'));

        for (const update of updates) {
            const { nodeId, properties } = update;

            // Update the metadata for each node
            await alfrescoApi.nodes.updateNode(nodeId, { properties });
            console.log(`Updated metadata for node: ${nodeId}`);
        }

        console.log('Bulk metadata update completed successfully.');
    } catch (error) {
        console.error('Error during bulk metadata update:', error);
    }
}

// Execute the bulk update
const metadataFilePath = path.join(__dirname, 'metadata-updates.json');
bulkUpdateMetadata(metadataFilePath);
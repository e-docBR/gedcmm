function main() {
    // Define the response object
    var response = {
        status: 200,
        data: null,
        message: ''
    };

    try {
        // Retrieve the parameters from the request
        var nodeId = url.templateArgs.nodeId;

        // Validate the nodeId parameter
        if (!nodeId) {
            response.status = 400;
            response.message = 'Missing required parameter: nodeId';
            return jsonUtils.toJSONString(response);
        }

        // Fetch the node from the repository
        var node = search.findNode("workspace://SpacesStore/" + nodeId);
        
        // Check if the node exists
        if (!node) {
            response.status = 404;
            response.message = 'Node not found';
            return jsonUtils.toJSONString(response);
        }

        // Prepare the response data
        response.data = {
            id: node.id,
            name: node.properties["cm:name"],
            type: node.properties["cm:contentType"],
            created: node.properties["cm:created"],
            modified: node.properties["cm:modified"],
            properties: node.properties
        };

    } catch (error) {
        // Handle any unexpected errors
        response.status = 500;
        response.message = 'An error occurred: ' + error.message;
    }

    // Return the response as JSON
    return jsonUtils.toJSONString(response);
}

// Execute the main function
main();
// advanced-search.get.js

function main() {
    // Get the search parameters from the request
    var searchTerm = url.templateArgs.searchTerm;
    var results = [];

    // Perform the search using Alfresco's search service
    var searchResults = search.luceneSearch("cm:title:" + searchTerm + " OR cm:description:" + searchTerm);

    // Process the search results
    for each (var result in searchResults) {
        var node = search.findNode("workspace://SpacesStore/" + result.nodeRef);
        if (node != null) {
            results.push({
                id: node.properties["cm:nodeId"],
                title: node.properties["cm:title"],
                description: node.properties["cm:description"],
                created: node.properties["cm:created"],
                modified: node.properties["cm:modified"],
                mimeType: node.properties["cm:content"].mimeType
            });
        }
    }

    // Set the response content type to JSON
    model.results = results;
}

// Execute the main function
main();
# File: /alfresco-ged-integration/alfresco-ged-integration/references/api_reference.md

# API Reference for Alfresco GED Integration

## Overview
This document provides a comprehensive reference for the Alfresco API endpoints used in the GED integration. It includes details about the available endpoints, their parameters, and example requests and responses.

## Base URL
The base URL for accessing the Alfresco API is:
```
http://<alfresco-server>:<port>/alfresco/api/-default-/public/alfresco/versions/1/nodes/
```

## Endpoints

### 1. Get Node Details
- **Endpoint:** `GET /{nodeId}`
- **Description:** Retrieves the details of a specific node.
- **Parameters:**
  - `nodeId` (string): The ID of the node to retrieve.
- **Example Request:**
  ```
  GET http://<alfresco-server>:<port>/alfresco/api/-default-/public/alfresco/versions/1/nodes/{nodeId}
  ```
- **Example Response:**
  ```json
  {
    "id": "{nodeId}",
    "name": "Document Name",
    "type": "cm:content",
    "properties": {
      "cm:description": "Description of the document",
      "cm:created": "2023-01-01T00:00:00.000Z"
    }
  }
  ```

### 2. Create Node
- **Endpoint:** `POST /{parentId}/children`
- **Description:** Creates a new node as a child of the specified parent node.
- **Parameters:**
  - `parentId` (string): The ID of the parent node.
- **Request Body:**
  ```json
  {
    "name": "New Document",
    "nodeType": "cm:content",
    "properties": {
      "cm:description": "Description of the new document"
    }
  }
  ```
- **Example Request:**
  ```
  POST http://<alfresco-server>:<port>/alfresco/api/-default-/public/alfresco/versions/1/nodes/{parentId}/children
  ```
- **Example Response:**
  ```json
  {
    "id": "{newNodeId}",
    "name": "New Document",
    "type": "cm:content"
  }
  ```

### 3. Update Node
- **Endpoint:** `PUT /{nodeId}`
- **Description:** Updates the properties of a specific node.
- **Parameters:**
  - `nodeId` (string): The ID of the node to update.
- **Request Body:**
  ```json
  {
    "properties": {
      "cm:description": "Updated description"
    }
  }
  ```
- **Example Request:**
  ```
  PUT http://<alfresco-server>:<port>/alfresco/api/-default-/public/alfresco/versions/1/nodes/{nodeId}
  ```
- **Example Response:**
  ```json
  {
    "id": "{nodeId}",
    "name": "Document Name",
    "properties": {
      "cm:description": "Updated description"
    }
  }
  ```

### 4. Delete Node
- **Endpoint:** `DELETE /{nodeId}`
- **Description:** Deletes a specific node.
- **Parameters:**
  - `nodeId` (string): The ID of the node to delete.
- **Example Request:**
  ```
  DELETE http://<alfresco-server>:<port>/alfresco/api/-default-/public/alfresco/versions/1/nodes/{nodeId}
  ```
- **Example Response:**
  ```json
  {
    "message": "Node deleted successfully"
  }
  ```

## Authentication
All API requests require authentication. Use Basic Authentication with a valid Alfresco username and password.

## Conclusion
This API reference serves as a guide for developers integrating with the Alfresco GED system. For further details, refer to the official Alfresco documentation.
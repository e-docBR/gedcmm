{
  "name": "service.get",
  "description": "This web script retrieves data from the Alfresco GED integration.",
  "url": "/alfresco/ged/service",
  "format": "json",
  "contentType": "application/json",
  "authentication": "user",
  "requiredPermissions": {
    "read": true
  },
  "parameters": {
    "id": {
      "type": "string",
      "required": true,
      "description": "The ID of the resource to retrieve."
    }
  },
  "output": {
    "type": "json",
    "properties": {
      "status": {
        "type": "string",
        "description": "The status of the request."
      },
      "data": {
        "type": "object",
        "description": "The retrieved resource data."
      },
      "error": {
        "type": "string",
        "description": "Error message if the request fails."
      }
    }
  }
}
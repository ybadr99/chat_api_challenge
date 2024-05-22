# Chat System API

Chat system API built with Ruby on Rails, containerized using Docker, and utilizing MySQL, Elasticsearch, and Redis. The system supports creating applications, chats, and messages, with features such as unique identifiers, message search capabilities, race condition handling, and background job processing using a queue system.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Usage](#usage)
3. [API Endpoints](#api-endpoints)

## Project Overview

The Chat System API app is designed to handle the creation of applications, chats, and messages, with the following key features:

- Each application has a unique token for identification.
- Chats and messages within an application are uniquely numbered.
- Messages can be searched using Elasticsearch.
- Background jobs are used to update chat and message counts.
- The system is containerized for easy setup and deployment.

## Installation

## Usage and Running the Application

1. Start the application using Docker:

   ```bash
   docker-compose up
   ```

2. The API will be accessible at `http://localhost:3000`.

## API Endpoints

### Core Endpoints

- **Create Application**

  ```http
  POST /applications
  ```

  Request Body:

  ```json
  {
    "name": "Application Name"
  }
  ```

- **Get Applications**

  ```http
  GET /applications
  ```

- **Create Chat**

  ```http
  POST /applications/:application_token/chats
  ```

- **Get Chats**

  ```http
  GET /applications/:application_token/chats
  ```

- **Create Message**

  ```http
  POST /applications/:application_token/chats/:chat_number/messages
  ```

- **Get Messages**

  ```http
  GET /applications/:application_token/chats/:chat_number/messages
  ```

- **Search Messages**

  ```http
  GET /applications/:application_token/chats/:chat_number/messages/search?query='your text'
  ```

  Query Parameters:

  - `query`: The search query string to partially match messages' bodies.

## Postman Collection

To facilitate testing, a Postman collection is provided. This collection includes pre-configured requests for all available endpoints, making it easier to test and verify the functionality of the API.

### Importing the Collection

1. Open Postman.
2. Click on the `Import` button.
3. Select the provided Postman collection file (`Chat_system_challenge.postman_collection.json`).
4. Once imported, you will see a collection named "Chat_system_challenge" with all the endpoints ready for testing.


---


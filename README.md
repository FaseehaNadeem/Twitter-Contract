# Documentation of Twitter Contract

## Introduction
This contract is designed to replicate basic functionalities of a social media platform like Twitter. It allows users to create tweets, send messages, follow other users, and manage access permissions. The contract maintains a record of tweets, messages, and user interactions.

## Structs

### Tweet Struct
The `Tweet` struct stores information about a tweet, including:
- `ID`: Unique identifier for each tweet.
- `Author`: Address of the user who created the tweet.
- `Content`: The content of the tweet.
- `CreatedAt`: Timestamp of when the tweet was created.

### Message Struct
The `Message` struct stores information about direct messages sent between users, including:
- `ID`: Unique identifier for each message.
- `from`: Address of the sender.
- `to`: Address of the recipient.
- `content`: The actual message content.
- `CreatedAt`: Timestamp of when the message was sent.

## Functions

### `tweet(address from, string memory content)`
This function allows a user to create a tweet. It:
1. Ensures that the caller (`msg.sender`) matches the `from` address.
2. Stores the tweet in the `tweets` mapping with a unique `nextID`.
3. Adds the tweet ID to the `tweetsof` mapping for the user.
4. Increments the `nextID` counter.

### `_tweet(string memory content)`
This function allows a user to tweet using their own address as the author.

### `_tweet(address from, string memory content)`
This function allows a tweet to be posted on behalf of another address.

### `sendmessage(address from, address to, string memory message)`
This function allows users to send direct messages. It:
1. Ensures that the caller (`msg.sender`) matches the `from` address.
2. Stores the message in the `conversations` mapping under the sender's address.
3. Increments the `nextMessageID` counter.

### `sendMessage(string memory message, address to)`
This function allows the sender (`msg.sender`) to send a message to another user.

### `sendMessage(address from, address to, string memory message)`
This function allows a message to be sent on behalf of another user.

### `follow(address followed)`
This function allows a user to follow another user by adding their address to the `following` mapping.

### `allow(address _operator)`
This function allows a user to grant permission to another address to act on their behalf.

### `Disallow(address _operator)`
This function revokes permission previously granted to an operator.

### `getLatestTweets(uint count)`
This function retrieves the latest tweets. It:
1. Ensures the requested `count` is valid.
2. Iterates through the most recent `count` tweets.
3. Returns an array of `Tweet` structs.

### `getLatestofUser(address user, uint count)`
This function retrieves the latest tweets of a specific user. It:
1. Ensures the requested `count` is valid.
2. Fetches the tweet IDs associated with the user.
3. Iterates through the most recent `count` tweets.
4. Returns an array of `Tweet` structs.


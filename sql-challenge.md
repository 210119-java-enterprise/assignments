# SQL Challenge

You are developing a new forum for a new company that wants to provide a new forum platform for users to share ideas and comment on each others posts. Some simple entities have already been identified and some basic relationships between them have been planned out (though not completely diagrammed and related to one another). Your job is to finish the ERD that expresses the desired relationships - with all tables in at least 3NF.

## Application Description

The application will support the ability for end-users to be able to sign up for an account. Standard user accounts will have the ability to create new threads on existing boards, as well as share new posts on existing threads. Posts can be made either directly to the initial post of a thread, or to another post already on the thread (creating an inner post chain). Both threads and posts are able to be upvoted and downvoted by users, and this should be tracked for each user for marketing purposes. Users should be able to subscribe to threads. This can be done either by upvoting the thread, or by simply following it (which can be done without actually upvoting the thread). Lastly, the ability for users to directly message one another and for this message history to be retained should be supported.

## Incomplete ERD

![devboards-erd-incomplete](https://github.com/210119-java-enterprise/assignments/blob/main/assets/devboards-challenge.png)


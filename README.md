README
------

Google Developer Console
------------------------

If you want to upload video you should:
1. Select/create a project at Google Developer Console:
   https://console.developers.google.com/project
    [Redirect URIs]
    http://video-service.ru:4000/users/auth/google_oauth2
    http://video-service.ru:4000/users/auth/google_oauth2/callback
    [Javascript Origins]
    http://video-service.ru:4000
2. In the sidebar on the left, select APIs & auth. In the list of APIs, make sure the status is ON for the YouTube Data API v3.
3. In the sidebar on the left, select Credentials.
4. he API supports two types of credentials. Create whichever credentials are appropriate for your project:
    4.1 OAuth 2.0: Your application must send an OAuth 2.0 token with any request that accesses private user data. Your application sends a client ID and, possibly, a client secret to obtain a token. You can generate OAuth 2.0 credentials for web applications, service accounts, or installed applications.
    Learn more

    4.2 API keys: A request that does not provide an OAuth 2.0 token must send an API key. The key identifies your project and provides API access, quota, and reports.
    If the key type you need does not already exist, create an API key by selecting Create New Key and then selecting the appropriate key type. Then enter the additional data required for that key type.

Environment variables
---------------------
`GOOGLE_KEY` (Oauth2 authorization)
`GOOGLE_SECRET`
`FACEBOOK_KEY`
`FACEBOOK_SECRET`
`SECRET_KEY_BASE` (for production only)

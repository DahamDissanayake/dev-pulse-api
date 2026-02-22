import ballerina/http;
import ballerinax/github;

// This token will be securely injected by Choreo so it never leaks in frontend code
configurable string githubToken = ?;

github:Client github = check new ({
    auth: {
        token: githubToken
    }
});

// Create a public API listening on port 8080
service /api on new http:Listener(8080) {
    
    // Endpoint: GET /api/pulse/{username}
    resource function get pulse/[string username]() returns json|error {
        
        // Fetch real-time data from GitHub
        github:UserResponse user = check github->/users/[username];
        
        // Removed `?:` because the connector guarantees these are always integers
        int repos = user.public_repos;
        int followers = user.followers;
        
        int pulseScore = (repos * 5) + (followers * 2);

        // Construct the clean JSON payload
        json response = {
            // Removed `?:` because login is guaranteed to be a string
            "developer": user.login, 
            
            // Kept `?:` because users can leave their name/bio blank on GitHub
            "profileName": user.name ?: "Anonymous Developer",
            "bio": user.bio ?: "No bio available",
            
            "metrics": {
                "publicRepos": repos,
                "followers": followers,
                "devPulseScore": pulseScore
            },
            "status": "Dev-Pulse API Active"
        };

        return response;
    }
}
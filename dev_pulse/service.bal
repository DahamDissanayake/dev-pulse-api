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
        
        // Safely extract metrics with explicit type checks
        anydata publicReposVal = user["public_repos"];
        int repos = publicReposVal is int ? publicReposVal : 0;
        
        anydata followersVal = user["followers"];
        int followers = followersVal is int ? followersVal : 0;
        
        int pulseScore = (repos * 5) + (followers * 2);

        // Safely extract profile info
        anydata loginVal = user["login"];
        anydata nameVal = user["name"];
        anydata bioVal = user["bio"];

        // Construct the clean JSON payload
        json response = {
            "developer": loginVal is string ? loginVal : "Unknown",
            "profileName": nameVal is string ? nameVal : "Anonymous Developer",
            "bio": bioVal is string ? bioVal : "No bio available",
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
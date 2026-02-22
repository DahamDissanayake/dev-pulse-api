# ⚡ Dev-Pulse API

![Ballerina](https://img.shields.io/badge/Built_with-Ballerina-20B6B0?style=for-the-badge&logo=ballerina&logoColor=white)
![WSO2 Choreo](https://img.shields.io/badge/Hosted_on-WSO2_Choreo-000000?style=for-the-badge)
![Next.js](https://img.shields.io/badge/Frontend-Next.js-black?style=for-the-badge&logo=next.js&logoColor=white)

Dev-Pulse is a cloud-native backend service that securely aggregates developer metrics (like GitHub repositories and followers) and calculates a live "Dev-Pulse Score." It is designed to act as a Backend-for-Frontend (BFF), allowing developers to display real-time GitHub statistics on their personal portfolios without exposing their Personal Access Tokens (PATs) to the browser.

## ✨ Why Ballerina & WSO2 Choreo?

This project is built to demonstrate modern, cloud-native API orchestration.

- **The Code: Ballerina 🦢**
  Instead of writing hundreds of lines of boilerplate code in Node.js or Python to handle HTTP requests, JSON parsing, and error routing, this API is written in [Ballerina](https://ballerina.io/). Because Ballerina is an **integration-first language**, network calls are treated as first-class citizens. Using the native `ballerinax/github` connector, we can safely fetch and transform GitHub data in under 40 lines of strictly typed, highly readable code.
- **The Cloud: WSO2 Choreo ☁️**
  The API is deployed on [WSO2 Choreo](https://choreo.dev/), a platform engineered for API management and seamless DevOps. Choreo completely abstracts away the deployment infrastructure. It provides:
  - **Secure Secrets:** The GitHub PAT is securely injected at runtime, meaning it is never exposed in the source code or the frontend.
  - **API Gateway:** Built-in rate limiting and OAuth2 protection.
  - **Developer Portal:** A ready-to-use storefront where developers can generate their own Bearer tokens to consume the API.

---

## 🚀 How to Use the API (Frontend Integration)

If you have been granted an API key from the Dev-Pulse Developer Portal, you can easily integrate this into your Next.js portfolio.

### 1. Environment Variables

Add your Choreo API credentials to your `.env.local` file:

```env
DEV_PULSE_API_KEY=your_choreo_production_bearer_token
DEV_PULSE_API_URL=https://your-choreo-api-url.com/v1
```

### 2. The Next.js Server Component

You can find a professional, ready-to-use React Server Component (built with Tailwind CSS and Lucide icons) in the [React-Component](./React-Component) folder.

Simply copy [DevPulseCard.tsx](./React-Component/DevPulseCard.tsx) into your Next.js project and import it into your page. Because this uses Next.js App Router, the API call happens securely on the server.

---

## 🛠️ How to Host Your Own Dev-Pulse API

Want to deploy your own instance of this backend?

### Local Development

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dev-pulse-api.git
   cd dev-pulse-api/dev_pulse
   ```
2. Create a `Config.toml` file in the root of the Ballerina project:

   ```toml
   githubToken = "your_github_personal_access_token"
   ```

   (Note: Ensure `Config.toml` is added to your `.gitignore`)

3. Run the Ballerina service:
   ```bash
   bal run
   ```
4. Test the endpoint: `http://localhost:8080/api/pulse/{username}`

### Deploying to Choreo

1. Create a free account at [console.choreo.dev](https://console.choreo.dev).
2. Create a new Service component and link your forked GitHub repository.
3. Select Ballerina as the buildpack and set the project path to `/dev_pulse`.
4. In the **Configs & Secrets** tab, add an environment variable named `githubToken` and paste your GitHub PAT.
5. Click **Deploy**.
6. Promote the API to Production to generate your endpoint URLs and API keys!

Built by DahamDissanayake.

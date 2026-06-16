# OMI Desktop

macOS app for OMI — always-on AI companion. Swift/SwiftUI frontend, Rust backend.

## Structure

```
Desktop/          Swift/SwiftUI macOS app (SPM package)
Backend-Rust/     Rust API server (Firestore, Redis, auth, LLM)
agent/            Agent runtime for multi-provider chat (TypeScript)
agent-cloud/      Cloud agent service
dmg-assets/       DMG installer resources
```

## Development

Requires macOS 14.0+, Rust toolchain, and code signing with an Apple Developer ID.

### Local Dementia MVP

The local MVP keeps the assistant, safety prompt, and vision-language reasoning on the Mac. It does not require Firebase, Firestore, Redis, Cloudflare tunnels, Anthropic, OpenAI, Gemini, or Deepgram.

Start an OpenAI-compatible local VLM first:

```bash
scripts/run-local-vlm.sh
```

Then run the app against the local Rust backend:

```bash
OMI_APP_NAME="omi-cosmo-memory" ./run.sh --local
```

Useful local VLM overrides:

```bash
LOCAL_VLM_BASE_URL=http://127.0.0.1:8000/v1
LOCAL_VLM_MODEL=Qwen/Qwen2.5-VL-3B-Instruct-AWQ
LOCAL_VLM_STRIP_TOOLS=true
```

`--local` routes pi-mono chat to `POST /v2/local/chat/completions`, which forwards text/image requests to the local VLM with a dementia-support system prompt.

### Full Cloud Dev

```bash
# Run (builds Swift app, starts Rust backend, launches app)
./run.sh

# Run with the prod backend (skips local Rust + tunnel)
./run.sh --yolo
```

`run.sh` auto-detects an `Apple Development` or `Developer ID Application` signing identity from your login keychain. Override with `OMI_SIGN_IDENTITY="..." ./run.sh`.

## License

MIT

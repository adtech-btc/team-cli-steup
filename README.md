# OpenCode Team Setup

Complete OpenCode configuration with oh-my-opencode, Antigravity auth, and OpenAI Codex auth.

## Installation

### 0. Install OpenCode

```bash
# Method 1: Official install script (recommended)
curl -fsSL https://opencode.ai/install | bash

# Method 2: Using npm
npm install -g opencode-ai

# Method 3: Using bun
bun install -g opencode-ai

# Method 4: Using pnpm
pnpm install -g opencode-ai
```

Verify installation:
```bash
opencode --version
```

### 1. Create config directory

```bash
mkdir -p ~/.config/opencode
```

### 2. Install LSP servers

```bash
npm install -g typescript-language-server typescript pyright
```

### 3. Write opencode.jsonc

Create `~/.config/opencode/opencode.jsonc`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "openai/gpt-5.2",
  "small_model": "google/antigravity-gemini-3-flash",
  "plugin": [
    "oh-my-opencode",
    "opencode-antigravity-auth@1.2.8",
    "opencode-openai-codex-auth",
    "@franlol/opencode-md-table-formatter@0.0.3"
  ],
  "keybinds": {
    "input_paste": "none"
  },
  "provider": {
    "google": {
      "name": "Google",
      "models": {
        "antigravity-gemini-3-pro": {
          "name": "Gemini 3 Pro (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingLevel": "low" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-gemini-3-pro-high": {
          "name": "Gemini 3 Pro High (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-gemini-3-pro-low": {
          "name": "Gemini 3 Pro Low (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-gemini-3-flash": {
          "name": "Gemini 3 Flash (Antigravity)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "minimal": { "thinkingLevel": "minimal" },
            "low": { "thinkingLevel": "low" },
            "medium": { "thinkingLevel": "medium" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-claude-sonnet-4-5": {
          "name": "Claude Sonnet 4.5 (Antigravity)",
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-claude-sonnet-4-5-thinking": {
          "name": "Claude Sonnet 4.5 Thinking (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "antigravity-claude-opus-4-5-thinking": {
          "name": "Claude Opus 4.5 Thinking (Antigravity)",
          "thinking": true,
          "attachment": true,
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "gemini-2.5-flash": {
          "name": "Gemini 2.5 Flash (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-2.5-pro": {
          "name": "Gemini 2.5 Pro (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-flash-preview": {
          "name": "Gemini 3 Flash Preview (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-pro-preview": {
          "name": "Gemini 3 Pro Preview (Gemini CLI)",
          "attachment": true,
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        }
      }
    },
    "openai": {
      "name": "OpenAI",
      "options": {
        "reasoningEffort": "high",
        "reasoningSummary": "detailed",
        "textVerbosity": "medium",
        "include": ["reasoning.encrypted_content"],
        "store": false
      },
      "models": {
        "gpt-5.2": {
          "name": "GPT 5.2 (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "none": { "reasoningEffort": "none", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "low": { "reasoningEffort": "low", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        },
        "gpt-5.2-codex": {
          "name": "GPT 5.2 Codex (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "low": { "reasoningEffort": "low", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "auto", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        },
        "gpt-5.1-codex-max": {
          "name": "GPT 5.1 Codex Max (OAuth)",
          "limit": { "context": 272000, "output": 128000 },
          "modalities": { "input": ["text", "image"], "output": ["text"] },
          "variants": {
            "low": { "reasoningEffort": "low", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "medium": { "reasoningEffort": "medium", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "high": { "reasoningEffort": "high", "reasoningSummary": "detailed", "textVerbosity": "medium" },
            "xhigh": { "reasoningEffort": "xhigh", "reasoningSummary": "detailed", "textVerbosity": "medium" }
          }
        }
      }
    }
  }
}
```

### 4. Write oh-my-opencode.json

Create `~/.config/opencode/oh-my-opencode.json`:

```json
{
  "$schema": "https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json",
  "google_auth": false,
  "lsp": {
    "typescript-language-server": {
      "command": ["typescript-language-server", "--stdio"],
      "extensions": [".ts", ".tsx", ".js", ".jsx"],
      "priority": 10
    },
    "pyright": {
      "command": ["pyright-langserver", "--stdio"],
      "extensions": [".py"],
      "priority": 10
    }
  },
  "agents": {
    "Sisyphus": {
      "model": "openai/gpt-5.2"
    },
    "oracle": {
      "model": "openai/gpt-5.2"
    },
    "librarian": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "explore": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "frontend-ui-ux-engineer": {
      "model": "google/antigravity-gemini-3-pro-high"
    },
    "document-writer": {
      "model": "google/antigravity-gemini-3-flash"
    },
    "multimodal-looker": {
      "model": "google/antigravity-gemini-3-flash"
    }
  }
}
```

### 5. Delete opencode.json if exists

```bash
rm -f ~/.config/opencode/opencode.json
```

This prevents config conflicts (OpenCode prioritizes `.jsonc` over `.json`).

### 6. Authenticate providers

```bash
# Google Antigravity
opencode auth login
# Select: Google → OAuth with Antigravity

# OpenAI
opencode auth login
# Select: OpenAI → ChatGPT Plus/Pro (Codex)
```

---

## Available Models

### Google Antigravity Models

| Model | Description | Thinking |
|-------|-------------|----------|
| `google/antigravity-gemini-3-pro` | Gemini 3 Pro | low/high variants |
| `google/antigravity-gemini-3-flash` | Gemini 3 Flash (fast) | minimal/low/medium/high |
| `google/antigravity-claude-sonnet-4-5` | Claude Sonnet 4.5 | No |
| `google/antigravity-claude-sonnet-4-5-thinking` | Claude Sonnet 4.5 | low/max variants |
| `google/antigravity-claude-opus-4-5-thinking` | Claude Opus 4.5 | low/max variants |

### OpenAI Models

| Model | Description | Reasoning |
|-------|-------------|-----------|
| `openai/gpt-5.2` | GPT 5.2 (default) | none/low/medium/high/xhigh |
| `openai/gpt-5.2-codex` | GPT 5.2 Codex | low/medium/high/xhigh |
| `openai/gpt-5.1-codex-max` | GPT 5.1 Codex Max | low/medium/high/xhigh |

---

## oh-my-opencode Agents

| Agent | Model | Purpose |
|-------|-------|---------|
| Sisyphus | openai/gpt-5.2 | Main orchestrator |
| oracle | openai/gpt-5.2 | Architecture, code review |
| librarian | antigravity-gemini-3-flash | Codebase analysis |
| explore | antigravity-gemini-3-flash | Fast exploration |
| frontend-ui-ux-engineer | antigravity-gemini-3-pro-high | UI/UX design |
| document-writer | antigravity-gemini-3-flash | Documentation |
| multimodal-looker | antigravity-gemini-3-flash | Image/PDF analysis |

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+K` | Open model selector |
| `Ctrl+E` | Switch variant (thinking level) |
| `/model` | Same as Ctrl+K |

---

## Tips

- Use `ultrawork` or `ulw` in prompts to activate full oh-my-opencode orchestration
- Title generation uses `antigravity-gemini-3-flash` (cheap & fast)
- Default reasoning effort is `high` for OpenAI models

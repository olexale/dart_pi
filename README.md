# dart_pi

A minimal coding agent in Dart, built from an empty folder during a live stream.

- 📺 Live stream: [Build Your Own Claude Code in Dart](https://www.youtube.com/watch?v=zw_SJYEiF9g)
- 📝 Text version: [Build your own Claude Code in Dart](https://leushchenko.com/writing/build-your-own-claude-code-in-dart)

Claude Code is half a million lines of TypeScript, but the foundation is one API call in a `while (true)` loop. This repo builds that foundation: a chat loop, a system prompt, and tools that let the agent read files, including its own source code.

I committed often, so you can follow the git history step by step.

## Running it

You need the [Dart SDK](https://dart.dev/get-dart) and [Ollama](https://ollama.com/) with the model from the stream:

```bash
ollama pull gemma4:e2b
```

Then generate the code and start the agent:

```bash
dart pub get
dart run build_runner build
dart run bin/dart_pi.dart
```

Type at the >>> prompt. An empty line exits.

Any OpenAI-compatible endpoint works. Change baseUrl in bin/dart_pi.dart and model in lib/src/agent.dart.
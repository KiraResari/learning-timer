![Learning Timer Logo](/assets/images/AppIcon.png)
# Learning Timer

A learning project where I experiment with generative AI to create a  flutter app, comparing ChatGPT (Version 3.5) and Bard (PaLM2), seeing what results I get from  the same input prompt, and how many corrections are required to get the desired result.

I am going to include two log files to keep track of my prompts.

* Bard Log.md
* ChatGPT Log.md

These logs will follow a pattern of Prompt-Response-Result, where:

* Prompt: The exact prompt I wrote to Bard/ChatGPT
* Response: The exact response produced by Bard/ChatGPT
* Result: A description of the result, pointing out compile issues and program issues, as well as things that notably work in contrast to the competitor's version
  * Compile issues: Errors and warnings
    * If there are errors, I will try to fix them in order to be able to run the program and see what the result looks like
  * Program issues: Where the program does not match my expectations

I am going to make one commit after each prompt cycle (referred to as Rounds), which means one update to the Bard version, and one update to the ChatGPT version simultaneously (unless one of those two versions is already perfect). Since I may also make additional commits for each rounds as I update these logs, I will additionally include the round number in each commit.

# Conclusion

In the end, ChatGPT was able to successfully create the app that I envisioned within 5 rounds, while Bard's responses grew ever more unhelpful and it even started repeating mistakes so that I felt it was not worth continuing after round 5, and called Bard KOed.

I have to add that I did run the ChatGPT test in a context that I primed specifically for flutter, so that might also have affected the outcome. I'll add the priming statement to the `ChatGPT Log.md`.

As such, I also added a Bonus Round where I primed the Bard context with the same message as the ChatGPT context. The logs for those are in `FlutterBard Log.md`. The result was that while the primed FlutterBard lasted 2 rounds longer than its unprimed counterpart, it also regularly returned code that could not be run, until in the end it again started returning the same broken code again, ignoring what I asked it to improve. So FlutterBard is also KOed. 

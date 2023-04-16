# peeking at assembly...
Malware Analysis Finals Project. Allows you to peak into functions and look at what the assembly would look like for that section of code. I really wanted to add this because I think I would use it, and it could be very useful when learning assembly. 

### current idea: implement a plugin that does a couple things:
- allows you to select what you want to see the assembly of
- takes those lines of code and wraps them in a main function or something like that
- then, compiles that in its own temp file and spits out the assembly.

I'm not sure if this will work but I'm going to try. I think the key here is getting assembly output to actually be
just the code that is selected. There are ways to just copy the selection to its a buffer and then paste it into a file, 
but is that doing too much? or too little? Much to learn...


some links that I'm using to start learning stuff
https://stackoverflow.com/questions/137038/how-do-you-get-assembler-output-from-c-c-source-in-gcc

https://godbolt.org/

https://stackoverflow.com/questions/38552116/how-to-remove-noise-from-gcc-clang-assembly-output



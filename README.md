# Project Asiago
We belive that most computer systems are inheritently broken. Project Asiago is reinventing everything as a unified whole to fix these problems.

If you'd like to discuss ideas and concepts about the development of Project Asiago, feel free to join the Telegram [chat](https://t.me/joinchat/AAAAAEF_t3aEpuC9QxJ5MQ).

## Philosophy
![Computer are shit protocols built on shit specs, never designed for security from the ground up](https://i.imgur.com/dptlklX.png)

![Too many ways in, you're fucked if they want to get you](https://i.imgur.com/TY5A46q.png)

The "brokenness" is mainly a concern over security, stability, and integration. Systems are so fragmented that security breaches are almost inevitable. There are some systems that work wonders, Docker and GuixSD for example. However, this is almost a hack onto how the program was originally written to function and can cause other issues in and of itself. People use different languages, frameworks, and styles to do all their development, and this causes pain to the developer to provide integrations to other software. Imagine if everybody were to write everything in your favorite language, there would be no shortage of libraries and integrations available. But instead, we're stuck with IPCs by marshaling a message, sending it across a tenuous connection and unmarshaling again. It requires the developers to always account for every possible error and introduces security concerns. One could argue that different languages exist in order work better for what their used for, but I see no reason why a single language could not account for 95% of software.

The goal in starting this project is to scrap everything, and start from scratch to create an entire suit of software (and hardware in the future) to replace most computer systems. It should be rock-solid in security and stability (and I'm not just saying that).

Of course, nobody would flat out scrap their digital life to move to Project Asiago, so there are "backwards compatible" packages (Mish Linux, Mish Android) to allow the transition to be easier. This is similar to how the JVM is suppose to be platform independent, but the goal is to create a runtime that works flawlessly across any system. It's inevitable that such a system would be more restricted than your average C++ or Python program, but it's goal is not to be "another" language.

## Projects
Here are all the sub-projects in Project Asiago:
 - [Aura](https://github.com/neonorb/aura) - operating system
 - [Feta](https://github.com/neonorb/feta) - standard library
 - [Danbo](https://github.com/neonorb/danbo) - parser generator
 - [Mish](https://github.com/neonorb/mish) - language library
 - [Mish Linux](https://github.com/neonorb/mish-linux) - Linux base for Mish
 - [Motal](https://github.com/neonorb/motal) - Linux distribution for Mish
 - [Make Base](https://github.com/neonorb/make-base) - shared management/build scripts
 - [Project Asiago](https://github.com/neonorb/project-asiago) - scripts used to build and maintain all these projects

## Getting
See INSTALL.md for installation instructions.

## Contributing
See CONTRIBUTING.md for how to contribute to Project Asiago.

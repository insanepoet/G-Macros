# G - Macros (Lua)
This repository is a place to share some macros for use with Logitech G-Hub with a few of my friends and any random strangers who wander in from the web. None of these macros are going to be "game changing" or "no-recoil" as they are intended to improve quality of life not to "cheat". From time to time macros will be archived, if you find it in the archive folder it is not recommended to be used. 


## Files

Each game profile I upload will have two files :

 1. The **Games** Directory will contain the version most people will care to use
 2. The **Development** Directory contains non-minified versions used to update develop the profiles

**Unless you are planning on modifying the lua you will want to use the version in the Games directory**


## How the hell do i use these?

While I may get around to writing something out eventually there are instructions in the g-hub user manual as well as many youtube videos as well as some websites that detail the process.

## What do they do?

Each **GameTitle**.lua file contains a comment section at the top describing the features the script provides.
Simply open the file on github and you will see it detailed like so:

    -----------------------------------------------------------------------------------
    -- WhateverGame.lua
    -----------------------------------------------------------------------------------
    -- Version: 0.2    <-- if this is less than 1.0 it can and will break
    -- Author: Insanepoet
    -- --------------------------------------------------------------------------------
    -- FEATURE #1 - Awesome thing I do - Mouse Button 4 (Back)
    -- --------------------------------------------------------------------------------
    -- A description of what it is Feature 1 does
    --
    -- How To Use:
    --  A description of how to use the macro script

Different Games will have different features as well as a different number of features.

## Do I have to understand lua?
Lua is a pretty powerful scripting language and while it is certainly not difficult to learn the basics, these scripts will at the most ask you to enter very basic changes that my 5 year old nephew could understand. Why do I think that well let's take a look at an instance where the script may need certain information from you the user and it's listed right in the commented heading below what we discussed right before this.

    -- -------------------------------------------------------------------------------------
    -- USER VARIABLES
    -- ------------------------------------------------------------------------------------- 
    -- Any time you may need to change something about the script you will see this USER
    -- Variables section. The section will explain why you may need to change somthing as
    -- well as describing why i set it at the value it is as default.    
    -- -------------------------------------------------------------------------------------
    local a = 6  -- # of seconds to wait
    -- ^- this is it actual code you may have to change and the only spot you would need to
    -- modify would be the number 6 in this case which would be described in the previous 
    -- paragraph.
    -- -------------------------------------------------------------------------------------
    -- DO NOT EDIT ANYTHING BELOW THIS LINE - THERE BE DRAGONS AHEAD
    -- -------------------------------------------------------------------------------------
Notice that last line about not editing below... yup nothing for you to do any further past that. While there are instances where there may be more than one variable to edit, once you see that line there is nothing left for you to touch. Many of these will be pre-set to a default value that you should never have to change but everyone's setup is different and there's no way of telling if your isp sometimes hits potato speeds.

## What if I have a problem?

First things first, double check that you followed the instructions in the lua file you grabbed. Once you have determined that the problem is in the script feel free to contact me on discord. But wait what if you are a stranger who wandered in here? Well there is the ability to leave an issue at the top of the page and I will attempt to keep an eye out for any issues that may arise with this repo, however i mostly throw these together for myself and my friends and will rarely be looking at this repository. If your issue goes un answered for some time please be patient

## XYZ Macro is cheating or against TOS !?!
While I have my doubts that is the case I am more than willing to archive or remove any macros that can be confirmed by a games developer to be against their TOS. While most online games have a blanket Macros are bad statement in their terms, none of the macros in this repo will provide a player with an advantage other than less eye strain and carpal tunnel from completing repetitive tasks. Most macros here have been timed to complete the task in the same amount of time that I can physically complete the task with randomization thrown in to make it take a little longer.
```

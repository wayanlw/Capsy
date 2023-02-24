# Capsy
## Super efficient keyboard workflow using the underutilized CapsLock key

After using the keyboard for so many years and trying to optimize its use in every possible way, I concluded that the design of the qwerty keyboard is not as efficient as it could be. I got inspired to look for a solution after using the VIM editor, whose philosophy is minimizing hand movements.

To test my hypothesis, I observed my keyboard usage over a month using a keylogger script. I observed frequently used key-combinations and corresponding hand movements. And this uncovered the amount of unnecessary hand movements that we do while using the keyboard for day-to-day work. Almost all the frequently used key combinations required significant hand movement.


| Rank | Key Combination | Hand Movement                                                                                     | Capsy Key binding                                                                                        | Capsy Hand Movement                                 |
| ---- | --------------- | ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| 1    | Alt+tab         | Left hand Left & down to alt key                                                                  | Capslock + z                                                                                             | No Movement                                         |
| 2    | Backspace       | Right hand up to BS key. When used with the mouse have to take the right hand away from the mouse | Capslock + b (For left hand) <br> Capslock + n (For right hand)                                          | No Movement. Can be used with mouse simultaneously. |
| 3    | Esc             | Left hand up and right to ESC                                                                     | Capslock + q                                                                                             | No Movement                                         |
| 5    | Enter           | Minimal                                                                                           | Capslock + c (for left hand) <br> Capslock + / (For right hand) <br> Side Mouse Button (Used with mouse) | No Movement. Can be used with mouse simultaneously. |
| 6    | Arrows          | Right hand right and down to the arrow key area                                                   | Capslock + ijlk                                                                                          | No Movement. Can be used with mouse simultaneously. |
| 7    | Cntrl-v (Paste) | Left hand down and left. One finger to ctrl and the other to v                                    | Capslock + f                                                                                             | No movement                                         |
| 8    | Delete          | Right hand right. When used with the mouse have to take the right hand away from the mouse        | Capslock + v (For left hand) <br> Capslock + , (for right hand)                                          | No movement                                         |
| 9    | Ctrl+c (Copy)   | Left hand down and left. One finger to ctrl and the other to c                                    | Capslock + d                                                                                             | No movement                                         |
| 10   | Ctrl+z (Undo)   | Left hand down and left. One finger to ctrl and the other to z                                    | Capslock + e                                                                                             | No movement                                         |


## Key Features of Capsy

1. Minimizes the hand movements when using the keyboard, placing the most used keys closer to the home row, resulting in significant efficiency gains and reduced hand fatigue/discomfort.
Eg 1. Being a heavy excel user, I use arrow keys all the time. Every time I use them, I have to take my hand away from the home-row of the keyboard which wastes about 1 second each time. If I could save this 1 second every time, imagine the time saving throughout my life. ( In my solution arrow keys are remapped to i(up), j(left), k(down), l(right) when they are pressed whilst holding the caps lock key so that I will never have to move my hand away from the home row)

	> If you're switching between your arrow keys and the alpha keys 1000 times a day, this small improvement alone saves you 4.2 full days a year. (1000 sec x 365 days / 3600 secs per hour / 24 hours per day)

	Eg 2. We frequently use the DELETE, BACKSPACE and ENTER keys, while using the mouse. However, all these three keys are clicked with your right hand. So every time you press these keys you have to switch your right hand between the mouse and the keyboard. What if, these keys can be remapped to your left hand. With Capsy, it is.

2. can be used on any computer, even without administrator privileges, so that I can use this on my work computer. And works across all applications.

3. No impact/conflict with the general keyboard usage

4. optimized for keyboard-mouse parallel use (using the left hand on the keyboard and right hand on the mouse)

5. Light on system resources (very low CPU and memory use and file size)  - With full functionality, the memory footprint of the app is less than 3MB and the file size is less than 1MB.

Has advanced functionalities such as

6. Window management - I don't have to use the mouse to move and place my application windows. It's a single key combination. If you have used Tiling Window Managers such as i3, you know the efficiency gains that this can give. (As shown below)

7. Instant web search - to search google and youtube I don't have to open the browser,  click on the address bar, type the query and then click search. with one key combination, I can search any query. Also, I can search any text selection with a single keystroke.

	Eg. Let's say I need to do a youtube search for the phrase "Keyboard Remapping". with Capsy, I select the phrase, and press my hotkey. It will open a browser window, do a search for "Keyboard Remapping" and present the search results.  (As shown below)

![grab-landing-page](./Assets/WebSearch.gif)


9. Advanced text selection and manipulation - It has the functionality to Select, Copy, Cut or Delete i) Current word, ii)Current line, iii) from the cursor to the beginning/end of line iv) All, duplication the current line with hotkeys. If you're familiar with VIM, you know the efficiency gains that this can give.

10. Control mouse with keyboard- I can control my mouse using the keyboard. This minimizes the switching between the mouse and keyboard
Application Launcher - I have mapped my most used applications to a single key combination.
Number Pad - I have the number-pad layout within my keyboard (Amongst the letter keys), without reaching for the separate numberpad.

11. Special functionality in most used apps - I have separate remapping for Excel, SAP and my browser which are the 3 applications that I use the most.

12. Notetaking. ie. Instantly paste the current selection from any app into any selected app - The use case for this is note-taking. I use MS OneNote and obsidian for my notetaking. ( I take a lot of notes by the way). So with a click of a button, I can copy-paste anything to any app, instantly.  In figure 2 below, I am copying from my browser to OneNote with a single click

![grab-landing-page](./Assets/CopyPaste.gif)

##### Credits & Inspirations
- [VIM](https://www.vim.org/)
- [Daniel Kvarfordt](https://gist.github.com/Danik/5808330)
- [ThatOneCoder](https://github.com/ThatOneCoder/ahk/blob/master/Wynshaft.ahk.txt)
- [Gustavo Duarte](http://duartes.org/gustavo/blog/post/home-row-computing)

This script has saved me a ton of time. I run this on every computer that I use. The size of the program is less than 1 MB and it doesn't require admin privileges.

#### Functionality:
- Deactivates Capslock for normal (accidental) use.
- Use CapsLock and Right-Shift keys as modifier keys
- Hold the Capslock and drag any window with the right mouse button (not just the title bar).
- Access the following functions when pressing Capslock:

**Disclaimer -  Once the combinations get into your muscle memory, the script becomes very addictive. If you are switching computers frequently (Eg. IT support) please be mindful of it.**
## Installation Instructions
1. Download ` Capsy.exe ` on your computer
2. Simply run the program by double-clicking.
3. Doesn't require admin privileges

If you know how to use [Autohotkey](https://www.autohotkey.com/), you can download the script ` Capsy.ahk ` and change it to suit your own needs.

## Usage Instructions

## Toggle Caps lock
CapsLock is deactivated by default. However, if one wants to activate it, can use the below combination to toggle.

| Function            | Hotkey             |
| ------------------- | ------------------ |
| Toggle Capslock key | ` win + Capslock ` |

<br/>

## Main Keybindings

| Function                                 | Hotkey                           | Simulated Keys                                  |
| ---------------------------------------- | -------------------------------- | ----------------------------------------------- |
| Up Arrow                                 | ` Capslock + i `                 | {Up}                                            |
| Left Arrow                               | ` Capslock + j `                 | {Left}                                          |
| Down Arrow                               | ` Capslock + k `                 | {Down}                                          |
| Right Arrow                              | ` Capslock + l `                 | {Right}                                         |
| ---------------------------------------- | -------------------------------- | ----------------------------------------------- |
| Ctrl + Left Arrow                        | ` Capslock + h `                 | {Ctrl}+{Left}                                   |
| Ctrl + Rigth Arrow                       | ` Capslock + ; `                 | {Ctrl}+{Right}                                  |
| ---------------------------------------- | -------------------------------- | ----------------------------------------------- |
| Page Up                                  | ` Capslock + u `                 | {pgUp}                                          |
| Page Down                                | ` Capslock + o `                 | {pgDn}                                          |
| ---------------------------------------- | -------------------------------- | ----------------------------------------------- |
| Home (Go to the beginning of a line)     | ` Capslock + y `                 | {Home}                                          |
| End (Go to the end of a line)            | ` Capslock + p `                 | {End}                                           |
| Go to the beginning of the page          | ` Capslock + 5 `                 | {Ctrl}+{Home}                                   |
| Go to the beginning of the page          | ` Capslock + 6 `                 | {Ctrl}+{End}                                    |

* All navigation keys functions with holding Shift key for Selection/Highlighting.


<br>

## Action Keys

| Function                                                        | Hotkey                           | Simulated Keys                                  |
| --------------------------------------------------------------- | -------------------------------- | ----------------------------------------------- |
| Escape                                                          | ` Capslock + q `                 | {Esc}                                           |
| Enter (Using Left Hand)                                         | ` Capslock + c `                 | {Enter}                                         |
| Delete                                                          | ` Capslock + v `                 | {Delete}                                        |
| BackSpace                                                       | ` Capslock + b `                 | {BS}                                            |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Backspace (Right Hand)                                          | ` Capslock + n `                 | {BS}                                            |
| Backspace preceding word                                        | ` Capslock + m `                 | {Ctrl}+{BS}                                     |
| Delete                                                          | ` Capslock + , `                 | {Delete}                                        |
| Delete the next word                                            | ` Capslock + . `                 | {Ctrl}+{Delete}                                 |
| Enter (Using Right Hand)                                        | ` Capslock + / `                 | {Enter}                                         |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Undo                                                            | ` Capslock + e `                 | {Ctrl}+z                                        |
| Redo                                                            | ` Capslock + r `                 | {Ctrl}+y                                        |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Cut                                                             | ` Capslock + s `                 | {Ctrl}+x                                        |
| Copy                                                            | ` Capslock + d `                 | {Ctrl}+c                                        |
| Paste                                                           | ` Capslock + f `                 | {Ctrl}+v                                        |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Delete Line                                                     | ` Capslock + g `                 | {Home}  {Shift}+{End}  {del}                    |
| Copy Line                                                       | ` Capslock + g (pressed twice) ` | {Home}  {Shift}+{End}  {Ctrl}+c                 |
| Select Line                                                     | ` Capslock + g (hold) `          | {Home}  {Shift}+{End}                           |
| Select and Copy current word                                    | ` capslock + t `                 | {Ctrl}+{Left}  {Shift}+{Ctrl}+{Right}  {Ctrl}+c |
| Delete current word                                             | ` capslock + t (pressed twice) ` | {Ctrl}+{Left}  {Shift}+{Ctrl}+{Right}  {del}+   |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Copy Line                                                       | ` Capslock + g `                 | {Home}  {Shift}+{End}  {Ctrl}+c                 |
| Delete Line                                                     | ` Capslock + g (pressed twice) ` | {Home}  {Shift}+{End}  {del}                    |
| Select Line                                                     | ` Capslock + g (hold) `          | {Home}  {Shift}+{End}                           |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Sorround the selection with curly braces                        | ` Capslock + space + [ `         | Converts xxx in to {xxx}                        |
| Sorround with Parnthesis                                        | ` Capslock + space + ( `         | Converts xxx in to (xxx)                        |
| Sorround with Quotation Marks                                   | ` Capslock + space + ' `         | Converts xxx in to "xxx"                        |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Save                                                            | ` Capslock + a `                 | {Ctrl}+s                                        |
| Save as                                                         | ` Capslock + a (pressed twice) ` | {Ctrl}+{Shift}+s                                |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Cycle open applications                                         | Capslock + z                     | {Alt}+{Tab}                                     |
| ----------------------------------------                        | -------------------------------- | ----------------------------------------------- |
| Find                                                            | Capslock + x                     | {Ctrl}+f                                        |
| Find selection (pastes the current selection to the search box) | Capslock + x (Long press)        | {Ctrl}+c {Ctrl}+f                               |


<br>

## Special Key Combinations

| Function                                            | Hotkey                      | Simulated Keys                                                          |
| --------------------------------------------------- | --------------------------- | ----------------------------------------------------------------------- |
| Shift (Can be used in combinations with other keys) | `Capslock + Tab `           | {Shift}                                                                 |
| ---------------------------                         | --------------------------- | ---------------------------                                             |
| Enter Blank line below                              | `capslock + enter `         | {End}{enter}                                                            |
| Enter Blank line above                              | `capslock + space + enter ` | {Home}{enter}{Up}                                                       |
| ---------------------------                         | --------------------------- | ---------------------------                                             |
| Duplicate the current line                          | `capslock + Home `          | {Home}   {Shift}+{End}  {Ctrl}+c  {End}  {Enter}  {Ctrl}+v  {up}  {End} |
| Duplicate the current line Down                     | `capslock + End`            | {Home}   {Shift}+{End}  {Ctrl}+c  {End}  {Enter} {Ctrl}+v               |
| ---------------------------                         | --------------------------- | ---------------------------                                             |
| Bring the below line to the end of current line     |                             | {End} {Space} {Delete}  {End}                                           |
| Take the current line to the end of line above      |                             | {Home}  {BS}  {Space}  {End}                                            |

<br>

## Launcher

Launcher = `Capslock + w`. The key combination should be Entered immediately after pressing the launcher combination.
| Function        | Hotkey            | Simulated Keys                                  |
| --------------- | ----------------- | ----------------------------------------------- |
| Delete all      | ` Launcher + fa ` | {Ctrl}+a  {Delete}                              |
| Delete to Start | ` Launcher + fs ` | {Shift}+{Home}  {Delete}                        |
| Delete to End   | ` Launcher + fe ` | {Shift}+{End}  {delete}                         |
| copy all        | ` Launcher + da ` | {Ctrl}+a  {Ctrl}+c                              |
| copy to start   | ` Launcher + ds ` | {Shift}+{Home}  {Ctrl}+c                        |
| copy to end     | ` Launcher + de ` | {Shift}+{End}  {Ctrl}+c                         |
| cut all         | ` Launcher + va ` | {Ctrl}+a  {Ctrl}+x                              |
| cut word        | ` Launcher + vw ` | {Ctrl}+{right}  {Shift}+{Ctrl}+{left}  {Ctrl}+x |
| cut line        | ` Launcher + vv ` | {Home}  {Shift}+{End}  {Ctrl}+x                 |
| cut to start    | ` Launcher + vs ` | {Shift}+{Home}  {Ctrl}+x                        |
| cut to end      | ` Launcher + ve ` | {Shift}+{End}{  Ctrl}+x                         |
| Select all      | ` Launcher + sa ` | {Ctrl}+a                                        |
| Select to start | ` Launcher + ss ` | {Shift}+{home}  {Shift}+{home}                  |
| Select to end   | ` Launcher + se ` | {Shift}+{End}  {Shift}+{End}                    |
| Select word     | ` Launcher + sw ` | {Ctrl}+{right}  {Shift}+{Ctrl}+{left}           |

<br>

## Number Row Mappings

| Function                        | Hotkey          | Simulated Keys           |
| ------------------------------- | --------------- | ------------------------ |
| Right Click (Apps key)          | `Capslock + 1`  | Apps Key                 |
| Rename (F2)                     | `Capslock + 2`  | {F2}                     |
| =                               | `Capslock + 3`  | {=}                      |
| Blank                           | `Capslock + 4`  | --                       |
| Go to the beginning of the page | `Capslock + 5`  | {Ctrl}+{Home}            |
| Go to the beginning of the page | `Capslock + 6`  | {Ctrl}+{End}             |
| PageUp                          | `Capslock + 7`  | {PgUp}                   |
| PageDown                        | `Capslock + 8`  | {PgDn}                   |
| Sorround with Paranthesis       | `Capslock + 9`  | Converts xxx in to (xxx) |
| Sorround with Quotes            | `Capslock + 10` | Converts xxx in to "xxx" |



<br>

## Numbers

Insert numbers without reaching the number pad. This becomes more useful if you're using a keyboard without a number pad.

| Function           | Hotkey                         | Simulated Keys |
| ------------------ | ------------------------------ | -------------- |
| 0                  | ` Ctrl + Alt + Shift + Space ` | 0              |
| 1                  | ` Ctrl + Alt + Shift + m `     | 1              |
| 2                  | ` Ctrl + Alt + Shift + , `     | 2              |
| 3                  | ` Ctrl + Alt + Shift + . `     | 3              |
| 4                  | ` Ctrl + Alt + Shift + j `     | 4              |
| 5                  | ` Ctrl + Alt + Shift + k `     | 5              |
| 6                  | ` Ctrl + Alt + Shift + l `     | 6              |
| 7                  | ` Ctrl + Alt + Shift + u `     | 7              |
| 8                  | ` Ctrl + Alt + Shift + i `     | 8              |
| 9                  | ` Ctrl + Alt + Shift + o `     | 9              |
| Multiplication (*) | ` Ctrl + Alt + Shift + [ `     | {*}            |
| Division (/)       | ` Ctrl + Alt + Shift + ] `     | {/}            |
| Subtraction(-)     | ` Ctrl + Alt + Shift + ; `     | {-}            |
| Addition(+)        | ` Ctrl + Alt + Shift + ' `     | {+}            |
| Enter              | ` Ctrl + Alt + Shift + / `     | {Enter}        |
| BackSpace          | ` Ctrl + Alt + Shift + n `     | {BS}           |
| =                  | ` Ctrl + Alt + Shift + h `     | {=}            |

<br>

## Number-Pad Mappings

| Function           | Hotkey                 | Simulated Keys |
| ------------------ | ---------------------- | -------------- |
| Up Arrow           | ` Capslock + 8 `       | {Up}           |
| Left Arrow         | ` Capslock + 4 `       | {Left}         |
| Down Arrow         | ` Capslock + 5 `       | {Down}         |
| Right Arrow        | ` Capslock + 6 `       | {Right}        |
| Ctrl + Up Arrow    | ` Capslock + / `       | {Ctrl}+{Up}    |
| Ctrl + Left Arrow  | ` Capslock + 7 `       | {Ctrl}+{Left}  |
| Ctrl + Down Arrow  | ` Capslock + 2 `       | {Ctrl}+{Down}  |
| Ctrl + Rigth Arrow | ` Capslock + 9 `       | {Ctrl}+{Rigth} |
| BackSpace          | ` Capslock + 1 `       | {BS}           |
| Delete             | ` Capslock + 3 `       | {Delete}       |
| F2                 | ` Capslock + 0 `       | {F2}           |
| +                  | ` Capslock + + `       | {+}            |
| Numlock            | ` Capslock + Numlock ` | {Numlock}      |

<br>

## Searching the Web

| Function                    | Hotkey             |
| --------------------------- | ------------------ |
| Search Web                  | ` Win + s `        |
| Search selection in Web     | ` Win + Ctrl + s ` |
| Search Youtube              | ` Win + y `        |
| Search selection in Youtube | ` Win + Ctrl + y ` |

<br>

## Interact with application windows

| Function                        | Hotkey                                                                                   | Simulated Keys |
| ------------------------------- | ---------------------------------------------------------------------------------------- | -------------- |
| Close tab / instance            | `Alt + q `                                                                               | {Ctrl}+{w}     |
| Exit Current Application        | `Alt + Shift + q `                                                                       | {Alt}+{F4}     |
| Window always on top            | ` Capslock + F12 `                                                                       |                |
| Make Current Window Full Screen | ` Win + Shift + w`                                                                       |                |
| Tile current window left        | ` Win + Shift + e`                                                                       |                |
| Tile current window Right       | ` Win + Shift + r`                                                                       |                |
| Move windows                    | Drag the window from anywhere with the right mouse button whilst holding the Capsloc Key |                |

<br>


## Quick Copy text to a Notepad
| Function                         | Hotkey             |
| -------------------------------- | ------------------ |
| Copy selection to a notepad file | ` Ctrl + Alt + c ` |

<br>

## Microsoft Excel Hotkeys
| Excel Function                              | Hotkey                 | Simulated Keys               |
| ------------------------------------------- | ---------------------- | ---------------------------- |
| Trace Precedents                            | ` Capslock + 1 `       | {Ctrl}[                      |
| Trace Dependants                            | ` Capslock + 2 `       | {F5}{Enter}                  |
| Equals                                      | ` Capslock + 3 `       | {=}                          |
| Plus                                        | ` Capslock + 4 `       | {+}                          |
| Calculate formula inside the cell           | ` Capslock + 5 `       | {F9}                         |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Paste as values                             | ` {Ctrl}+{Alt}+v `     | {Ctrl}+{Alt}+v  {v}  {Enter} |
| Paste forumulas                             | ` {Ctrl}+{Alt}+f `     | {Ctrl}+{Alt}+v  {f}  {Enter} |
| Paste formatting                            | ` {Ctrl}+{Alt}+t `     | {Ctrl}+{Alt}+v  {t}  {Enter} |
| Paste Links                                 | ` {Ctrl}+{Alt}+z `     | {Ctrl}+{Alt}+v  {l}          |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Conditional formatting data bars            | ` {Ctrl}+{Alt}+s `     | {Alt}+H {L} {d} {Enter}      |
| Conditional formatting color scales         | ` {Ctrl}+{Alt}+d `     | {Alt}+H {L} {s} {Enter}      |
| Clear conditional formatting from selection | ` {Ctrl}+{Alt}+x `     | {Alt}+H {L} {c} {s} {Enter}  |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Move to the top cell in range               | ` Capslock + u `       | {Ctrl}+{up}                  |
| Select to the top cell in range             | ` Capslock + Tab + u ` | {Ctrl}+{Shift}+{up}          |
| Move to the bottom cell in Range            | ` Capslock + o `       | {Ctrl}+{Down}                |
| Select to the bottom cell in range          | ` Capslock + Tab + o ` | {Ctrl}+{Shift}+{Down}        |
| Move to the leftmost cell in range          | ` Capslock + h `       | {Ctrl}+{left}                |
| Select to the leftmost cell in range        | ` Capslock + Tab + h ` | {Ctrl}+{Shift}+{left}        |
| Move to the rightmost cell in Range         | ` Capslock + ; `       | {Ctrl}+{right}               |
| Select to the rightmost cell in range       | ` Capslock + Tab + ; ` | {Ctrl}+{Shift}+{right}       |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Go to the previous sheet                    | ` Capslock + [ `       | {Ctrl}+{pgup}                |
| Go to next sheet                            | ` Capslock + ] `       | {Ctrl}+{pgDn}                |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Copy vertically                             | ` Capslock + b `       | {Ctrl}+d                     |
| Copy horizontally                           | ` Capslock + t `       | {Ctrl}+r                     |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Edit in cell                                | ` Capslock + g: `      | {F2}                         |
| ~~~~~~~~~~~~~~~~~~~~~~~~                    | ~~~~~~~~~~~~~~~~       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~  |
| Minus                                       | ` Capslock + F1 `      | {-}                          |
| Plus                                        | ` Capslock + F2 `      | {+}                          |
| Multiply                                    | ` Capslock + F3 `      | {*}                          |
| Divide                                      | ` Capslock + F4 `      | {/}                          |

<br>

## Mouse Movement Hotkeys

| Function                                    | Hotkey                      |
| ------------------------------------------- | --------------------------- |
| move up                                     | RShift + E                  |
| move down                                   | RShift + D                  |
| Move left                                   | RShift + S                  |
| Move right                                  | RShift + F                  |
| Scroll down                                 | RShift + W                  |
| Scroll up                                   | RShift + R                  |
| Left Button                                 | RShift + Space / Rshift + ; |
| Control Left button                         | RShift + '                  |
| ---                                         | ---                         |
| Instantly move the cursor to  Top Left      | RShift + q                  |
| Instantly move the cursor to  Top Right     | RShift + t                  |
| Instantly move the cursor to  Middle Left   | RShift + a                  |
| Instantly move the cursor to  Middle Center | RShift + c                  |
| Instantly move the cursor to  Middle Right  | RShift + g                  |
| Instantly move the cursor to  Bottom Left   | RShift + z                  |
| Instantly move the cursor to  Bottom Right  | RShift + b                  |

## Mapping the Real mouse buttons

These button's are helpful when you're using the keyboard from your lefthand and mouse from your right hand. Enter and Delete keys are used very often in this situation.


| Function     | Shortcut          |
| ------------ | ----------------- |
| Enter        | Side Button Up    |
| Delete       | Side Button Down  |
| Scroll Left  | Mouse wheel left  |
| Scroll right | Mouse wheel Right |

## Exit Capsy
| Function     | Hotkey         |
|--------------|----------------|
| Exit Script  | Right Ctrl + q |


## Accessible-Scratch (a fork of Scratch 2.0 editor and player)
This project is a RIT sponsored research endeavor under the Software Engineering undergraduate research department, which hopes to make the scratch programming tool more accessible. This contains the open source version of Scratch 2.0 and the core code for the official version found on http://scratch.mit.edu. This code has been released under the GPL version 2 license. Forks can be released under the GPL v2 or any later version of the GPL.  

If you're interested in contributing to the original Scratch project, take a look at their repository here: https://github.com/LLK/scratch-flash

### Building (work in progress)
To build the Scratch 2.0 SWF you will need [Ant](http://ant.apache.org/), the [Flex SDK](http://flex.apache.org/) version 4.10+, and [playerglobal.swc files](http://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html#playerglobal) for Flash Player versions 10.2 and 11.4 added to the Flex SDK. Scratch is used in a multitude of settings and some users have older versions of Flash which we try to support (as far back as 10.2).

After downloading ``playerglobal11_4.swc`` and ``playerglobal10_2.swc``, move them to ``<path to flex>/frameworks/libs/player/<version>/playerglobal.swc``. E.g., ``playerglobal11_4.swc`` should be located at ``<path to flex>/frameworks/libs/player/11.4/playerglobal.swc``.

The ``build.properties`` file sets the default location for the Flex SDK. Create a ``local.properties`` file to set the location on your filesystem. Your ``local.properties`` file may look something like this:
```
FLEX_HOME=/home/joe/downloads/flex_sdk_4.11
```
Now you can run Ant ('ant' from the commandline) to build the SWF.

If the source is building but the resulting .swf is producing runtime errors, your first course of action should be to download version 4.11 of the Flex SDK and try targeting that. The Apache foundation maintains an [installer](http://flex.apache.org/installer.html) that lets you select a variety of versions. Newer versions of the SDK will build successfully but are known to cause runtime errors related to the ``flash.display3D.Context3D`` class.


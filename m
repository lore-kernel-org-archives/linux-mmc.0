From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 00/29] mmc: mmcif and tmio regulator and OF support
Date: Thu,  3 May 2012 17:05:29 +0200
Message-ID: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi

I was not directly sure, what was the better way to send these out - as 
one seriess or as several. I would actually prefer several, but there are 
many dependencies. So, maybe best would be to try to review and address 
any issues on the MLs, only posting new versions of affected patches, and 
eventually provide a branch to pull from.

Now to contents:

1. prerequisites: goes on top of

[PATCH 4/6] mmc: sdhi: don't use connection IDs to obtain a clock reference
[PATCH 5/6] mmc: mmcif: don't use connection IDs to obtain a clock reference

http://thread.gmane.org/gmane.linux.ports.sh.devel/14425

[PATCH 0/3] mmc: sh-mmcif: clock management updates         
[PATCH 1/3] mmc: sh_mmcif: simplify and use meaningful label names in error-handling
[PATCH 2/3] mmc: sh_mmcif: fix clock management             
[PATCH 3/3] mmc: sh_mmcif: re-read the clock frequency upon re-enabling

http://thread.gmane.org/gmane.linux.ports.sh.devel/14448

(the following two patches should already be in the MMC tree)

[PATCH] mmc: cd-gpio.c: Include header to pickup exported symbol prototypes

http://www.spinics.net/lists/linux-mmc/msg13823.html

[PATCH] mmc: cd-gpio: allow NULL context in mmc_cd_gpio_free()

http://thread.gmane.org/gmane.linux.kernel.mmc/14103

2. supersede: this series supersedes my earlier patches:

[PATCH/RFC 0/7] mmc: tmio: regulator support, clock management, convert ecovec
[PATCH 1/7] mmc: tmio: stop interface clock before runtime PM suspending
[PATCH 2/7] mmc: tmio: don't needlessly enable interrupts during probing
[PATCH 3/7] mmc: tmio: add callbacks to enable-update and disable the interface clock
[PATCH 4/7] mmc: sdhi: implement tmio-mmc clock enable-update and disable callbacks
[PATCH 5/7] mmc: tmio: add regulator support
[PATCH 6/7] mmc: sdhi: do not install dummy callbacks
[PATCH 7/7] sh: ecovec: switch MMC power control to regulators

http://thread.gmane.org/gmane.linux.ports.sh.devel/14539

[PATCH 0/5] mmc: sh_mmcif: add regulator support
[PATCH 1/5] mmc: sh_mmcif: remove redundant .down_pwr() callback
[PATCH 2/5] sh: ecovec: remove unused .down_pwr() MMCIF callback
[PATCH 3/5] mmc: sh_mmcif: remove unused .down_pwr() callback
[PATCH 4/5] mmc: sh_mmcif: add regulator support
[PATCH/RFC 5/5] sh: ecovec: switch MMC power control to regulator

http://thread.gmane.org/gmane.linux.ports.sh.devel/14469

3. regulators: this series includes a bug-fix:

[PATCH 04/31] regulator: fix devm_regulator_put() to call regulator_put() explicitly

a cosmetic improvement:

[PATCH 05/31] regulator: use IS_ERR_OR_NULL() instead of open-coding

and a feature addition to the regulators framework.

4. mmc: this is where most of the patches fall into. This series includes 
additions and enhancements to the cd-gpio helper, which from now on is 
going to be called "slot-gpio;" a new file drivers/mmc/core/of.c with only 
two functions, so, if preferred, it can be merged into core.c; and 
numerous features, enhancements and improvements to the MMCIF and 
SDHI/TMIO drivers.

The of.c addition is actually pretty important, because it defines an 
external interface: it defines mmc properties, that all mmc host drivers 
will now be able to use, instead of adding new proprietary ones. Drivers, 
that already have OF support cannot stop supporting their interfaces. 
Since we do not want to rewrite .dts filesand break binary compatibility 
with existing platforms, these properties have to be carefully designed.

mmc regulator support: thanks to Mark Brown for comments. This version 
adds a generic mmc function to obtain a "vmmc" regulator for a specific 
mmc interface and now uses the device-managed version of regulator_get().

5. sh patches: 

[PATCH 02/29] sh: ecovec: remove unused .down_pwr() MMCIF callback

If we get an ack for this one, we can pull it together with other 
mmc-related patches via the mmc tree. If not, the following patch

[PATCH 03/29] mmc: sh_mmcif: remove unused .down_pwr() callback

will have to wait until [PATCH 02/29] makes it in.

One more

[PATCH 29/29] sh: ecovec: switch MMC power control to regulators

is optional and mostly is offered as an example of how regulators 
can be used with sh_mmcif and sh_mobile_sdhi.

Thanks
Guennadi

Guennadi Liakhovetski (29):
  mmc: sh_mmcif: remove redundant .down_pwr() callback
  sh: ecovec: remove unused .down_pwr() MMCIF callback
  mmc: sh_mmcif: remove unused .down_pwr() callback
  regulator: fix devm_regulator_put() to call regulator_put()
    explicitly
  regulator: use IS_ERR_OR_NULL() instead of open-coding
  regulator: export a function to check if regulator can change status
  mmc: add a function to get a regulator, supplying card's Vdd
  mmc: sh_mmcif: add regulator support
  mmc: tmio: stop interface clock before runtime PM suspending
  mmc: tmio: don't needlessly enable interrupts during probing
  mmc: tmio: add callbacks to enable-update and disable the interface
    clock
  mmc: sdhi: implement tmio-mmc clock enable-update and disable
    callbacks
  mmc: tmio: add regulator support
  mmc: sdhi: do not install dummy callbacks
  mmc: extend and rename cd-gpio helpers to handle more slot GPIO
    functions
  mmc: tmio: use MMC opcode defines instead of numbers
  mmc: use a more generic name for slot function types and fields
  mmc: tmio: remove a duplicated comment line
  mmc: add two capability flags for CD and WP signal polarity
  mmc: add CD GPIO polling support to slot functions
  mmc: convert slot functions to managed allocation
  mmc: add WP pin handler to slot functions
  mmc: tmio: use generic GPIO CD and WP handlers
  mmc: add a simple generic OF parser
  mmc: tmio: add OF support
  mmc: sdhi: add OF support, make platform data optional
  mmc: mmcif: add OF support
  mmc: mmcif: add support for generic GPIO CD polling
  sh: ecovec: switch MMC power control to regulators

 arch/sh/boards/mach-ecovec24/setup.c |   91 ++++++++++++------
 drivers/mmc/core/Makefile            |    4 +-
 drivers/mmc/core/cd-gpio.c           |   83 ----------------
 drivers/mmc/core/core.c              |   27 +++++
 drivers/mmc/core/host.c              |    4 +
 drivers/mmc/core/of.c                |   91 ++++++++++++++++++
 drivers/mmc/core/slot-gpio.c         |  175 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c          |   83 ++++++++++++++---
 drivers/mmc/host/sh_mobile_sdhi.c    |   56 ++++++++---
 drivers/mmc/host/tmio_mmc.h          |    2 +
 drivers/mmc/host/tmio_mmc_pio.c      |  159 +++++++++++++++++++++++++------
 drivers/regulator/core.c             |   20 ++++-
 include/linux/mfd/tmio.h             |    3 +
 include/linux/mmc/cd-gpio.h          |   18 ----
 include/linux/mmc/host.h             |   39 +++++++-
 include/linux/mmc/sh_mmcif.h         |    1 -
 include/linux/mmc/slot-gpio.h        |   24 +++++
 include/linux/regulator/consumer.h   |    7 ++
 18 files changed, 694 insertions(+), 193 deletions(-)
 delete mode 100644 drivers/mmc/core/cd-gpio.c
 create mode 100644 drivers/mmc/core/of.c
 create mode 100644 drivers/mmc/core/slot-gpio.c
 delete mode 100644 include/linux/mmc/cd-gpio.h
 create mode 100644 include/linux/mmc/slot-gpio.h

-- 
1.7.2.5


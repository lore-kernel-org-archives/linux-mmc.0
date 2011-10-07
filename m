From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 0/5] Driver Probe Deferral Mechanism
Date: Fri, 07 Oct 2011 10:05:22 +0500
Message-ID: <1317962127-29003-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org


Original patch posted at:
http://comments.gmane.org/gmane.linux.kernel/1194346

Enhancements done to above patch:
 - checkpatch warning fixes
 - added Kconfig symbol CONFIG_PROBE_DEFER
 - replacing normal workqueue with singlethread_workqueue
 - handling -EPROBE_DEFER error

Apart from that, OMAP HSMMC and GPIO drivers are adopted to use
deferral probe mechanism and successfully tested on omap3 beagle
board.

Applies cleanly on top of v3.1-rc8

G, Manjunath Kondaiah (3):
  drivercore: add new error value for deferred probe
  gpiolib: handle deferral probe error
  omap: hsmmc: use platform_driver_register

Grant Likely (1):
  drivercore: Add driver probe deferral mechanism

Mark Brown (1):
  regulator: Support driver probe deferral

 drivers/base/Kconfig          |   11 +++
 drivers/base/base.h           |    3 +
 drivers/base/core.c           |    6 ++
 drivers/base/dd.c             |  145 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c        |    6 +-
 drivers/mmc/host/omap_hsmmc.c |    7 +-
 drivers/regulator/core.c      |    4 +-
 include/linux/device.h        |    7 ++
 include/linux/errno.h         |    1 +
 9 files changed, 183 insertions(+), 7 deletions(-)

-- 
Cc: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: Dilan Lee <dilee@nvidia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>

1.7.4.1


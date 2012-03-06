From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move the
 header file
Date: Tue, 06 Mar 2012 15:17:20 +0900
Message-ID: <4F55ABF0.1060801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patchset is the purpose for using sdhci-pltfm.c and 
removing the arch dependency.
The sdhci-s3c has too heavy arch dependency.
For example, if work for sdhci-s3c.c at mmc-tree, sometime need to change sdhci.h for Samsung-Soc.
But now we need to work at both mmc-next tree and Samsung-SoC tree.
I think this is very inefficient and can conflict to merge.
So remained at least dependency and moved the header file to mmc folder.

And sdhci-s3c changed to use the sdhci-pltfm.c.
There is no reason that didn't use the sdhci-pltfm.c.
If we use the sdhci-pltfm.c,we can easily maintain the common part.

In future, i will work more removing the arch dependency.

This patchset based on mmc-next tree.

Changelog v3:
	- Modify mmc/host/Makefile for sdhci-s3c.c
	- remove unnecessary code

Changelog V2:
	- modified driver/mmc/host/Kconfig
	- Add the comments for s3c64xx
	- based-on latest mmc-tree. 


Jaehoon Chung (4):
  mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
  ARM: SAMSUNG: move the sdhci header file to driver directory
  mmc: sdhci-s3c: use the sdhci-s3c.h instead of regs-sdhci.h
  ARM: SAMSUNG: move the mmc platdata header file into linux/mmc/

 arch/arm/mach-exynos/setup-sdhci-gpio.c         |    1 -
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c        |    1 -
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c        |    1 -
 arch/arm/plat-samsung/include/plat/regs-sdhci.h |   87 --------
 arch/arm/plat-samsung/include/plat/sdhci.h      |   53 +-----
 drivers/mmc/host/Kconfig                        |   20 +-
 drivers/mmc/host/Makefile                       |    2 +-
 drivers/mmc/host/sdhci-s3c.c                    |  265 ++++++++---------------
 drivers/mmc/host/sdhci-s3c.h                    |   89 ++++++++
 include/linux/mmc/sdhci-s3c.h                   |   84 +++++++
 10 files changed, 273 insertions(+), 330 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-s3c.h
 create mode 100644 include/linux/mmc/sdhci-s3c.h

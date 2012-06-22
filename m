From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/9 v4] mmc: cd-gpio: extend to handle more slot functions
Date: Fri, 22 Jun 2012 15:23:13 +0200
Message-ID: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

This patch series extends the cd-gpio helper module to handle further common 
slot functions, often implemented using GPIOs: CD polling and WP. It 
supersedes patches 1-8 and 10/10 from

http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus=14644

Patch 9/10 from it is not needed any more, because the default polarity of 
CD and RO GPIOs is now active low, which is also what is used by all 
initial users. This makes updating them unnecessary and allows us to apply 
patch 10/10 (which now becomes 9/9) immediately without first having to 
wait for platform updates.

Thanks
Guennadi

Guennadi Liakhovetski (9):
  mmc: extend and rename cd-gpio helpers to handle more slot GPIO
    functions
  mmc: use a more generic name for slot function types and fields
  mmc: add two capability flags for CD and WP signal polarity
  mmc: add CD GPIO polling support to slot functions
  mmc: convert slot functions to managed allocation
  mmc: add WP pin handler to slot functions
  mmc: tmio: support caps2 flags
  mmc: sh_mobile_sdhi: support caps2 flags
  mmc: tmio: use generic GPIO CD and WP handlers

 drivers/mmc/core/Makefile          |    2 +-
 drivers/mmc/core/cd-gpio.c         |   83 ----------------
 drivers/mmc/core/host.c            |    4 +
 drivers/mmc/core/slot-gpio.c       |  188 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sh_mobile_sdhi.c  |    1 +
 drivers/mmc/host/tmio_mmc_pio.c    |   13 ++-
 include/linux/mfd/tmio.h           |    1 +
 include/linux/mmc/cd-gpio.h        |   18 ----
 include/linux/mmc/host.h           |   22 ++++-
 include/linux/mmc/sh_mobile_sdhi.h |    1 +
 include/linux/mmc/slot-gpio.h      |   24 +++++
 11 files changed, 249 insertions(+), 108 deletions(-)
 delete mode 100644 drivers/mmc/core/cd-gpio.c
 create mode 100644 drivers/mmc/core/slot-gpio.c
 delete mode 100644 include/linux/mmc/cd-gpio.h
 create mode 100644 include/linux/mmc/slot-gpio.h

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

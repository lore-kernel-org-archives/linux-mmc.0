From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v5 0/3] mmc: omap_hsmmc: enable SDIO IRQ.
Date: Tue,  3 Dec 2013 00:21:49 +0100
Message-ID: <1386026512-23446-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

v5:
- fix compile error introduced by last minute fix

v4:
- switch to interrupts-extended format
- drop ti,swakeup-missing flag convert to comaptible section

v3:
- removed gpio_irq from platform_data

v2:
- incorparated changes as suggested by reviewers
- simplified workaround for am335x, gpio will now only wake
  the module from runtime suspend, not handle the sdio irq
  itself 

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ.
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x.
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 ++++
 drivers/mmc/host/omap_hsmmc.c                      |  305 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 332 insertions(+), 24 deletions(-)

-- 
1.7.10.4


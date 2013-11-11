From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Mon, 11 Nov 2013 21:06:42 +0100
Message-ID: <1384200405-8402-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This a resend:
- incorparated changes as suggested by reviewers
- simplified workaround for am335x, gpio will now only wake
  the module from runtime suspend, not handle the sdio irq
  itself 

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ.
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x.
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 +++
 drivers/mmc/host/omap_hsmmc.c                      |  299 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    4 +
 3 files changed, 325 insertions(+), 20 deletions(-)

-- 
1.7.10.4


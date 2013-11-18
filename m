From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Mon, 18 Nov 2013 08:53:57 +0100
Message-ID: <1384761240-11005-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This a resend:
- no spin_lock during register access in pm_runtime suspend/resume
- reworked GPIO enable / disable logic, also suspend/resume

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO IRQ.
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x.
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 +++
 drivers/mmc/host/omap_hsmmc.c                      |  295 ++++++++++++++++++--
 include/linux/platform_data/mmc-omap.h             |    4 +
 3 files changed, 321 insertions(+), 20 deletions(-)

-- 
1.7.10.4


From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/9] mmc: omap_hsmmc: convert to use devm_* and enable sdio irq
Date: Fri, 21 Mar 2014 21:47:29 +0530
Message-ID: <1395418658-2375-1-git-send-email-balajitk@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Andreas Fenkart (3):
  mmc: omap_hsmmc: Enable SDIO interrupt
  mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on
    AM335x
  mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux

Balaji T K (6):
  mmc: omap_hsmmc: use devm_clk_get
  mmc: omap_hsmmc: use devm_request_irq
  mmc: omap_hsmmc: use devm_request_threaded_irq
  mmc: omap_hsmmc: use devm_request_mem_region
  mmc: omap_hsmmc: use devm_ioremap
  mmc: omap_hsmmc: enable wakeup event for sdio

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 +++
 drivers/mmc/host/omap_hsmmc.c                      |  349 +++++++++++++++++---
 include/linux/platform_data/mmc-omap.h             |    1 +
 3 files changed, 346 insertions(+), 54 deletions(-)

-- 
1.7.5.4


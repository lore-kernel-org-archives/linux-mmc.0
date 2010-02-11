From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] [U300] Add MMCI DMA platform config
Date: Thu, 11 Feb 2010 16:16:02 +0100
Message-ID: <1265901362-4104-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:58015 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753054Ab0BKPvt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2010 10:51:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@stericsson.com>, Dan Williams <dan.j.williams@intel.com>

This adds the platform configuration necessary to
get DMA on the U300 MMCI block.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/mach-u300/mmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 109f5a6..a02d17c 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -19,7 +19,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/dmaengine.h>
 #include <linux/amba/mmci.h>
+#include <mach/coh901318.h>
+#include <mach/dma_channels.h>
 
 #include "mmc.h"
 #include "padmux.h"
@@ -106,6 +109,12 @@ int __devinit mmc_init(struct amba_device *adev)
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
 	mmci_card->mmc0_plat_data.capabilities = MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA;
+#ifdef CONFIG_DMA_ENGINE
+	mmci_card->mmc0_plat_data.dma_filter = coh901318_filter_id;
+	mmci_card->mmc0_plat_data.dma_rx_param =
+		(void *) U300_DMA_MMCSD_RX_TX;
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 
 	mmcsd_device->platform_data = (void *) &mmci_card->mmc0_plat_data;
 
-- 
1.6.3.3


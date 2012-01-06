From: <r66093@freescale.com>
Subject: [PATCH 1/5 v2] ESDHC: add PIO mode support
Date: Fri, 6 Jan 2012 13:33:13 +0800
Message-ID: <1325827997-27490-2-git-send-email-r66093@freescale.com>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:17081
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464Ab2AFGYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2012 01:24:04 -0500
In-Reply-To: <1325827997-27490-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not work on
DMA mode because of the hardware bug, so we set a broken dma flag and use
PIO mode.

Signed-off-by: Gao Guanhua <B22826@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- change the property to compatible for quirks

 drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a9e12ea..ba36c36 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -2,7 +2,7 @@
  * sdhci-pltfm.c Support for SDHCI platform devices
  * Copyright (c) 2009 Intel Corporation
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -71,6 +71,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (sdhci_of_wp_inverted(np))
 			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
-- 
1.7.5.4



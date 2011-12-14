From: <r66093@freescale.com>
Subject: [PATCH 1/6] ESDHC: add PIO mode support
Date: Wed, 14 Dec 2011 10:19:37 +0800
Message-ID: <1323829182-1551-2-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:46088 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab1LNDFo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:05:44 -0500
Received: from mail192-tx2 (localhost [127.0.0.1])	by
 mail192-tx2-R.bigfish.com (Postfix) with ESMTP id 527BC200089	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:46 +0000 (UTC)
Received: from TX2EHSMHS021.bigfish.com (unknown [10.9.14.241])	by
 mail192-tx2.bigfish.com (Postfix) with ESMTP id 0D8023A0044	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:46 +0000 (UTC)
In-Reply-To: <1323829182-1551-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For some FSL ESDHC controller(e.g. P2020E, Rev1.0), the SDHC can not work on
DMA mode because of the hardware bug, so we set a broken dma flag and use
PIO mode.

Signed-off-by: Gao Guanhua <B22826@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a9e12ea..2a77435 100644
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
 
+		if (of_get_property(np, "sdhci,dma-broken", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
-- 
1.7.5.4



From: <r66093@freescale.com>
Subject: [PATCH 2/4 v3] ESDHC: set the timeout to the max value
Date: Mon, 16 Jan 2012 14:13:04 +0800
Message-ID: <1326694386-28820-3-git-send-email-r66093@freescale.com>
References: <1326694386-28820-1-git-send-email-r66093@freescale.com>
 <1326694386-28820-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:18630
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740Ab2APGKx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 01:10:53 -0500
In-Reply-To: <1326694386-28820-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>, Xie Xiaobo <X.Xie@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When access the card on some FSL platform board (e.g p2020, p1010, mpc8536),
the following error is reported with the timeout value calculated:

mmc0: Got data interrupt 0x00000020 even though no data operation was
in progress.
mmc0: Got data interrupt 0x00000020 even though no data operation was
in progress.

So we skip the calculation of timeout and use the max value to fix it.

Signed-off-by: Gao Guanhua <B22826@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v2:
	- change the property to compatible for quirks
changes for v3:
	- add the Acked-by

 drivers/mmc/host/sdhci-pltfm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 67b9ab0..04fa130 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -74,6 +74,13 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_device_is_compatible(np, "fsl,p2020-esdhc")
+				|| of_device_is_compatible(np,
+					"fsl,p1010-esdhc")
+				|| of_device_is_compatible(np,
+					"fsl,mpc8536-esdhc"))
+			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
-- 
1.7.5.4



From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Fri, 8 Mar 2013 16:14:10 +0800
Message-ID: <1362730450-24254-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:15455
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753451Ab3CHI0M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Mar 2013 03:26:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Chunhe Lan <Chunhe.Lan@freescale.com>

This patch fixes timeout problems on t4240's sdhci controller:

	mmc0: Too large timeout requested for CMD25!
	mmc0: Too large timeout requested for CMD25!
	mmc0: Too large timeout requested for CMD25!

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pltfm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3145a78..9db7b12 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-- 
1.7.6.5



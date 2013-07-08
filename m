From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Date: Mon, 8 Jul 2013 15:16:04 +0800
Message-ID: <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:28601
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab3GHIF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 04:05:58 -0400
In-Reply-To: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

On T4240QDS board controllers has an unusable ADMA engine, so use SDMA instead.
Also 3.0v is support on T4240QDS board even if the capacity detailed only 1.8v
support. Without this quirk SD card will declare voltage not support and

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for v2:
	- Change the compatible for t4240qds board

 drivers/mmc/host/sdhci-pltfm.c | 7 ++++++-
 drivers/mmc/host/sdhci.c       | 3 +++
 include/linux/mmc/sdhci.h      | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..800e82f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -92,9 +92,14 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_device_is_compatible(np, "fsl,t4240qds-esdhc")) {
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+			host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30;
+		}
+
 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
+		    of_device_is_compatible(np, "fsl,t4240qds-esdhc") ||
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..de7fa81 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2797,6 +2797,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->caps1 :
 			sdhci_readl(host, SDHCI_CAPABILITIES_1);
 
+	if (host->quirks2 & SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30)
+		caps[0] = caps[0] | SDHCI_CAN_VDD_300;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..dc608d7 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+/* The host support VS300 even if the capacity detailed not */
+#define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30		(1<<6)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.0



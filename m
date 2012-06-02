From: philipspatches@gmail.com
Subject: [PATCH] mmc: sdhci:  Allow CAPABILITY_1 Register to be overridden
Date: Sat,  2 Jun 2012 13:30:06 -0700
Message-ID: <1338669006-2611-1-git-send-email-prakity@marvell.com>
References: <prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50093 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759613Ab2FBUaO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jun 2012 16:30:14 -0400
Received: by pbbrp8 with SMTP id rp8so4369970pbb.19
        for <linux-mmc@vger.kernel.org>; Sat, 02 Jun 2012 13:30:13 -0700 (PDT)
In-Reply-To: <prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

CAPABILITY_1 can be changed by the platform code using a quirk
CAPALBILTY_2 should also be allowed to be redefined.

This is useful if UHS or other modes are not supported that
are defined in the the register but the platform code has
specific information that these value should be changed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |    7 +++++--
 include/linux/mmc/sdhci.h |    4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e626732..0fec448 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2614,8 +2614,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
 
-	caps[1] = (host->version >= SDHCI_SPEC_300) ?
-		sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
+	if (host->version >= SDHCI_SPEC_300) {
+		caps[1] = (host->quirks & SDHCI_QUIRK2_MISSING_CAPS1) ?
+		host->caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	} else
+		caps[1] = 0;
 
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e9051e1..560fe22 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,7 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
+#define SDHCI_QUIRK2_MISSING_CAPS1			(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -155,7 +156,8 @@ struct sdhci_host {
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-	unsigned int caps;	/* Alternative capabilities */
+	unsigned int caps;	/* replace capability register 1 */
+	unsigned int caps1;	/* replace capability register 2 */
 
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
-- 
1.7.0.4


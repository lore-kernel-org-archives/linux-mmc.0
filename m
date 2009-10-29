From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.
Date: Thu, 29 Oct 2009 16:42:05 +0900
Message-ID: <1256802125-27536-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:52717 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZJ2HmF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2009 03:42:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sdhci-devel@lists.ossman.eu
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, Thomas Abraham <thomas.ab@samsung.com>

The s3c6410 sdhci controller does not support the 'End' attribute and
NOP attribute in the same 8-Byte ADMA descriptor. This patch adds a
new quirk to identify sdhci host contollers with such behaviour.
In addition to this, for controllers using the new quirk, the last
entry in the ADMA descritor table is marked with the 'End' attribute
(instead of using a NOP descriptor with 'End' attribute).

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/mmc/host/sdhci.c |   35 ++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fc96f8c..27a3447 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -487,19 +487,28 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
 	}
 
-	/*
-	 * Add a terminating entry.
-	 */
-	desc[7] = 0;
-	desc[6] = 0;
-	desc[5] = 0;
-	desc[4] = 0;
-
-	desc[3] = 0;
-	desc[2] = 0;
-
-	desc[1] = 0x00;
-	desc[0] = 0x03; /* nop, end, valid */
+	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
+		/*
+		* Mark the last descriptor as the terminating descriptor
+		*/
+		if (desc != host->adma_desc) {
+			desc -= 8;
+			desc[0] |= 0x2; /* end */
+		}
+	} else {
+		/*
+		* Add a terminating entry.
+		*/
+		desc[7] = 0;
+		desc[6] = 0;
+		desc[5] = 0;
+		desc[4] = 0;
+
+		desc[3] = 0;
+		desc[2] = 0;
+		desc[1] = 0x00;
+		desc[0] = 0x03; /* nop, end, valid */
+	}
 
 	/*
 	 * Resync align buffer as we might have changed it.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c77e9ff..e954116 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -232,6 +232,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+/* Controller cannot support End Attribute in NOP ADMA descriptor */
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<24)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.3.4


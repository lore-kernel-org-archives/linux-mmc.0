From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 1/3] s3c6410: Add new quirk in sdhci driver and update ADMA
 descriptor build.
Date: Tue, 04 May 2010 11:43:22 +0200
Message-ID: <4BDFEC3A.9060501@gmail.com>
References: <cover.1272966142.git.mcuelenaere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:38373 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab0EDJnY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 05:43:24 -0400
In-Reply-To: <cover.1272966142.git.mcuelenaere@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, pierre@ossman.eu, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, sdhci-devel@lists.ossman.eu
Cc: ben-linux@fluff.org, thomas.ab@samsung.com

The s3c6410 sdhci controller does not support the 'End' attribute and
NOP attribute in the same 8-Byte ADMA descriptor. This patch adds a
new quirk to identify sdhci host contollers with such behaviour.
In addition to this, for controllers using the new quirk, the last
entry in the ADMA descritor table is marked with the 'End' attribute
(instead of using a NOP descriptor with 'End' attribute).

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/mmc/host/sdhci.c |   20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d4fdfa..db5d566 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -496,12 +496,22 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
 	}
 
-	/*
-	 * Add a terminating entry.
-	 */
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
 
-	/* nop, end, valid */
-	sdhci_set_adma_desc(desc, 0, 0, 0x3);
+		/* nop, end, valid */
+		sdhci_set_adma_desc(desc, 0, 0, 0x3);
+	}
 
 	/*
 	 * Resync align buffer as we might have changed it.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..7ba0006 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -236,6 +236,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+/* Controller cannot support End Attribute in NOP ADMA descriptor */
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<25)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.7.1



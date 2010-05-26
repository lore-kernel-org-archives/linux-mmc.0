From: akpm@linux-foundation.org
Subject: [patch 014/203] mmc: s3c6410: add new quirk in sdhci driver and update ADMA descriptor build
Date: Wed, 26 May 2010 14:42:04 -0700
Message-ID: <201005262142.o4QLg4Bf015359@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44475 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754866Ab0EZWCn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:02:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, thomas.ab@samsung.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org, mcuelenaere@gmail.com

From: Thomas Abraham <thomas.ab@samsung.com>

The s3c6410 sdhci controller does not support the 'End' attribute and NOP
attribute in the same 8-Byte ADMA descriptor.  This patch adds a new quirk
to identify sdhci host contollers with such behaviour.  In addition to
this, for controllers using the new quirk, the last entry in the ADMA
descritor table is marked with the 'End' attribute (instead of using a NOP
descriptor with 'End' attribute).

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |   20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff -puN drivers/mmc/host/sdhci.c~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build
+++ a/drivers/mmc/host/sdhci.c
@@ -496,12 +496,22 @@ static int sdhci_adma_table_pre(struct s
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
diff -puN drivers/mmc/host/sdhci.h~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~s3c6410-add-new-quirk-in-sdhci-driver-and-update-adma-descriptor-build
+++ a/drivers/mmc/host/sdhci.h
@@ -238,6 +238,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
 /* Controller reports wrong base clock capability */
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
+/* Controller cannot support End Attribute in NOP ADMA descriptor */
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
_

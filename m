From: akpm@linux-foundation.org
Subject: [patch 054/177] sdhci: add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 18:01:59 -0700
Message-ID: <201008110102.o7B11xUH027109@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44332 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757308Ab0HKB3B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:29:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, Chang-Ming.Huang@freescale.com, benh@kernel.crashing.org, galak@gate.crashing.org, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, tie-fei.zang@freescale.com

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add auto CMD12 command support for eSDHC driver.  This is needed by P4080
and P1022 for block read/write.  Manual asynchronous CMD12 abort operation
causes protocol violations on these silicons.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-of-core.c |    4 ++++
 drivers/mmc/host/sdhci.c         |   14 ++++++++++++--
 drivers/mmc/host/sdhci.h         |    2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/sdhci-of-core.c~sdhci-add-auto-cmd12-support-for-esdhc-driver drivers/mmc/host/sdhci-of-core.c
--- a/drivers/mmc/host/sdhci-of-core.c~sdhci-add-auto-cmd12-support-for-esdhc-driver
+++ a/drivers/mmc/host/sdhci-of-core.c
@@ -154,6 +154,10 @@ static int __devinit sdhci_of_probe(stru
 		host->ops = &sdhci_of_data->ops;
 	}
 
+	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
diff -puN drivers/mmc/host/sdhci.c~sdhci-add-auto-cmd12-support-for-esdhc-driver drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-add-auto-cmd12-support-for-esdhc-driver
+++ a/drivers/mmc/host/sdhci.c
@@ -818,8 +818,12 @@ static void sdhci_set_transfer_mode(stru
 	WARN_ON(!host->data);
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
-	if (data->blocks > 1)
-		mode |= SDHCI_TRNS_MULTI;
+	if (data->blocks > 1) {
+		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
+		else
+			mode |= SDHCI_TRNS_MULTI;
+	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
 	if (host->flags & SDHCI_REQ_USE_DMA)
@@ -1109,6 +1113,12 @@ static void sdhci_request(struct mmc_hos
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
 #endif
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
+		if (mrq->stop) {
+			mrq->data->stop = NULL;
+			mrq->stop = NULL;
+		}
+	}
 
 	host->mrq = mrq;
 
diff -puN drivers/mmc/host/sdhci.h~sdhci-add-auto-cmd12-support-for-esdhc-driver drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-add-auto-cmd12-support-for-esdhc-driver
+++ a/drivers/mmc/host/sdhci.h
@@ -243,6 +243,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller is missing device caps. Use caps provided by host */
 #define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
+/* Controller uses Auto CMD12 command to stop the transfer */
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
_

From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Tue, 26 Apr 2011 21:10:35 -0500
Message-ID: <1303870235-29041-6-git-send-email-andreiw@motorola.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
 <1303870235-29041-4-git-send-email-andreiw@motorola.com>
 <1303870235-29041-5-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:42756 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab1D0CLQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 22:11:16 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R2BfAU000217
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:11:41 -0400 (EDT)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R2BfwZ000206
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 22:11:41 -0400 (EDT)
Received: by ywh1 with SMTP id 1so640391ywh.15
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 19:11:13 -0700 (PDT)
In-Reply-To: <1303870235-29041-5-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, subhashj@codeaurora.org

Enables Auto-CMD23 support where available (SDHCI 3.0 controllers)

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Cc: subhashj@codeaurora.org
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c  |   17 ++++++++++++++++-
 drivers/mmc/host/sdhci.h  |    2 ++
 include/linux/mmc/sdhci.h |    1 +
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 41c987d..bf9aedb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -844,7 +844,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		if (!host->mrq->sbc &&
 		    host->flags & SDHCI_ACMD12)
 			mode |= SDHCI_TRNS_ACMD12;
+		else if (host->mrq->sbc &&
+			 host->flags & SDHCI_ACMD23) {
+			mode |= SDHCI_TRNS_ACMD23;
+			sdhci_writel(host, host->mrq->sbc->arg, SDHCI_ARGUMENT2);
+		}
 	}
+
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
 	if (host->flags & SDHCI_REQ_USE_DMA)
@@ -1189,7 +1195,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		tasklet_schedule(&host->finish_tasklet);
 	} else {
 
-		if (mrq->sbc)
+		if (mrq->sbc && !(host->flags & SDHCI_ACMD23))
 			sdhci_send_command(host, mrq->sbc);
 		else
 			sdhci_send_command(host, mrq->cmd);
@@ -1947,6 +1953,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_ACMD12;
 
+	/* Auto-CMD23 stuff only works in ADMA or PIO. */
+	if ((host->version == SDHCI_SPEC_300) &&
+	    ((host->flags & SDHCI_USE_ADMA) ||
+	     !(host->flags & SDHCI_REQ_USE_DMA))) {
+		host->flags |= SDHCI_ACMD23;
+		printk(KERN_INFO "%s: Auto-CMD23 available\n", mmc_hostname(mmc));
+	} else
+		printk(KERN_INFO "%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
+
 	/*
 	 * A controller may support 8-bit width, but the board itself
 	 * might not have the pins brought out.  Boards that support
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 85750a9..2b3fb76 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -25,6 +25,7 @@
  */
 
 #define SDHCI_DMA_ADDRESS	0x00
+#define SDHCI_ARGUMENT2		0x00
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
@@ -37,6 +38,7 @@
 #define  SDHCI_TRNS_DMA		0x01
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
 #define  SDHCI_TRNS_ACMD12	0x04
+#define  SDHCI_TRNS_ACMD23	0x08
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index c54ac14..d91585a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -110,6 +110,7 @@ struct sdhci_host {
 #define SDHCI_REQ_USE_DMA	(1<<2)	/* Use DMA for this req. */
 #define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
 #define SDHCI_ACMD12		(1<<4)	/* Auto CMD12 support */
+#define SDHCI_ACMD23		(1<<5)	/* Auto CMD23 support */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.0.4


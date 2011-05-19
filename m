From: Andrei Warkentin <andreiw@motorola.com>
Subject: [v5 5/5] MMC: SDHCI AutoCMD23 support.
Date: Thu, 19 May 2011 16:46:30 -0500
Message-ID: <1305841590-26963-6-git-send-email-andreiw@motorola.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:37557 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892Ab1ESVM5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 17:12:57 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JLAarH001307
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:10:36 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4JLAZbk001278
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:10:36 -0400 (EDT)
Received: by gwb17 with SMTP id 17so1482237gwb.15
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 14:12:55 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, arnd@arndb.de, subhashj@codeaurora.org, malchev@google.com

Enables Auto-CMD23 support where available (SDHCI 3.0 controllers)

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Cc: subhashj@codeaurora.org
Cc: malchev@google.com
Tested-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c  |   17 ++++++++++++++++-
 drivers/mmc/host/sdhci.h  |    2 ++
 include/linux/mmc/sdhci.h |    1 +
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1138b55..d79b2d0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -860,7 +860,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
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
@@ -1255,7 +1261,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			host->mrq = mrq;
 		}
 
-		if (mrq->sbc)
+		if (mrq->sbc && !(host->flags & SDHCI_ACMD23))
 			sdhci_send_command(host, mrq->sbc);
 		else
 			sdhci_send_command(host, mrq->cmd);
@@ -2491,6 +2497,15 @@ int sdhci_add_host(struct sdhci_host *host)
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
index 7e28eec..713caf0 100644
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
index d70de9d..d0db8ae 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -114,6 +114,7 @@ struct sdhci_host {
 #define SDHCI_SDR50_NEEDS_TUNING (1<<4)	/* SDR50 needs tuning */
 #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
 #define SDHCI_ACMD12		(1<<6)	/* Auto CMD12 support */
+#define SDHCI_ACMD23		(1<<7)	/* Auto CMD23 support */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.0.4


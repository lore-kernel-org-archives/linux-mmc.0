From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/4] mmc:sdhc: get voltage from sdhc host
Date: Mon, 26 Aug 2013 09:19:23 +0800
Message-ID: <1377479965-471-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:22381
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab3HZBVX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Aug 2013 21:21:23 -0400
In-Reply-To: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, galak@kernel.crashing.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

We use host->ocr_mask to hold the voltage get from device-tree
node, In case host->ocr_mask was available, we use host->ocr_mask
as the final available voltage can be used by MMC/SD/SDIO card.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Reviewed-by: Anton Vorontsov <anton@enomsg.org>
---
 drivers/mmc/host/sdhci.c  | 3 +++
 include/linux/mmc/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..57541e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3119,6 +3119,9 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
+	if (host->ocr_mask)
+		ocr_avail = host->ocr_mask;
+
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..3e781b8 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -171,6 +171,7 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
+	u32 ocr_mask;		/* available voltages */
 
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
-- 
1.8.0



From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/13] mmc: core: Rename max_discard_to to max_busy_timeout
Date: Wed, 29 Jan 2014 23:37:53 +0100
Message-ID: <1391035085-2747-2-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:48496 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaA2WiP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:15 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so1997911lbd.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:13 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Rename host->max_discard_to to host->max_busy_timeout, to reflect that
it tells the mmc core layer about the maximum supported busy detection
timeout by the host.

This timeout is at the moment only applicable to erase/trim/discard
commands. By the renaming we provide the option of make use of it for
other commands that cares about busy detection. In other words, those
commands that wants an R1B response, like for example the mmc switch
command.

Do note that the max_busy_timeout is supposed to be specified only by
hosts supporting MMC_CAP_WAIT_WHILE_BUSY.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  |    6 +++---
 drivers/mmc/host/sdhci.c |    2 +-
 include/linux/mmc/host.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..a81d754 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2137,7 +2137,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 		y = 0;
 		for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
 			timeout = mmc_erase_timeout(card, arg, qty + x);
-			if (timeout > host->max_discard_to)
+			if (timeout > host->max_busy_timeout)
 				break;
 			if (timeout < last_timeout)
 				break;
@@ -2169,7 +2169,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	unsigned int max_discard, max_trim;
 
-	if (!host->max_discard_to)
+	if (!host->max_busy_timeout)
 		return UINT_MAX;
 
 	/*
@@ -2189,7 +2189,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 		max_discard = 0;
 	}
 	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
-		 mmc_hostname(host), max_discard, host->max_discard_to);
+		 mmc_hostname(host), max_discard, host->max_busy_timeout);
 	return max_discard;
 }
 EXPORT_SYMBOL(mmc_calc_max_discard);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef47..ec57c6c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2941,7 +2941,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
 		host->timeout_clk = mmc->f_max / 1000;
 
-	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+	mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 99f5709..9805522 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -304,7 +304,7 @@ struct mmc_host {
 	unsigned int		max_req_size;	/* maximum number of bytes in one req */
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
 	unsigned int		max_blk_count;	/* maximum number of blocks in one req */
-	unsigned int		max_discard_to;	/* max. discard timeout in ms */
+	unsigned int		max_busy_timeout; /* max busy timeout in ms */
 
 	/* private data */
 	spinlock_t		lock;		/* lock for claim and bus ops */
-- 
1.7.9.5


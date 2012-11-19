From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] Powerpc eSDHC: Use u64 to calculate the timeout value to avoid overflow
Date: Mon, 19 Nov 2012 13:31:00 +0800
Message-ID: <1353303061-16679-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1353303061-16679-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:42503
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab2KSFva (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 00:51:30 -0500
Received: from mail85-va3 (localhost [127.0.0.1])	by mail85-va3-R.bigfish.com
 (Postfix) with ESMTP id 131803200D7	for <linux-mmc@vger.kernel.org>; Mon, 19
 Nov 2012 05:51:29 +0000 (UTC)
Received: from VA3EHSMHS004.bigfish.com (unknown [10.7.14.244])	by
 mail85-va3.bigfish.com (Postfix) with ESMTP id 68A3922016F	for
 <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 05:51:27 +0000 (UTC)
In-Reply-To: <1353303061-16679-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>

As some mmc cards need large timeout value usually a few seconds,
so data timeout nanosecond will overflow with u32 variable and
give the wrong timeout value, so use u64 will be safe.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/core/core.c  |   21 ++++++++-------------
 drivers/mmc/host/sdhci.c |    6 +++---
 include/linux/mmc/core.h |    2 +-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06c42cf..893144e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -208,10 +208,10 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	if (mrq->data) {
 		pr_debug("%s:     blksz %d blocks %d flags %08x "
-			"tsac %d ms nsac %d\n",
+			"tsac %lld ms nsac %d\n",
 			mmc_hostname(host), mrq->data->blksz,
 			mrq->data->blocks, mrq->data->flags,
-			mrq->data->timeout_ns / 1000000,
+			div_u64(mrq->data->timeout_ns, 1000000),
 			mrq->data->timeout_clks);
 	}
 
@@ -659,16 +659,16 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	if (data->flags & MMC_DATA_WRITE)
 		mult <<= card->csd.r2w_factor;
 
-	data->timeout_ns = card->csd.tacc_ns * mult;
+	data->timeout_ns = (u64)card->csd.tacc_ns * mult;
 	data->timeout_clks = card->csd.tacc_clks * mult;
 
 	/*
 	 * SD cards also have an upper limit on the timeout.
 	 */
 	if (mmc_card_sd(card)) {
-		unsigned int timeout_us, limit_us;
+		u64 timeout_us, limit_us;
 
-		timeout_us = data->timeout_ns / 1000;
+		timeout_us = div_u64(data->timeout_ns, 1000);
 		if (mmc_host_clk_rate(card->host))
 			timeout_us += data->timeout_clks * 1000 /
 				(mmc_host_clk_rate(card->host) / 1000);
@@ -1545,14 +1545,9 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 		/* CSD Erase Group Size uses write timeout */
 		unsigned int mult = (10 << card->csd.r2w_factor);
 		unsigned int timeout_clks = card->csd.tacc_clks * mult;
-		unsigned int timeout_us;
-
-		/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
-		if (card->csd.tacc_ns < 1000000)
-			timeout_us = (card->csd.tacc_ns * mult) / 1000;
-		else
-			timeout_us = (card->csd.tacc_ns / 1000) * mult;
+		u64 timeout_us;
 
+		timeout_us = (u64)(card->csd.tacc_ns / 1000) * mult;
 		/*
 		 * ios.clock is only a target.  The real clock rate might be
 		 * less but not that much less, so fudge it by multiplying by 2.
@@ -1561,7 +1556,7 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 		timeout_us += (timeout_clks * 1000) /
 			      (mmc_host_clk_rate(card->host) / 1000);
 
-		erase_timeout = timeout_us / 1000;
+		erase_timeout = div_u64(timeout_us, 1000);
 
 		/*
 		 * Theoretically, the calculation could underflow so round up
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f05a377..a5adc9f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -651,7 +651,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
 	struct mmc_data *data = cmd->data;
-	unsigned target_timeout, current_timeout;
+	u64 target_timeout, current_timeout;
 
 	/*
 	 * If the host controller provides us with an incorrect timeout
@@ -668,9 +668,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 
 	/* timeout in us */
 	if (!data)
-		target_timeout = cmd->cmd_timeout_ms * 1000;
+		target_timeout = (u64)cmd->cmd_timeout_ms * 1000;
 	else {
-		target_timeout = data->timeout_ns / 1000;
+		target_timeout = div_u64(data->timeout_ns, 1000);
 		if (host->clock)
 			target_timeout += data->timeout_clks / host->clock;
 	}
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 9b9cdaf..a2ff2e9 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -99,7 +99,7 @@ struct mmc_command {
 };
 
 struct mmc_data {
-	unsigned int		timeout_ns;	/* data timeout (in ns, max 80ms) */
+	u64			timeout_ns;	/* data timeout (in ns) */
 	unsigned int		timeout_clks;	/* data timeout (in clocks) */
 	unsigned int		blksz;		/* data block size */
 	unsigned int		blocks;		/* number of blocks */
-- 
1.7.0.4



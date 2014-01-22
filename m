From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/10] mmc: core: Respect host's max_busy_timeout when sending sleep cmd
Date: Wed, 22 Jan 2014 16:00:20 +0100
Message-ID: <1390402824-9850-7-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:54228 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaAVPAk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:40 -0500
Received: by mail-wi0-f169.google.com with SMTP id e4so6764142wiv.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:39 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

When sending the sleep command for host drivers supporting
MMC_CAP_WAIT_WHILE_BUSY, we need to confirm that max_busy_timeout is
big enough comparing to the sleep timeout specified from card's
EXT_CSD. If this isn't case, we use a R1 response instead of R1B and
fallback to use a delay instead.

Do note that a max_busy_timeout set to zero by the host, is interpreted
as it can cope with whatever timeout the mmc core provides it with.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 897fdd1..32e1546 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1359,6 +1359,8 @@ static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
 	struct mmc_card *card = host->card;
+	unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
+	unsigned int max_busy_timeout;
 	int err;
 
 	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
@@ -1372,7 +1374,18 @@ static int mmc_sleep(struct mmc_host *host)
 	cmd.arg = card->rca << 16;
 	cmd.arg |= 1 << 15;
 
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	/* We interpret unspecified timeouts as the host can cope with all. */
+	max_busy_timeout = host->max_busy_timeout ?
+			host->max_busy_timeout : timeout_ms;
+
+	if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
+		(timeout_ms <= max_busy_timeout)) {
+		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+		cmd.busy_timeout = timeout_ms;
+	} else {
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	}
+
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
 		return err;
@@ -1383,8 +1396,8 @@ static int mmc_sleep(struct mmc_host *host)
 	 * SEND_STATUS command to poll the status because that command (and most
 	 * others) is invalid while the card sleeps.
 	 */
-	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
-		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
+	if (!cmd.busy_timeout)
+		mmc_delay(timeout_ms);
 
 	return err;
 }
-- 
1.7.9.5


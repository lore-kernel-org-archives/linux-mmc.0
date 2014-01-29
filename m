From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/13] mmc: core: Rename cmd_timeout_ms to busy_timeout
Date: Wed, 29 Jan 2014 23:37:54 +0100
Message-ID: <1391035085-2747-3-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48734 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaA2WiS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:18 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so1966882lbh.36
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:14 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

To better reflect that the cmd_timeout_ms is directly related to the
busy detection timeout, let's rename it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    |    2 +-
 drivers/mmc/core/mmc_ops.c |    2 +-
 drivers/mmc/host/sdhci.c   |    8 ++++----
 include/linux/mmc/core.h   |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a81d754..90de094 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1950,7 +1950,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.opcode = MMC_ERASE;
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
+	cmd.busy_timeout = mmc_erase_timeout(card, arg, qty);
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		pr_err("mmc_erase: erase error %d, status %#x\n",
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index e5b5eeb..3377bbf 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -432,7 +432,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
 
 
-	cmd.cmd_timeout_ms = timeout_ms;
+	cmd.busy_timeout = timeout_ms;
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ec57c6c..1853255 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -675,12 +675,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		return 0xE;
 
 	/* Unspecified timeout, assume max */
-	if (!data && !cmd->cmd_timeout_ms)
+	if (!data && !cmd->busy_timeout)
 		return 0xE;
 
 	/* timeout in us */
 	if (!data)
-		target_timeout = cmd->cmd_timeout_ms * 1000;
+		target_timeout = cmd->busy_timeout * 1000;
 	else {
 		target_timeout = data->timeout_ns / 1000;
 		if (host->clock)
@@ -1019,8 +1019,8 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	timeout = jiffies;
-	if (!cmd->data && cmd->cmd_timeout_ms > 9000)
-		timeout += DIV_ROUND_UP(cmd->cmd_timeout_ms, 1000) * HZ + HZ;
+	if (!cmd->data && cmd->busy_timeout > 9000)
+		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
 		timeout += 10 * HZ;
 	mod_timer(&host->timer, timeout);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 87079fc..b276996 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -95,7 +95,7 @@ struct mmc_command {
  *              actively failing requests
  */
 
-	unsigned int		cmd_timeout_ms;	/* in milliseconds */
+	unsigned int		busy_timeout;	/* busy detect timeout in ms */
 	/* Set this flag only for blocking sanitize request */
 	bool			sanitize_busy;
 
-- 
1.7.9.5


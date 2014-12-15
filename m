From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v2 3/4] mmc: sdhci: add a quirk for single block transactions
Date: Mon, 15 Dec 2014 15:30:34 +0800
Message-ID: <1418628635-3436-4-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1418628635-3436-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56854 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbaLOHeM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Dec 2014 02:34:12 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so11364256pad.29
        for <linux-mmc@vger.kernel.org>; Sun, 14 Dec 2014 23:34:12 -0800 (PST)
In-Reply-To: <1418628635-3436-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, chris@printf.net, ulf.hansson@linaro.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

This patch defines a quirk to disable the block count
for single block transactions.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 8 +++++---
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b319c10..5581b16 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -911,7 +911,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
-	u16 mode;
+	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
 	if (data == NULL) {
@@ -929,9 +929,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	WARN_ON(!host->data);
 
-	mode = SDHCI_TRNS_BLK_CNT_EN;
+	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
+		mode = SDHCI_TRNS_BLK_CNT_EN;
+
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
-		mode |= SDHCI_TRNS_MULTI;
+		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
 		/*
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dd2ba4b..2e048f4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -108,6 +108,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
 /* forced tuned clock */
 #define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<12)
+/* disable the block count for single block transactions */
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0


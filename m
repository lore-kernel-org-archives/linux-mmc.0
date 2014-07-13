From: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Subject: [PATCH 3/4] mmc: sdhci: add quirk for single block transactions
Date: Sun, 13 Jul 2014 13:21:09 +0800
Message-ID: <1405228870-5088-4-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35527 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaGMFXZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 01:23:25 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so3517174pde.10
        for <linux-mmc@vger.kernel.org>; Sat, 12 Jul 2014 22:23:24 -0700 (PDT)
In-Reply-To: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, linux@arm.linux.org.uk, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org, Vincent.Yang@tw.fujitsu.com

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
index 900b4e4..169e17d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -876,7 +876,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
-	u16 mode;
+	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
 	if (data == NULL) {
@@ -889,9 +889,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
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
index bcbad45..72072d1 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -102,6 +102,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<8)
 /* forced tuned clock */
 #define SDHCI_QUIRK2_TUNING_WORK_AROUND		(1<<9)
+/* disable the block count for single block transactions */
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<10)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0


From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 2/6] mmc: sdhci: add a callback of tuning block setting
Date: Mon, 14 Sep 2015 19:43:35 +0800
Message-ID: <1442231015-10617-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com ([157.56.110.112]:43243
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752161AbbINLt3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 07:49:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Add a tuning block setting callback to let host set its
tuning block before executing tuning procedure.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9b3d4c2..9da4644 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1939,6 +1939,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return err;
 	}
 
+	if (host->ops->set_tuning_block)
+		host->ops->set_tuning_block(host);
+
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 723f034..98f239b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -546,6 +546,7 @@ struct sdhci_ops {
 					 int card_drv, int *drv_type);
 	void	(*signal_voltage_switch)(struct sdhci_host *host,
 					 unsigned char signal_voltage);
+	void	(*set_tuning_block)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.1.0.27.g96db324


From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 2/8] mmc: sdhci: add a callback of tuning block setting
Date: Thu, 17 Sep 2015 13:50:48 +0800
Message-ID: <1442469054-23644-2-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0128.outbound.protection.outlook.com ([65.55.169.128]:47772
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752827AbbIQF5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 01:57:15 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
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


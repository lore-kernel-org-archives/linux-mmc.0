From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 1/8] mmc: sdhci: add a callback of signal voltage switching
Date: Thu, 17 Sep 2015 13:50:47 +0800
Message-ID: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0122.outbound.protection.outlook.com ([207.46.100.122]:56728
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbbIQF5K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 01:57:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Add a signal voltage switching callback to let host use its own
switching process.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- Modified commit message
	- Added SDR50 support patches
---
 drivers/mmc/host/sdhci.c | 5 +++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64b7fdb..9b3d4c2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1757,6 +1757,11 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
+	if (host->ops->signal_voltage_switch) {
+		host->ops->signal_voltage_switch(host, ios->signal_voltage);
+		return 0;
+	}
+
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
 	switch (ios->signal_voltage) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7c02ff4..723f034 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -544,6 +544,8 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	void	(*signal_voltage_switch)(struct sdhci_host *host,
+					 unsigned char signal_voltage);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.1.0.27.g96db324


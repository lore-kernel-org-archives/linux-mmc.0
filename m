From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/5] mmc: sdhci: add eMMC hardware reset support
Date: Mon, 29 Aug 2011 16:42:12 +0300
Message-ID: <1314625335-11638-3-git-send-email-adrian.hunter@intel.com>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab1H2Nm0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:26 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Add an SDHCI operation for hardware reset and connect it to the
host controller operation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    9 +++++++++
 drivers/mmc/host/sdhci.h |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..d66a7a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1471,6 +1471,14 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return 0;
 }
 
+static void sdhci_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops && host->ops->hw_reset)
+		host->ops->hw_reset(host);
+}
+
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host;
@@ -1805,6 +1813,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.execute_tuning			= sdhci_execute_tuning,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 745c42f..7bd919c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -273,7 +273,7 @@ struct sdhci_ops {
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
-
+	void	(*hw_reset)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.6


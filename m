From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/12] mmc: sdhci: Add a callback to select drive strength
Date: Thu,  5 Feb 2015 15:13:47 +0200
Message-ID: <1423142029-22521-11-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391AbbBENSF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:05 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Add a callbak to let host drivers select drive
strength.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 13 +++++++++++++
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8848e06..fe1b00d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2054,6 +2054,18 @@ out_unlock:
 	return err;
 }
 
+static int sdhci_select_drive_strength(struct mmc_card *card,
+				       unsigned int max_dtr, int host_drv,
+				       int card_drv, int *drv_type)
+{
+	struct sdhci_host *host = mmc_priv(card->host);
+
+	if (!host->ops->select_drive_strength)
+		return 0;
+
+	return host->ops->select_drive_strength(host, card, max_dtr, host_drv,
+						card_drv, drv_type);
+}
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
@@ -2198,6 +2210,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
 	.execute_tuning			= sdhci_execute_tuning,
+	.select_drive_strength		= sdhci_select_drive_strength,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
 };
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0315e18..57e7bad 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -340,6 +340,10 @@ struct sdhci_ops {
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	int	(*select_drive_strength)(struct sdhci_host *host,
+					 struct mmc_card *card,
+					 unsigned int max_dtr, int host_drv,
+					 int card_drv, int *drv_type);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.9.1


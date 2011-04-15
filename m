From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 10/12] mmc: sdhci: enable preset value after uhs initialization
Date: Fri, 15 Apr 2011 16:12:58 +0530
Message-ID: <1302864180-1858-3-git-send-email-arindam.nath@amd.com>
References: <1302864180-1858-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37925 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1DOKns (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 06:43:48 -0400
Received: by pvg12 with SMTP id 12so1009144pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:43:48 -0700 (PDT)
In-Reply-To: <1302864180-1858-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

According to the Host Controller spec v3.00, setting Preset Value Enable
in the Host Control2 register lets SDCLK Frequency Select, Clock Generator
Select and Driver Strength Select to be set automatically by the Host
Controller based on the UHS-I mode set. This patch enables this feature.
We also reset Preset Value Enable next time before initialization.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   11 +++++++++++
 drivers/mmc/host/sdhci.c |   32 ++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ea3c7eb..ed6b11b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -962,6 +962,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/*
+	 * Since initialization is now complete, enable preset
+	 * value registers.
+	 */
+	if (host->ops->enable_preset_value)
+		host->ops->enable_preset_value(host, 1);
+
 	host->card = card;
 	return 0;
 
@@ -1112,6 +1119,10 @@ int mmc_attach_sd(struct mmc_host *host)
 	if (err)
 		return err;
 
+	/* Disable preset value enable if already set from last time */
+	if (host->ops->enable_preset_value)
+		host->ops->enable_preset_value(host, 0);
+
 	/*
 	 * We need to get OCR a different way for SPI.
 	 */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c8c5878..4d32464 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1658,6 +1658,37 @@ out:
 	return err;
 }
 
+static void sdhci_enable_preset_value(struct mmc_host *mmc, int enable)
+{
+	struct sdhci_host *host;
+	u16 ctrl;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	/* Host Controller v3.00 defines preset value registers */
+	if (host->version < SDHCI_SPEC_300)
+		return;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	/*
+	 * We only enable or disable Preset Value if they are not already
+	 * enabled or disabled respectively. Otherwise, we bail out.
+	 */
+	if (enable && !(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+		ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+	} else if (!enable && (ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+		ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -1665,6 +1696,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.execute_tuning			= sdhci_execute_tuning,
+	.enable_preset_value		= sdhci_enable_preset_value,
 };
 
 /*****************************************************************************\
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bbd8144..9beb6c5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -137,6 +137,7 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*execute_tuning)(struct mmc_host *host);
+	void	(*enable_preset_value)(struct mmc_host *host, int enable);
 };
 
 struct mmc_card;
-- 
1.7.1


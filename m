From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 10/12] mmc: sdhci: enable preset value after uhs initialization
Date: Fri,  4 Mar 2011 17:02:47 +0530
Message-ID: <1299238369-1768-11-git-send-email-arindam.nath@amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38152 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759457Ab1CDLfL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 06:35:11 -0500
Received: by iyb26 with SMTP id 26so1807088iyb.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 03:35:11 -0800 (PST)
In-Reply-To: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

According to the Host Controller spec v3.00, setting Preset Value Enable
in the Host Control2 register lets SDCLK Frequency Select, Clock Generator
Select and Driver Strength Select to be set automatically by the Host
Controller based on the UHS-I mode set. This patch enables this feature.
We also reset Preset Value Enable when the card is removed from the slot.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |    7 +++++++
 drivers/mmc/host/sdhci.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1e2d157..ae7a771 100644
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
+		host->ops->enable_preset_value(host);
+
 	host->card = card;
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8f4f102..1f6e4ad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1602,6 +1602,40 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_enable_preset_value(struct mmc_host *mmc)
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
+	ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void sdhci_disable_preset_value(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	/* Only for Host Controller version >= v3.00 */
+	if (host->version < SDHCI_SPEC_300)
+		return;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -1610,6 +1644,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.get_max_current_180		= sdhci_get_max_current_180,
 	.execute_tuning			= sdhci_execute_tuning,
+	.enable_preset_value		= sdhci_enable_preset_value,
 };
 
 /*****************************************************************************\
@@ -1920,6 +1955,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
 		tasklet_schedule(&host->card_tasklet);
+		sdhci_disable_preset_value(host);
 	}
 
 	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 651e40b..e63e063 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -130,6 +130,7 @@ struct mmc_host_ops {
 	int	(*start_signal_voltage_switch)(struct mmc_host *host);
 	int	(*get_max_current_180)(struct mmc_host *mmc);
 	void	(*execute_tuning)(struct mmc_host *host);
+	void	(*enable_preset_value)(struct mmc_host *host);
 };
 
 struct mmc_card;
-- 
1.7.1


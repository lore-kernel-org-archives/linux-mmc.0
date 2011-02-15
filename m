From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 10/12] mmc: sdhci: enable preset value after uhs initialization
Date: Tue, 15 Feb 2011 15:05:08 +0530
Message-ID: <1297762510-2696-11-git-send-email-arindam.nath@amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40842 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab1BOJiM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:38:12 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so5732646iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:38:12 -0800 (PST)
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

According to the Host Controller spec v3.00, setting Preset Value Enable
in the Host Control2 register lets SDCLK Frequency Select, Clock Generator
Select and Driver Strength Select to be set automatically by the Host
Controller based on the UHS-I mode set. This patch enables this feature. We
also reset Preset Value Enable when the card is removed from the slot.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |    6 ++++++
 drivers/mmc/host/sdhci.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3113cb6..1a625cc 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -949,6 +949,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/*
+	 * Since initialization is now complete, enable preset
+	 * value registers.
+	 */
+	host->ops->enable_preset_value(host);
+
 	host->card = card;
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f3f0dc..722f668 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1614,6 +1614,40 @@ out:
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
@@ -1622,6 +1656,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.get_max_current_180		= sdhci_get_max_current_180,
 	.execute_tuning			= sdhci_execute_tuning,
+	.enable_preset_value		= sdhci_enable_preset_value,
 };
 
 /*****************************************************************************\
@@ -1932,6 +1967,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
 		tasklet_schedule(&host->card_tasklet);
+		sdhci_disable_preset_value(host);
 	}
 
 	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4abb964..a47accd 100644
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


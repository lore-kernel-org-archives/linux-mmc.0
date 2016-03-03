From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 3/4] mmc: sdhci: implement enhanced strobe callback
Date: Thu,  3 Mar 2016 10:36:44 +0800
Message-ID: <1456972604-8118-1-git-send-email-shawn.lin@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Enhanced strobe stuff currently is beyond the scope
of Secure Digital Host Controller Interface. So we can't
find a register here to enable/disable it. We experct
variant drivers to finish the details according to their
vendor settings.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 03fbb36..61a1af1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2007,6 +2007,16 @@ out_unlock:
 	return err;
 }
 
+static int sdhci_prepare_enhanced_strobe(struct mmc_host *mmc, bool enable)
+{
+	/*
+	* Currently we can't find a register to enable enhanced strobe
+	* function for standard sdhci, so we expect variant drivers to
+	* overwrite it.
+	*/
+	return -EINVAL;
+}
+
 static int sdhci_select_drive_strength(struct mmc_card *card,
 				       unsigned int max_dtr, int host_drv,
 				       int card_drv, int *drv_type)
@@ -2116,6 +2126,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
+	.prepare_enhanced_strobe	= sdhci_prepare_enhanced_strobe,
 	.execute_tuning			= sdhci_execute_tuning,
 	.select_drive_strength		= sdhci_select_drive_strength,
 	.card_event			= sdhci_card_event,
-- 
2.3.7

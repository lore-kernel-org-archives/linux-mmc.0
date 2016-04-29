From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 5/6] mmc: sdhci: implement enhanced strobe callback
Date: Fri, 29 Apr 2016 10:48:23 +0800
Message-ID: <1461898103-29026-1-git-send-email-shawn.lin@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42691 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbcD2Css (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 22:48:48 -0400
In-Reply-To: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Enhanced strobe stuff currently is beyond the scope
of Secure Digital Host Controller Interface. So we can't
find a register here to enable/disable it. We experct
variant drivers to finish the details according to their
vendor settings.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 94cffa7..a04e4c4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2049,6 +2049,16 @@ out_unlock:
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
@@ -2158,6 +2168,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
+	.prepare_enhanced_strobe	= sdhci_prepare_enhanced_strobe,
 	.execute_tuning			= sdhci_execute_tuning,
 	.select_drive_strength		= sdhci_select_drive_strength,
 	.card_event			= sdhci_card_event,
-- 
2.3.7



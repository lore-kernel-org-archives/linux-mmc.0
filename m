From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: support hardware clock gating in the SD layer
Date: Fri, 21 Jan 2011 11:35:24 -0800
Message-ID: <EB19645C-7749-4C05-85A8-245D05AAAC1F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53015 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754891Ab1AUTfZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:35:25 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Define callback (platform_hw_clk_gate) that is called when H/W clock gating
is enabled. The adaptation layer is responsible for enabling hw clock
gating by:

a) setting mmc->caps |= MMC_CAP_HW_CLOCK_GATING to enable h/w gating
b) defining and implementing the callback.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 92be22d..611322c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1235,6 +1235,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
+#ifdef CONFIG_MMC_CLKGATE
+	if ((mmc->caps & MMC_CAP_HW_CLOCK_GATING)
+		&& host->ops->platform_hw_clk_gate)
+			host->ops->platform_hw_clk_gate(host);
+#endif
+
 	/*
 	 * If your platform has 8-bit width support but is not a v3 controller,
 	 * or if it requires special setup code, you should implement that in
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 580a8ff..8e271df 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -246,6 +246,7 @@ struct sdhci_ops {
 	void	(*platform_specific_delay)(struct sdhci_host *host);
 	unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
 				unsigned int ddr);
+	void	(*platform_hw_clk_gate)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4



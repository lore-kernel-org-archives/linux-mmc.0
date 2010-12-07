From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2 3/3] sdhci: support H/W clock gating in Marvell PXA driver
Date: Tue, 7 Dec 2010 09:56:49 -0800
Message-ID: <192979DE-DB3E-467B-BD5B-B52049248CC6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57598 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751808Ab0LGSAo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Dec 2010 13:00:44 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>


Define callback (platform_hw_clk_gate) that is called when H/W clock gating
is defined. The adaptation layer is responsible for enabling hw clock
gating by:

a) setting mmc->caps |= MMC_CAP_HW_CLOCK_GATING to enable h/w gating
b) defining the callback.

This code tested in the Marvell Linux.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8a74fcb..c2e7c9e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1188,6 +1188,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
index 1efe7dc..26a8c09 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -221,6 +221,7 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void		(*platform_hw_clk_gate)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4


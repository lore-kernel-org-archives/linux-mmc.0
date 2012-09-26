From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v4 11/15] mmc: sdhci-pxav3: add signal_voltage_switch function
Date: Wed, 26 Sep 2012 19:38:43 +0800
Message-ID: <1348659527-4200-12-git-send-email-keyuan.liu@gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46562 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755064Ab2IZLof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:44:35 -0400
In-Reply-To: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c          |   25 +++++++++++++++++++++++++
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 04db9f1..2746bb5 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -163,10 +163,35 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return 0;
 }
 
+static void pxav3_signal_voltage_switch(struct sdhci_host *host, u8 vol)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	unsigned int set;
+
+	switch (vol) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		set = 3300000;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		set = 1800000;
+		break;
+	case MMC_SIGNAL_VOLTAGE_120:
+		set = 1200000;
+		break;
+	default:
+		set = 3300000;
+		break;
+	}
+	if (pdata && pdata->signal_voltage_switch)
+		pdata->signal_voltage_switch(set);
+}
+
 static struct sdhci_ops pxav3_sdhci_ops = {
 	.platform_reset_exit = pxav3_set_private_registers,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
+	.signal_voltage_switch = pxav3_signal_voltage_switch,
 };
 
 #ifdef CONFIG_OF
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index fdf38d6..3b94ab1 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -40,6 +40,7 @@
  * @quirks: quirks of platfrom
  * @quirks2: quirks2 of platfrom
  * @pm_caps: pm_caps of platfrom
+ * @signal_voltage_switch: soc/platfrom handling needed for voltage switch
  */
 struct sdhci_pxa_platdata {
 	unsigned int	flags;
@@ -54,6 +55,7 @@ struct sdhci_pxa_platdata {
 	unsigned int	quirks;
 	unsigned int	quirks2;
 	unsigned int	pm_caps;
+	void    (*signal_voltage_switch)(unsigned int set);
 };
 
 struct sdhci_pxa {
-- 
1.7.0.4


From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v4 13/15] mmc: sdhci: add mmc 1.8v signal voltage switch function
Date: Wed, 26 Sep 2012 19:38:45 +0800
Message-ID: <1348659527-4200-14-git-send-email-keyuan.liu@gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35752 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755064Ab2IZLol (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:44:41 -0400
In-Reply-To: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Add the function since MMC 1.8v signal voltage switch don't need
the same switch sequence requirements as SD/SDIO.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14ec904..50e7a54 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1794,6 +1794,46 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 	return -EAGAIN;
 }
 
+static int sdhci_mmc_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
+						u16 ctrl)
+{
+	int ret;
+
+	if (host->vqmmc) {
+		ret = regulator_set_voltage(host->vqmmc, 1700000, 1950000);
+		if (ret) {
+			pr_warning("%s: Switching to 1.8V signalling voltage "
+				   " failed\n", mmc_hostname(host->mmc));
+			return -EIO;
+		}
+	}
+
+	/*
+	 * May need to apply soc/platfrom settings for the
+	 * voltage switch
+	 */
+	if (host->ops->signal_voltage_switch)
+		host->ops->signal_voltage_switch(host,
+				host->mmc->ios.signal_voltage);
+
+	/* Enable 1.8V Signal Enable in the Host Control2 register */
+	ctrl |= SDHCI_CTRL_VDD_180;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	/* Wait for 5ms */
+	usleep_range(5000, 5500);
+
+	/* 1.8V regulator output should be stable within 5 ms */
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ctrl & SDHCI_CTRL_VDD_180)
+		return 0;
+
+	pr_warning("%s: 1.8V regulator output did not became stable\n",
+		   mmc_hostname(host->mmc));
+
+	return -EIO;
+}
+
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 						struct mmc_ios *ios)
 {
@@ -1814,8 +1854,12 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
 		return sdhci_do_3_3v_signal_voltage_switch(host, ctrl);
 	else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
-			(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180))
+		(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180))
 		return sdhci_do_1_8v_signal_voltage_switch(host, ctrl);
+	else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
+		(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_MMC_180))
+		return sdhci_mmc_do_1_8v_signal_voltage_switch(host,
+			ctrl);
 	else
 		/* No signal voltage switch required */
 		return 0;
-- 
1.7.0.4


From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v4 10/15] mmc: sdhci: introduce signal_voltage_switch callback function
Date: Wed, 26 Sep 2012 19:38:42 +0800
Message-ID: <1348659527-4200-11-git-send-email-keyuan.liu@gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:58557 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755064Ab2IZLob (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:44:31 -0400
In-Reply-To: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

Some soc/platform need specific handling for signal voltage
switch. For example, mmp2/mmp3 need to set the AIB IO domain
control register accordingly.

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   17 +++++++++++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 49152fb..14ec904 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1684,6 +1684,15 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 			return -EIO;
 		}
 	}
+
+	/*
+	 * May need to apply soc/platfrom settings for the
+	 * voltage switch
+	 */
+	if (host->ops->signal_voltage_switch)
+		host->ops->signal_voltage_switch(host,
+				host->mmc->ios.signal_voltage);
+
 	/* Wait for 5ms */
 	usleep_range(5000, 5500);
 
@@ -1726,6 +1735,14 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 			ret = 0;
 
 		if (!ret) {
+			/*
+			 * May need to apply soc/platfrom settings for the
+			 * voltage switch
+			 */
+			if (host->ops->signal_voltage_switch)
+				host->ops->signal_voltage_switch(host,
+					host->mmc->ios.signal_voltage);
+
 			ctrl |= SDHCI_CTRL_VDD_180;
 			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5eb27bf..5f20d32 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -290,6 +290,7 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void	(*signal_voltage_switch)(struct sdhci_host *host, u8 vol);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


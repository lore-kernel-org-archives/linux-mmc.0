From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH] mmc: sdhci: add interface for 1.2v voltage switch
Date: Tue, 11 Sep 2012 14:43:50 +0800
Message-ID: <1347345830-32042-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:54917 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388Ab2IKGrX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 02:47:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: cxie4@marvell.com, hzhuang1@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Add the interface since emmc may need 1.2v voltage.
The function should be controller specific.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 08dae93..8c56435 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1754,6 +1754,9 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 	else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
 			(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180))
 		return sdhci_do_1_8v_signal_voltage_switch(host, ctrl);
+	else if ((ios->signal_voltage == MMC_SIGNAL_VOLTAGE_120) &&
+			host->ops->signal_voltage_switch_1_2v)
+		return host->ops->signal_voltage_switch_1_2v(host);
 	else
 		/* No signal voltage switch required */
 		return 0;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 2e89dac..e847fa3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -280,6 +280,7 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	int	(*signal_voltage_switch_1_2v)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


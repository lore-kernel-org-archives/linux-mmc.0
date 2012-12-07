From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v9 05/10] mmc: sdhci: introduce signal_voltage_switch callback function
Date: Fri,  7 Dec 2012 10:36:25 +0800
Message-ID: <1354847790-18690-6-git-send-email-kliu5@marvell.com>
References: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35713 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932169Ab2LGCeg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 21:34:36 -0500
In-Reply-To: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>, Bin Wang <binw@marvell.com>, Philip Rakity <prakity@marvell.com>

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
index 50d0382..10d06fd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1687,6 +1687,15 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
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
 
@@ -1729,6 +1738,14 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
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
index 7c659dd..cc408c4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -291,6 +291,7 @@ struct sdhci_ops {
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
 	void	(*platform_init)(struct sdhci_host *host);
+	void    (*signal_voltage_switch)(struct sdhci_host *host, u8 vol);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


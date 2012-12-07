From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v9 08/10] mmc: sdhci: add function to get retunig timer count
Date: Fri,  7 Dec 2012 10:36:28 +0800
Message-ID: <1354847790-18690-9-git-send-email-kliu5@marvell.com>
References: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43767 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964891Ab2LGCeo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 21:34:44 -0500
In-Reply-To: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

According to SD host spec (Capabilities Register, offset 0x40<43:40>),
if timer count for retuning return 0xF, it means get information from other source.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3db5f10..20a3c53 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2970,6 +2970,14 @@ int sdhci_add_host(struct sdhci_host *host)
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
+	if (host->tuning_count == 0xF) {
+		if (host->ops->get_tuning_count)
+			host->tuning_count =
+				host->ops->get_tuning_count(host) & 0xF;
+		else
+			pr_err("%s: Hardware doesn't specify tuning count.\n",
+				mmc_hostname(mmc));
+	}
 
 	/*
 	 * In case Re-tuning Timer is not disabled, the actual value of
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7fe0462..8596f11 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -291,6 +291,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*signal_voltage_switch)(struct sdhci_host *host, u8 vol);
+	unsigned int    (*get_tuning_count)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


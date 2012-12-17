From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 03/12] mmc: sdhci: add function to get retunig timer count
Date: Mon, 17 Dec 2012 19:21:59 +0800
Message-ID: <1355743328-17758-4-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:39926 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab2LQLWk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:40 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

According to SD host spec (Capabilities Register, offset 0x40<43:40>),
if timer count for retuning return 0xF, it means get information from other source

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b678a08..66690aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2907,6 +2907,14 @@ int sdhci_add_host(struct sdhci_host *host)
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
index a6d69b7..d00e273 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -282,6 +282,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
+	unsigned int    (*get_tuning_count)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v6 14/14] mmc: sdhci: add function to get retunig timer count
Date: Wed, 17 Oct 2012 19:04:53 +0800
Message-ID: <1350471893-29633-15-git-send-email-keyuan.liu@gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:60308 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756597Ab2JQLFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 07:05:45 -0400
In-Reply-To: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

According to spec, if timer count for retuning return 0xF,
it means get information from other source.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9f44efd..882223a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2963,6 +2963,14 @@ int sdhci_add_host(struct sdhci_host *host)
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
index 5f20d32..d124f37 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -291,6 +291,7 @@ struct sdhci_ops {
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
 	void	(*signal_voltage_switch)(struct sdhci_host *host, u8 vol);
+	unsigned int	(*get_tuning_count)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


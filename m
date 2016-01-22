From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/3] mmc: sdhci: Add get_cd sdhci host operation
Date: Fri, 22 Jan 2016 11:45:00 +0200
Message-ID: <1453455902-3987-2-git-send-email-adrian.hunter@intel.com>
References: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60849 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbcAVJss (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jan 2016 04:48:48 -0500
In-Reply-To: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Russell King <linux@arm.linux.org.uk>

In the future sdhci will be a library.  When that happens
a callback will be needed to allow drivers easily to override
the standard way of determining whether a card is present.
That is needed because functions like sdhci_request() also
check the card presence.

The get_cd callback is being added now to facilitate
a bug fix, for which subsequent patches are provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci.c | 6 +++++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435d1bcc..535236084b27 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1612,7 +1612,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static int sdhci_do_get_cd(struct sdhci_host *host)
 {
-	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+	int gpio_cd;
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		return 0;
@@ -1621,10 +1621,14 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		return 1;
 
+	if (host->ops->get_cd)
+		return host->ops->get_cd(host);
+
 	/*
 	 * Try slot gpio detect, if defined it take precedence
 	 * over build in controller functionality
 	 */
+	gpio_cd = mmc_gpio_get_cd(host->mmc);
 	if (!IS_ERR_VALUE(gpio_cd))
 		return !!gpio_cd;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7654ae5d2b4e..a6c2cd8ef0b2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -552,6 +552,7 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	int	(*get_cd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.9.1


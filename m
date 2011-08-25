From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v3 1/2] mmc: sdio add regulator vsdio
Date: Thu, 25 Aug 2011 14:26:14 +0800
Message-ID: <1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
References: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:33207 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1HYG07 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 02:26:59 -0400
In-Reply-To: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.o
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Ohad Ben-Cohen <ohad@wizery.com>

sdio client may be required power on/off dynamically.
With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down

CC: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   22 ++++++++++++++++++++++
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..e0ef7d3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1424,6 +1424,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->vsdio) {
+		if (ios->power_mode != host->power_mode_old) {
+			if (ios->power_mode == MMC_POWER_OFF)
+				regulator_disable(host->vsdio);
+
+			if (ios->power_mode == MMC_POWER_UP)
+				regulator_enable(host->vsdio);
+		}
+
+		host->power_mode_old = ios->power_mode;
+	}
 }
 
 static int check_ro(struct sdhci_host *host)
@@ -2748,6 +2760,13 @@ int sdhci_add_host(struct sdhci_host *host)
 		regulator_enable(host->vmmc);
 	}
 
+	host->vsdio = regulator_get(mmc_dev(mmc), "vsdio");
+	if (IS_ERR(host->vsdio))
+		host->vsdio = NULL;
+	else
+		printk(KERN_INFO "%s: vsdio regulator found\n",
+			mmc_hostname(mmc));
+
 	sdhci_init(host, 0);
 
 #ifdef CONFIG_MMC_DEBUG
@@ -2839,6 +2858,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_put(host->vmmc);
 	}
 
+	if (host->vsdio)
+		regulator_put(host->vsdio);
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 5666f3a..201207a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -94,6 +94,8 @@ struct sdhci_host {
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
 	struct regulator *vmmc;	/* Power regulator */
+	struct regulator *vsdio;	/* sdio Power regulator */
+	unsigned char power_mode_old;	/* power supply mode */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.0.4


From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 6/7] mmc: sdhci: add regulator notifier for vqmmc
Date: Wed, 30 Jan 2013 16:59:47 +0800
Message-ID: <1359536388-7896-7-git-send-email-kliu5@marvell.com>
References: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36351 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393Ab3A3I7S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 03:59:18 -0500
In-Reply-To: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>, Philip Rakity <prakity@marvell.com>

Some soc/platform need specific handling for signal voltage
switch. For example, mmp2/mmp3 need to set the AIB IO domain
control register accordingly.
Use regulator notifier to do this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c  |    6 ++++++
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 81a4bfa..107ac15 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2944,6 +2944,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
 					SDHCI_SUPPORT_SDR50 |
 					SDHCI_SUPPORT_DDR50);
+		if (host->nb_vqmmc)
+			regulator_register_notifier(host->vqmmc,
+				host->nb_vqmmc);
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
@@ -3265,6 +3268,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	}
 
 	if (host->vqmmc) {
+		if (host->nb_vqmmc)
+			regulator_unregister_notifier(host->vqmmc,
+				host->nb_vqmmc);
 		regulator_disable(host->vqmmc);
 		regulator_put(host->vqmmc);
 	}
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..c3ef3b6 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -103,6 +103,7 @@ struct sdhci_host {
 
 	struct regulator *vmmc;		/* Power regulator (vmmc) */
 	struct regulator *vqmmc;	/* Signaling regulator (vccq) */
+	struct notifier_block	*nb_vqmmc;	/* Regulator notifier (vccq) */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.9.5


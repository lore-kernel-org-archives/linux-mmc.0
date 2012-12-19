From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 3/3] mmc: sdhci-pxav3: add wake up support
Date: Wed, 19 Dec 2012 19:56:56 +0800
Message-ID: <1355918216-28213-4-git-send-email-kliu5@marvell.com>
References: <1355918216-28213-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41880 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab2LSMIg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 07:08:36 -0500
In-Reply-To: <1355918216-28213-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c          |    7 +++++++
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index fad0966..9f82b4c 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -311,6 +311,13 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+	if (pdata->flags & PXA_FLAG_WAKEUP_HOST) {
+		device_init_wakeup(&pdev->dev, 1);
+		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
+	} else {
+		device_init_wakeup(&pdev->dev, 0);
+	}
+
 	return 0;
 
 err_add_host:
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 27d3156..2af0c12 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -21,6 +21,8 @@
 #define PXA_FLAG_CARD_PERMANENT	(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
+/* SDIO device or SD Card wakeup host from sleep feature */
+#define PXA_FLAG_WAKEUP_HOST (1<<3)
 
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
-- 
1.7.0.4


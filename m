From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2 2/2] mmc: sdhci-pxav3: add wake up support
Date: Sat,  5 Jan 2013 17:21:34 +0800
Message-ID: <1357377694-2167-2-git-send-email-kliu5@marvell.com>
References: <1357377694-2167-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:51547 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755152Ab3AEJX3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Jan 2013 04:23:29 -0500
In-Reply-To: <1357377694-2167-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, key

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index b4aca81..ff06aff 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -325,6 +325,13 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+	if (pdata->pm_caps & MMC_PM_KEEP_POWER) {
+		device_init_wakeup(&pdev->dev, 1);
+		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
+	} else {
+		device_init_wakeup(&pdev->dev, 0);
+	}
+
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
-- 
1.7.0.4


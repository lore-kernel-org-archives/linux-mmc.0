From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci-pxav3: controller should use SDCLK for timeout caculation
Date: Sun,  6 Jan 2013 17:31:44 +0800
Message-ID: <1357464704-17419-2-git-send-email-kliu5@marvell.com>
References: <1357464704-17419-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56040 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143Ab3AFJcq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jan 2013 04:32:46 -0500
In-Reply-To: <1357464704-17419-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, keyuan.liu@gmail.com, Kevin Liu <kliu5@marve>

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index ff06aff..31dc53c 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -259,7 +259,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 	clk_prepare_enable(clk);
 
-	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+	host->quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 		| SDHCI_QUIRK_32BIT_ADMA_SIZE
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-- 
1.7.9.5


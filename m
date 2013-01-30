From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 4/7] mmc: sdhci: remove check for CONFIG_REGULATOR
Date: Wed, 30 Jan 2013 16:59:45 +0800
Message-ID: <1359536388-7896-5-git-send-email-kliu5@marvell.com>
References: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:47569 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752953Ab3A3I7R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 03:59:17 -0500
In-Reply-To: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

If CONFIG_REGULATOR is NOT defined, host->vmmc will be NULL and
regulator_is_supported_voltage will return 0.
so the check can be removed.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7784756..631106d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2955,7 +2955,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}
 
-#ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
 			3600000);
@@ -2968,7 +2967,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
-#endif /* CONFIG_REGULATOR */
 
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
-- 
1.7.9.5


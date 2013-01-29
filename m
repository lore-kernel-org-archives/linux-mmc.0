From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 3/5] mmc: sdhci: correct voltage support caps when regulator vmmc used
Date: Tue, 29 Jan 2013 16:21:07 +0800
Message-ID: <1359447669-20089-4-git-send-email-kliu5@marvell.com>
References: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49399 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446Ab3A2IUe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 03:20:34 -0500
In-Reply-To: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kl>

Correct the judgement logic. When regulator vmmc is used, the voltage caps
should be cleared manually when both below conditions are true:
1. The requested voltage range is actually not supported by the regulator.
2. The voltage caps read from the capability register has been set.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 122c4c92..1591912 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2980,13 +2980,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
 			3600000);
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_330))
 			caps[0] &= ~SDHCI_CAN_VDD_330;
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_300))
 			caps[0] &= ~SDHCI_CAN_VDD_300;
 		ret = regulator_is_supported_voltage(host->vmmc, 1700000,
 			1950000);
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_180))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
 #endif /* CONFIG_REGULATOR */
-- 
1.7.9.5


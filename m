From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 04/12] mmc: sdhci: correct voltage support caps setting
Date: Mon, 17 Dec 2012 19:22:00 +0800
Message-ID: <1355743328-17758-5-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:54028 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300Ab2LQLWs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:48 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

Correct the judgement logic.
Disable the voltage support caps which has been disabled is unreasonable

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66690aa..41a007b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2942,13 +2942,13 @@ int sdhci_add_host(struct sdhci_host *host)
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
1.7.0.4


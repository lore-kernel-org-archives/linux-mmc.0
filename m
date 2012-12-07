From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v9 09/10] mmc: sdhci: correct voltage support caps setting
Date: Fri,  7 Dec 2012 10:36:29 +0800
Message-ID: <1354847790-18690-10-git-send-email-kliu5@marvell.com>
References: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59876 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964925Ab2LGCeo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 21:34:44 -0500
In-Reply-To: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

Correct the judgement logic.
Disable the voltage support caps which has been disabled is unreasonable.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 20a3c53..28bf9fc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3005,13 +3005,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->vmmc && regulator_count_voltages(host->vmmc) > 1) {
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


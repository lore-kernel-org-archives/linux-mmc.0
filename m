From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 06/12] mmc: sdhci: remove check for CONFIG_REGULATOR
Date: Mon, 17 Dec 2012 19:41:35 +0800
Message-ID: <1355744495-18595-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52254 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab2LQLlw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:41:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

If CONFIG_REGULATOR is NOT defined, host->vmmc will be NULL and
regulator_is_supported_voltage will return 0.
so the check can be removed.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 39c81bb..98b2a2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2938,7 +2938,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	}
 
-#ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
 			3600000);
@@ -2951,7 +2950,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_180))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
-#endif /* CONFIG_REGULATOR */
 
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
-- 
1.7.0.4


From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v5 02/13] mmc: sdhci: refine voltage support caps setting
Date: Fri, 28 Sep 2012 15:56:01 +0800
Message-ID: <1348818972-26711-3-git-send-email-keyuan.liu@gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:38079 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752619Ab2I1IBs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 04:01:48 -0400
In-Reply-To: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

No need to disable the voltage support caps if
it was NOT supported originally

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9be6a8c..3aef580 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2929,15 +2929,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
 			3300000);
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_330))
 			caps[0] &= ~SDHCI_CAN_VDD_330;
 		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
 			3000000);
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_300))
 			caps[0] &= ~SDHCI_CAN_VDD_300;
 		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
 			1800000);
-		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
+		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_180))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
 #endif /* CONFIG_REGULATOR */
-- 
1.7.0.4


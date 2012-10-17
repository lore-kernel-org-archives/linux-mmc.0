From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v6 02/14] mmc: sdhci: refine voltage support caps setting
Date: Wed, 17 Oct 2012 19:04:41 +0800
Message-ID: <1350471893-29633-3-git-send-email-keyuan.liu@gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48835 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756255Ab2JQLFJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 07:05:09 -0400
In-Reply-To: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
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
index dc493ba..94dab9c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2920,15 +2920,15 @@ int sdhci_add_host(struct sdhci_host *host)
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


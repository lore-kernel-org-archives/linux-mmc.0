From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v5 03/13] mmc: sdhci: use regulator min/max voltage range according to spec
Date: Fri, 28 Sep 2012 15:56:02 +0800
Message-ID: <1348818972-26711-4-git-send-email-keyuan.liu@gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42571 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756923Ab2I1IBy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 04:01:54 -0400
In-Reply-To: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Jialing Fu <jlfu@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

For regulator vmmc/vmmcq, use voltage range as below
3.3v/3.0v: (2.7v, 3.6v)
1.8v: (1.7v, 1.95v)
Original code use the specific value which may fail in regulator
driver if it does NOT support the specific voltage.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3aef580..36afd47 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1628,7 +1628,7 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	if (host->vqmmc) {
-		ret = regulator_set_voltage(host->vqmmc, 3300000, 3300000);
+		ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
 		if (ret) {
 			pr_warning("%s: Switching to 3.3V signalling voltage "
 				   " failed\n", mmc_hostname(host->mmc));
@@ -1672,7 +1672,7 @@ static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 		 */
 		if (host->vqmmc)
 			ret = regulator_set_voltage(host->vqmmc,
-				1800000, 1800000);
+				1700000, 1950000);
 		else
 			ret = 0;
 
@@ -2856,7 +2856,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
 		host->vqmmc = NULL;
 	}
-	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
+	else if (regulator_is_supported_voltage(host->vqmmc, 1700000, 1950000))
 		regulator_enable(host->vqmmc);
 	else
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
@@ -2927,16 +2927,14 @@ int sdhci_add_host(struct sdhci_host *host)
 
 #ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
-		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
-			3300000);
+		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
+			3600000);
 		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_330))
 			caps[0] &= ~SDHCI_CAN_VDD_330;
-		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
-			3000000);
 		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_300))
 			caps[0] &= ~SDHCI_CAN_VDD_300;
-		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
-			1800000);
+		ret = regulator_is_supported_voltage(host->vmmc, 1700000,
+			1950000);
 		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_180))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
-- 
1.7.0.4


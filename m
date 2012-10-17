From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v6 13/14] mmc: sdhci: solve several vmmc/vqmmc regulator issues
Date: Wed, 17 Oct 2012 19:04:52 +0800
Message-ID: <1350471893-29633-14-git-send-email-keyuan.liu@gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38393 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756587Ab2JQLFj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 07:05:39 -0400
In-Reply-To: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

1. The vmmc regulator enable in sdhci_add_host is NOT necessary since
it can be enabled during mmc_power_up by function mmc_regulator_set_ocr.
And this extra enable will make regulator_enable/regulator_disable
unbalanced. Consequently, vmmc can't be disabled during mmc_power_off.

2. If regulator vqmmc exist, it should be enabled regardless it support
1.8v or not.

3. If regulator framework is disabled, regulator_get will return NULL.
So the CONFIG_REGULATOR judgement can be removed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 522e501..9f44efd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2921,12 +2921,14 @@ int sdhci_add_host(struct sdhci_host *host)
 				mmc_hostname(mmc));
 			host->vqmmc = NULL;
 		}
-	}
-	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
+	} else {
 		regulator_enable(host->vqmmc);
-	else
-		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
-		       SDHCI_SUPPORT_DDR50);
+		if (!regulator_is_supported_voltage(host->vqmmc, 1800000,
+			1800000))
+			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
+					SDHCI_SUPPORT_SDR50 |
+					SDHCI_SUPPORT_DDR50);
+	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
@@ -2982,10 +2984,8 @@ int sdhci_add_host(struct sdhci_host *host)
 				mmc_hostname(mmc));
 			host->vmmc = NULL;
 		}
-	} else
-		regulator_enable(host->vmmc);
+	}
 
-#ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
 			3300000);
@@ -3000,7 +3000,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		if ((ret <= 0) && (caps[0] & SDHCI_CAN_VDD_180))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
-#endif /* CONFIG_REGULATOR */
 
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
-- 
1.7.0.4


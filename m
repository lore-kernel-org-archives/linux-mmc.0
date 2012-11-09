From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 8/8] mmc: sdhci: fix coding style in sdhci_add_host
Date: Fri,  9 Nov 2012 17:09:58 +0530
Message-ID: <1352461198-21941-9-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47cac71..5cddb74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2786,16 +2786,18 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->ops = &sdhci_ops;
 	mmc->f_max = host->max_clk;
-	if (host->ops->get_min_clock)
+	if (host->ops->get_min_clock) {
 		mmc->f_min = host->ops->get_min_clock(host);
-	else if (host->version >= SDHCI_SPEC_300) {
+	} else if (host->version >= SDHCI_SPEC_300) {
 		if (host->clk_mul) {
 			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
 			mmc->f_max = host->max_clk * host->clk_mul;
-		} else
+		} else {
 			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
-	} else
+		}
+	} else {
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
+	}
 
 	host->timeout_clk =
 		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
@@ -2860,12 +2862,13 @@ int sdhci_add_host(struct sdhci_host *host)
 				mmc_hostname(mmc));
 			host->vqmmc = NULL;
 		}
-	}
-	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
+	} else if (regulator_is_supported_voltage(host->vqmmc,
+				1800000, 1800000)) {
 		regulator_enable(host->vqmmc);
-	else
+	} else {
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);
+	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
@@ -2921,8 +2924,9 @@ int sdhci_add_host(struct sdhci_host *host)
 				mmc_hostname(mmc));
 			host->vmmc = NULL;
 		}
-	} else
+	} else {
 		regulator_enable(host->vmmc);
+	}
 
 #ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
-- 
1.7.4.1

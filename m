From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: sdhci: do not try to use 3.3V signaling if not supported
Date: Thu,  5 Jul 2018 14:18:19 +0200
Message-ID: <20180705121819.7157-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: marcel@ziswiler.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

For eMMC devices it is valid to only support 1.8V signaling. When
vqmmc is set to a fixed 1.8V regulator the stack tries to set 3.3V
initially and prints the following warning:
   mmc1: Switching to 3.3V signalling voltage failed

Clear the MMC_SIGNAL_VOLTAGE_330 flag in case 3.3V is signaling is
not available. This prevents the stack from even trying to use
3.3V signaling and avoids the above warning.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0e9905..a7b5602ef6f7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3734,14 +3734,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 	    mmc_gpio_get_cd(host->mmc) < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = regulator_enable(mmc->supply.vqmmc);
+
+		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
 					 SDHCI_SUPPORT_SDR50 |
 					 SDHCI_SUPPORT_DDR50);
+
+		/* In eMMC case vqmmc might be a fixed 1.8V regulator */
+		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
+						    3600000))
+			host->flags &= ~SDHCI_SIGNALING_330;
+
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
-- 
2.18.0

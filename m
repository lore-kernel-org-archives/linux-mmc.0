From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection
Date: Tue, 28 Mar 2017 11:00:45 +0200
Message-ID: <20170328090045.2133-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>, "# 4 . 4+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

The controller has different timings for MMC_TIMING_UHS_DDR50 and
MMC_TIMING_MMC_DDR52. Configuring the controller with SDHCI_CTRL_UHS_DDR50,
when MMC_TIMING_MMC_DDR52 timings are requested, is not correct and can
lead to unexpected behavior.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Cc: <stable@vger.kernel.org> # 4.4+
---

Hi,

Here is the proper fix (I hope!) to the issue I have since commit e173f8911f09
("mmc: core: Update CMD13 polling policy when switch to HS DDR mode"). This
commit was probably not the root cause but causes some side effect due to a
bad timing configuration.

I can't explain how it was working before but for sure I was not configuring
properly the controller timings.

Regards


 drivers/mmc/host/sdhci-of-at91.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 814571f..7611fd6 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -29,6 +29,8 @@
 
 #include "sdhci-pltfm.h"
 
+#define SDMMC_MC1R	0x204
+#define		SDMMC_MC1R_DDR		BIT(3)
 #define SDMMC_CACR	0x230
 #define		SDMMC_CACR_CAPWREN	BIT(0)
 #define		SDMMC_CACR_KEY		(0x46 << 8)
@@ -101,11 +103,18 @@ static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
 	sdhci_set_power_noreg(host, mode, vdd);
 }
 
+void sdhci_at91_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	if (timing == MMC_TIMING_MMC_DDR52)
+		sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
+	sdhci_set_uhs_signaling(host, timing);
+}
+
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
 	.set_clock		= sdhci_at91_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_reset,
-	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.set_uhs_signaling	= sdhci_at91_set_uhs_signaling,
 	.set_power		= sdhci_at91_set_power,
 };
 
-- 
2.9.0

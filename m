From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654
Date: Tue, 2 Jul 2019 21:36:31 +0800
Message-ID: <20190702133631.47760-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-mmc@vger.kernel.org

Fix build error:

drivers/mmc/host/sdhci_am654.o: In function `sdhci_am654_probe':
drivers/mmc/host/sdhci_am654.c:464: undefined reference to `__devm_regmap_init_mmio_clk'
drivers/mmc/host/sdhci_am654.o:(.debug_addr+0x3f8): undefined reference to `__devm_regmap_init_mmio_clk'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: aff88ff23512 ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 931770f..14d89a1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -996,7 +996,7 @@ config MMC_SDHCI_OMAP
 
 config MMC_SDHCI_AM654
 	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
-	depends on MMC_SDHCI_PLTFM && OF
+	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
2.7.4

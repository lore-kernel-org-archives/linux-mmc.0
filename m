From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5] mmc: host: sdhci: Fix the incorrect soft reset operation when runtime resuming
Date: Thu, 25 Jul 2019 11:14:22 +0800
Message-ID: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ben-linux@fluff.org, jh80.chung@samsung.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, huziji@marvell.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, baolin.wang@linaro.org, vincent.guittot@linaro.org
List-Id: linux-mmc@vger.kernel.org

The SD host controller specification defines 3 types software reset:
software reset for data line, software reset for command line and
software reset for all. Software reset for all means this reset affects
the entire Host controller except for the card detection circuit.

In sdhci_runtime_resume_host() function, now we will always do software
reset for all, which will cause Spreadtrum host controller work abnormally
after resuming. For Spreadtrum platform that will not power down the SD/eMMC
card during runtime suspend, we should just do software reset for data
and command instead doing reset for all.

To fix this issue, this patch introduces a new parameter of
sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
be done or not. Meanwhile changes other host drivers to issue a software
reset for all to keep the original logic.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v4:
 - Update the commit message.
 - Add a new parameter to decide if a 'reset for all' shall be done or not.

Changes from v3:
 - Use ios.power_mode to validate if the card is power down or not.

Changes from v2:
 - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().

Changes from v1:
 - Add a specific reset operation instead of changing the core to avoid
 affecting other hardware.
---
 drivers/mmc/host/sdhci-acpi.c      |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 drivers/mmc/host/sdhci-of-at91.c   |    2 +-
 drivers/mmc/host/sdhci-pci-core.c  |    4 ++--
 drivers/mmc/host/sdhci-pxav3.c     |    2 +-
 drivers/mmc/host/sdhci-s3c.c       |    2 +-
 drivers/mmc/host/sdhci-sprd.c      |    2 +-
 drivers/mmc/host/sdhci-xenon.c     |    2 +-
 drivers/mmc/host/sdhci.c           |    4 ++--
 drivers/mmc/host/sdhci.h           |    2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b3a130a..1604f51 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -883,7 +883,7 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 
 	sdhci_acpi_byt_setting(&c->pdev->dev);
 
-	return sdhci_runtime_resume_host(c->host);
+	return sdhci_runtime_resume_host(c->host, 0);
 }
 
 #endif
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c391510..776a942 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1705,7 +1705,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 	}
 
-	err = sdhci_runtime_resume_host(host);
+	err = sdhci_runtime_resume_host(host, 0);
 	if (err)
 		goto disable_ipg_clk;
 
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index e377b9b..d4e7e8b 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -289,7 +289,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	}
 
 out:
-	return sdhci_runtime_resume_host(host);
+	return sdhci_runtime_resume_host(host, 0);
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4041878..7d06e28 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -167,7 +167,7 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
 
 err_pci_runtime_suspend:
 	while (--i >= 0)
-		sdhci_runtime_resume_host(chip->slots[i]->host);
+		sdhci_runtime_resume_host(chip->slots[i]->host, 0);
 	return ret;
 }
 
@@ -181,7 +181,7 @@ static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
 		if (!slot)
 			continue;
 
-		ret = sdhci_runtime_resume_host(slot->host);
+		ret = sdhci_runtime_resume_host(slot->host, 0);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3ddecf4..e55037c 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -554,7 +554,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
-	return sdhci_runtime_resume_host(host);
+	return sdhci_runtime_resume_host(host, 0);
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e4a8ba..f5753ae 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -745,7 +745,7 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 	clk_prepare_enable(busclk);
 	if (ourhost->cur_clk >= 0)
 		clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
-	ret = sdhci_runtime_resume_host(host);
+	ret = sdhci_runtime_resume_host(host, 0);
 	return ret;
 }
 #endif
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 603a5d9..83a4767 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -696,7 +696,7 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 	if (ret)
 		goto clk_disable;
 
-	sdhci_runtime_resume_host(host);
+	sdhci_runtime_resume_host(host, 1);
 	return 0;
 
 clk_disable:
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 8a18f14..1dea1ba 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -638,7 +638,7 @@ static int xenon_runtime_resume(struct device *dev)
 		priv->restore_needed = false;
 	}
 
-	ret = sdhci_runtime_resume_host(host);
+	ret = sdhci_runtime_resume_host(host, 0);
 	if (ret)
 		goto out;
 	return 0;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e..4e9ebc8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3320,7 +3320,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
-int sdhci_runtime_resume_host(struct sdhci_host *host)
+int sdhci_runtime_resume_host(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
@@ -3331,7 +3331,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	sdhci_init(host, 0);
+	sdhci_init(host, soft);
 
 	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
 	    mmc->ios.power_mode != MMC_POWER_OFF) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 89fd965..f3cd516 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -781,7 +781,7 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
-int sdhci_runtime_resume_host(struct sdhci_host *host);
+int sdhci_runtime_resume_host(struct sdhci_host *host, int soft);
 #endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
-- 
1.7.9.5

From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under special conditions
Date: Fri, 29 Mar 2019 19:52:01 +0530
Message-ID: <20190329142202.15000-2-faiz_abbas@ti.com>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329142202.15000-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Some controllers on TI devices requires the HISPD bit to be cleared
even in some high speed modes. Add a quirk that facilitates this
requirement.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..ed4ed6054ddf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
-		if (ios->timing == MMC_TIMING_SD_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS ||
-		     ios->timing == MMC_TIMING_MMC_HS400 ||
-		     ios->timing == MMC_TIMING_MMC_HS200 ||
-		     ios->timing == MMC_TIMING_MMC_DDR52 ||
-		     ios->timing == MMC_TIMING_UHS_SDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR104 ||
-		     ios->timing == MMC_TIMING_UHS_DDR50 ||
-		     ios->timing == MMC_TIMING_UHS_SDR25)
-			ctrl |= SDHCI_CTRL_HISPD;
-		else
-			ctrl &= ~SDHCI_CTRL_HISPD;
+		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
+			if (ios->timing == MMC_TIMING_MMC_HS400 ||
+			    ios->timing == MMC_TIMING_MMC_HS200 ||
+			    ios->timing == MMC_TIMING_MMC_DDR52 ||
+			    ios->timing == MMC_TIMING_UHS_SDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR104 ||
+			    ios->timing == MMC_TIMING_UHS_DDR50)
+				ctrl |= SDHCI_CTRL_HISPD;
+			else
+				ctrl &= ~SDHCI_CTRL_HISPD;
+		} else {
+			if (ios->timing == MMC_TIMING_SD_HS ||
+			    ios->timing == MMC_TIMING_MMC_HS ||
+			    ios->timing == MMC_TIMING_MMC_HS400 ||
+			    ios->timing == MMC_TIMING_MMC_HS200 ||
+			    ios->timing == MMC_TIMING_MMC_DDR52 ||
+			    ios->timing == MMC_TIMING_UHS_SDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR104 ||
+			    ios->timing == MMC_TIMING_UHS_DDR50 ||
+			    ios->timing == MMC_TIMING_UHS_SDR25)
+				ctrl |= SDHCI_CTRL_HISPD;
+			else
+				ctrl &= ~SDHCI_CTRL_HISPD;
+		}
 	}
 
 	if (host->version >= SDHCI_SPEC_300) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..aac026c5e184 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -485,6 +485,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Some TI devices need the high speed bit disabled even in high speed modes */
+#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.19.2

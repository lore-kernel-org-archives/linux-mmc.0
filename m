From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
Date: Thu, 28 Nov 2019 16:34:22 +0530
Message-ID: <20191128110422.25917-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, alcooperx@gmail.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.

This commit aims to treat SD High speed and SDR25 as the same while
setting UHS Timings in HOST_CONTROL2 which leads to failures with some
SD cards in AM65x. Revert this commit.

The issue this commit was trying to fix can be implemented in a platform
specific callback instead of common sdhci code.

Cc: <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..296d955ede59 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1882,9 +1882,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 	else if (timing == MMC_TIMING_UHS_SDR12)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-	else if (timing == MMC_TIMING_SD_HS ||
-		 timing == MMC_TIMING_MMC_HS ||
-		 timing == MMC_TIMING_UHS_SDR25)
+	else if (timing == MMC_TIMING_UHS_SDR25)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 	else if (timing == MMC_TIMING_UHS_SDR50)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-- 
2.19.2

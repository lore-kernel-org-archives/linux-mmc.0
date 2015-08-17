From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2] mmc: sdhci: also set driver type for MMC_DDR52
Date: Mon, 17 Aug 2015 19:47:21 +0800
Message-ID: <1439812041-6596-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

commit bb8175a8aa42 ("mmc: sdhci: clarify DDR timing mode between
SD-UHS and eMMC") added MMC_DDR52 as eMMC's DDR mode to be
distinguished from SD-UHS, but it missed setting driver type for
MMC_DDR52 timing mode. This patches adds the missing driver type
setting.

Fixes: bb8175a8aa42 ("mmc: sdhci: clarify DDR timing mode ...")
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..32f2a07 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1559,7 +1559,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
 				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
 				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
-				 (ios->timing == MMC_TIMING_UHS_DDR50))) {
+				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
+				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
-- 
2.5.0

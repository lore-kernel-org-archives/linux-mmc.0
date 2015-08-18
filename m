From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v3] mmc: sdhci: also get preset value and driver type for MMC_DDR52
Date: Tue, 18 Aug 2015 16:21:39 +0800
Message-ID: <1439886099-5531-1-git-send-email-jszhang@marvell.com>
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
MMC_DDR52 timing mode.

So sometimes we get the following error on Marvell BG2Q DMP board:

[    1.559598] mmcblk0: error -84 transferring data, sector 0, nr 8, cmd
response 0x900, card status 0xb00
[    1.569314] mmcblk0: retrying using single block read
[    1.575676] mmcblk0: error -84 transferring data, sector 2, nr 6, cmd
response 0x900, card status 0x0
[    1.585202] blk_update_request: I/O error, dev mmcblk0, sector 2
[    1.591818] mmcblk0: error -84 transferring data, sector 3, nr 5, cmd
response 0x900, card status 0x0
[    1.601341] blk_update_request: I/O error, dev mmcblk0, sector 3

This patches fixes this by adding the missing driver type setting.

Fixes: bb8175a8aa42 ("mmc: sdhci: clarify DDR timing mode ...")
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Since v2:
  - fix sdhci_get_preset_value for MMC_DDR52
  - add typical emmc error log which this patch intends to fix

 Since v1:
  - correct commit-msg

 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..673d703 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1132,6 +1132,7 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
 		break;
 	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_DDR50);
 		break;
 	case MMC_TIMING_MMC_HS400:
@@ -1559,7 +1560,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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

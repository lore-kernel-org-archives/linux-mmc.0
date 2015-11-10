From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: move the setting of watermark level out of probe
Date: Tue, 10 Nov 2015 17:43:29 +0800
Message-ID: <1447148610-2770-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: haibo.chen@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Currently, we config the watermark_level register only in probe.
This will cause the mmc write operation timeout issue after system
resume back in LPSR mode. Because in LPSR mode, after system resume
back, the watermark_level register(0x44) changes to 0x08000880, which
set the write watermark level as 0, and set the read watermark level
as 128. This value is incorrect.

This patch move the setting of watermark level register out of probe,
so after system resume back, mmc driver can set this watermark level
register back to 0x10401040.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1f1582f..1508949 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -584,6 +584,14 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		mask = 0xffff & ~(ESDHC_CTRL_BUSWIDTH_MASK | ESDHC_CTRL_D3CD);
 
 		esdhc_clrset_le(host, mask, new_val, reg);
+
+		/*
+		 * The imx6q/imx7d ROM code will change the default watermark
+		 * level setting to something insane.  Change it back here.
+		 */
+		 if (esdhc_is_usdhc(imx_data))
+			 writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+
 		return;
 	}
 	esdhc_clrset_le(host, 0xff, val, reg);
@@ -1155,13 +1163,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
 
-	/*
-	 * The imx6q ROM code will change the default watermark level setting
-	 * to something insane.  Change it back here.
-	 */
 	if (esdhc_is_usdhc(imx_data)) {
-		writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
-
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
1.9.1

From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 4/5] mmc: sdhci-pxav3: Fix HS200 mode support
Date: Fri,  4 Sep 2015 21:02:20 +0530
Message-ID: <1441380741-13115-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kliu5@marvell.com, ulf.hansson@linaro.org, Tim Wang <wangtt@marvell.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Kevin Liu <kliu5@marvell.com>

IN case of MMC HS200 mode, current code does not enable
SD_CE_ATA_2.MMC_HS200 & SD_CE_ATA_2.MMC_CARD bit configurations.

So this patch updates the above bit fields correctly.

Signed-off-by: Tim Wang <wangtt@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
Note: Unfortunately I do not have access to any other datasheets
which uses sdhci-pxav3 driver, so quite not sure whether this would
break any existing platform, probably NOT, as I do not see any
references for this change.
If anyone can confirm that would be really great.

 drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d933f75..6978810 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -57,6 +57,8 @@
 #define SD_CE_ATA_1			0x10C
 
 #define SD_CE_ATA_2			0x10E
+#define  SD_CE_ATA2_HS200_EN		BIT(10)
+#define  SD_CE_ATA2_MMC_MODE		BIT(12)
 #define  SDCE_MISC_INT			BIT(2)
 #define  SDCE_MISC_INT_EN		BIT(1)
 
@@ -330,6 +332,17 @@ static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
 	return pinctrl_select_state(pxa->pinctrl, pinctrl);
 }
 
+static int pxav3_select_hs200(struct sdhci_host *host)
+{
+	u16 reg = 0;
+
+	reg = sdhci_readw(host, SD_CE_ATA_2);
+	reg |= SD_CE_ATA2_HS200_EN | SD_CE_ATA2_MMC_MODE;
+	sdhci_writew(host, reg, SD_CE_ATA_2);
+
+	return 0;
+}
+
 static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -361,6 +374,10 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	case MMC_TIMING_UHS_DDR50:
 		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
 		break;
+	case MMC_TIMING_MMC_HS200:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
+		pxav3_select_hs200(host);
+		break;
 	}
 
 	/*
-- 
1.9.1

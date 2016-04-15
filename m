From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 22/23] mmc: sdhci-esdhc-imx: move tuning static configuration
 into hwinit function
Date: Sat, 16 Apr 2016 01:29:46 +0800
Message-ID: <1460741387-23815-23-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Move tuning static configuration into hwinit function.
Tuning configuration may also be lost in low power mode,
so need restore in hwinit().

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 95f3632..98aa6b5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -483,7 +483,6 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			u32 tuning_ctrl;
 			if (val & SDHCI_CTRL_TUNED_CLK) {
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
 			} else {
@@ -496,18 +495,6 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
 				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
-				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
-				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
-				if (imx_data->boarddata.tuning_start_tap) {
-					tuning_ctrl &= ~ESDHC_TUNING_START_TAP_MASK;
-					tuning_ctrl |= imx_data->boarddata.tuning_start_tap;
-				}
-
-				if (imx_data->boarddata.tuning_step) {
-					tuning_ctrl &= ~ESDHC_TUNING_STEP_MASK;
-					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
-				}
-				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -982,6 +969,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int tmp;
 
 	if (esdhc_is_usdhc(imx_data)) {
 		/*
@@ -1013,6 +1001,23 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 
 		/* disable DLL_CTRL delay line settings */
 		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
+
+		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			tmp |= ESDHC_STD_TUNING_EN |
+				ESDHC_TUNING_START_TAP_DEFAULT;
+			if (imx_data->boarddata.tuning_start_tap) {
+				tmp &= ~ESDHC_TUNING_START_TAP_MASK;
+				tmp |= imx_data->boarddata.tuning_start_tap;
+			}
+
+			if (imx_data->boarddata.tuning_step) {
+				tmp &= ~ESDHC_TUNING_STEP_MASK;
+				tmp |= imx_data->boarddata.tuning_step
+					<< ESDHC_TUNING_STEP_SHIFT;
+			}
+			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
+		}
 	}
 }
 
@@ -1226,11 +1231,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
-		writel(readl(host->ioaddr + ESDHC_TUNING_CTRL) |
-			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT,
-			host->ioaddr + ESDHC_TUNING_CTRL);
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-- 
1.9.1

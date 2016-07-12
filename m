From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 12/15] mmc: sdhci-esdhc-imx: factor out hw related
 initialization into function
Date: Tue, 12 Jul 2016 15:46:21 +0800
Message-ID: <1468309584-3591-13-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
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

Move all hw related static initializations into a separate function
which helps concentrate the hw related initialization code.
And that function could also be called by other places later as a
basic hw state restore.
e.g. suspend/resume where the hw state is possible to lost due to
low power mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 72 +++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bbb0bd4eac28..5a0e5dee977f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -979,6 +979,44 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
+static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	if (esdhc_is_usdhc(imx_data)) {
+		/*
+		 * The imx6q ROM code will change the default watermark
+		 * level setting to something insane.  Change it back here.
+		 */
+		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
+
+		/*
+		 * ROM code will change the bit burst_length_enable setting
+		 * to zero if this usdhc is choosed to boot system. Change
+		 * it back here, otherwise it will impact the performance a
+		 * lot. This bit is used to enable/disable the burst length
+		 * for the external AHB2AXI bridge, it's usefully especially
+		 * for INCR transfer because without burst length indicator,
+		 * the AHB2AXI bridge does not know the burst length in
+		 * advance. And without burst length indicator, AHB INCR
+		 * transfer can only be converted to singles on the AXI side.
+		 */
+		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
+			| ESDHC_BURST_LEN_EN_INCR,
+			host->ioaddr + SDHCI_HOST_CONTROL);
+		/*
+		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
+		* TO1.1, it's harmless for MX6SL
+		*/
+		writel(readl(host->ioaddr + 0x6c) | BIT(7),
+			host->ioaddr + 0x6c);
+
+		/* disable DLL_CTRL delay line settings */
+		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
+	}
+}
+
 #ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
@@ -1176,43 +1214,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
 
-	/*
-	 * The imx6q ROM code will change the default watermark level setting
-	 * to something insane.  Change it back here.
-	 */
 	if (esdhc_is_usdhc(imx_data)) {
-		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
-
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
-
-		/*
-		 * ROM code will change the bit burst_length_enable setting
-		 * to zero if this usdhc is choosed to boot system. Change
-		 * it back here, otherwise it will impact the performance a
-		 * lot. This bit is used to enable/disable the burst length
-		 * for the external AHB2AXI bridge, it's usefully especially
-		 * for INCR transfer because without burst length indicator,
-		 * the AHB2AXI bridge does not know the burst length in
-		 * advance. And without burst length indicator, AHB INCR
-		 * transfer can only be converted to singles on the AXI side.
-		 */
-		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
-			| ESDHC_BURST_LEN_EN_INCR,
-			host->ioaddr + SDHCI_HOST_CONTROL);
-
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
-
-		/*
-		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
-		* TO1.1, it's harmless for MX6SL
-		*/
-		writel(readl(host->ioaddr + 0x6c) | BIT(7),
-			host->ioaddr + 0x6c);
-
-		/* disable DLL_CTRL delay line settings */
-		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
@@ -1237,6 +1243,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_clk;
 
+	sdhci_esdhc_imx_hwinit(host);
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
-- 
1.9.1

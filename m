From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v2 1/3] mmc: sdhci-pxav3: Fix tabbing issue
Date: Mon,  7 Sep 2015 17:01:09 +0530
Message-ID: <1441625471-16315-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
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
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

There were some coding style issues where spaces have been used instead
of tabs, for example, in macro definitions, alignment of function
declarations/definitions, etc...

This patch fixes all such occurrences in the code.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 946d37f..7a07177 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -39,24 +39,24 @@
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
-#define PXAV3_RPM_DELAY_MS     50
+#define PXAV3_RPM_DELAY_MS		50
 
-#define SD_CLOCK_BURST_SIZE_SETUP		0x10A
-#define SDCLK_SEL	0x100
-#define SDCLK_DELAY_SHIFT	9
-#define SDCLK_DELAY_MASK	0x1f
+#define SD_CLOCK_BURST_SIZE_SETUP	0x10A
+#define SDCLK_SEL			0x100
+#define  SDCLK_DELAY_SHIFT		9
+#define  SDCLK_DELAY_MASK		0x1f
 
-#define SD_CFG_FIFO_PARAM       0x100
-#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
-#define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
-#define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
+#define SD_CFG_FIFO_PARAM		0x100
+#define  SDCFG_GEN_PAD_CLK_ON		(1<<6)
+#define  SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
+#define  SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
 
-#define SD_SPI_MODE          0x108
-#define SD_CE_ATA_1          0x10C
+#define SD_SPI_MODE			0x108
+#define SD_CE_ATA_1			0x10C
 
-#define SD_CE_ATA_2          0x10E
-#define SDCE_MISC_INT		(1<<2)
-#define SDCE_MISC_INT_EN	(1<<1)
+#define SD_CE_ATA_2			0x10E
+#define  SDCE_MISC_INT			(1<<2)
+#define  SDCE_MISC_INT_EN		(1<<1)
 
 struct sdhci_pxa {
 	struct clk *clk_core;
@@ -284,7 +284,7 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	 * FE-2946959
 	 */
 	if (pxa->sdio3_conf_reg) {
-		u8 reg_val  = readb(pxa->sdio3_conf_reg);
+		u8 reg_val = readb(pxa->sdio3_conf_reg);
 
 		if (uhs == MMC_TIMING_UHS_SDR50 ||
 		    uhs == MMC_TIMING_UHS_DDR50) {
@@ -304,20 +304,20 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
-	.set_clock = sdhci_set_clock,
-	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.set_bus_width = sdhci_set_bus_width,
-	.reset = pxav3_reset,
-	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.set_clock			= sdhci_set_clock,
+	.platform_send_init_74_clocks	= pxav3_gen_init_74_clocks,
+	.get_max_clock			= sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width			= sdhci_set_bus_width,
+	.reset				= pxav3_reset,
+	.set_uhs_signaling		= pxav3_set_uhs_signaling,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
+	.quirks	= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 		| SDHCI_QUIRK_32BIT_ADMA_SIZE
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.ops = &pxav3_sdhci_ops,
+	.ops	= &pxav3_sdhci_ops,
 };
 
 #ifdef CONFIG_OF
-- 
1.9.1

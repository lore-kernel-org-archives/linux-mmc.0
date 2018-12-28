From: BOUGH CHEN <haibo.chen@nxp.com>
Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Date: Fri, 28 Dec 2018 03:26:10 +0000
Message-ID: <20181228033323.32308-2-haibo.chen@nxp.com>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

i.MX6ULL has errata ERR010450, point out that due to SOC I/O
timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
DDR50 mode, the clock rate can't exceed 45MHz.

This patch add this limit for imx6ull.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7cfcc8618e45..e1d9b2985979 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -138,7 +138,11 @@
 #define ESDHC_FLAG_HS200		BIT(8)
 /* The IP supports HS400 mode */
 #define ESDHC_FLAG_HS400		BIT(9)
-
+/* The IP has errata ERR010450
+ * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
+ * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ */
+#define ESDHC_FLAG_ERR010450           BIT(10)
 /* A clock frequency higher than this rate requires strobe dll control */
 #define ESDHC_STROBE_DLL_CLK_FREQ	100000000
 
@@ -177,6 +181,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
+static struct esdhc_soc_data usdhc_imx6ull_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_ERR010450,
+};
+
 static struct esdhc_soc_data usdhc_imx7d_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
@@ -227,6 +237,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
+	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
 	{ /* sentinel */ }
 };
@@ -733,6 +744,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+		unsigned int max_clock;
+
+		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
+
+		clock = min(clock, max_clock);
+	}
+
 	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
 			pre_div < 256)
 		pre_div *= 2;
-- 
2.17.1

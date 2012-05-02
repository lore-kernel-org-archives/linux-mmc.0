From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 3/3] mmc: sdhci-imx-esdhc: convert to use pinctrl subsystem
Date: Wed, 2 May 2012 19:31:22 +0800
Message-ID: <1335958282-3068-3-git-send-email-b29396@freescale.com>
References: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:13769
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab2EBLXT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 07:23:19 -0400
In-Reply-To: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, linus.walleij@stericsson.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, w.sang@pengutronix.de, linux-mmc@vger.kernel.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
ChangeLog v4->v5:
 *split arch/arm/mach-imx/* changes into a separate patch
ChangeLog v3->v4:
 * call provide dummies in imx*_soc_init().
ChangeLog v2->v3:
 * patch name updated.
   v1 name is ARM: imx6q: switch to use pinctrl driver
 * using pinctrl dummy state to avoid breaking other platforms to use this
   driver.
ChangeLog v1->v2:
 * using updated binding
---
 arch/arm/boot/dts/imx6q-arm2.dts   |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi       |   32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..34dd9cd 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -37,12 +37,16 @@
 				cd-gpios = <&gpio6 11 0>;
 				wp-gpios = <&gpio6 14 0>;
 				vmmc-supply = <&reg_3p3v>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc3_1>;
 				status = "okay";
 			};
 
 			usdhc@0219c000 { /* uSDHC4 */
 				fsl,card-wired;
 				vmmc-supply = <&reg_3p3v>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc4_1>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 4905f51..a89f294 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -386,7 +386,39 @@
 			};
 
 			iomuxc@020e0000 {
+				compatible = "fsl,imx6q-iomuxc";
 				reg = <0x020e0000 0x4000>;
+
+				/* shared pinctrl settings */
+				usdhc3 {
+					pinctrl_usdhc3_1: usdhc3grp-1 {
+						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							    1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							    1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							    1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							    1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							    1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+							    1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
+							    1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
+							    1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
+							    1241 0x17059>;	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
+					};
+				};
+
+				usdhc4 {
+					pinctrl_usdhc4_1: usdhc4grp-1 {
+						fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+							    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
+							    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
+							    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
+							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+					};
+				};
 			};
 
 			dcic@020e4000 { /* DCIC1 */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6193a0d..039bc19 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <mach/esdhc.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -68,6 +69,7 @@ struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
 	enum imx_esdhc_type devtype;
+	struct pinctrl *pinctrl;
 	struct esdhc_platform_data boarddata;
 };
 
@@ -467,6 +469,12 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
+	imx_data->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(imx_data->pinctrl)) {
+		err = PTR_ERR(imx_data->pinctrl);
+		goto pin_err;
+	}
+
 	if (!is_imx25_esdhc(imx_data))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
@@ -559,6 +567,7 @@ no_card_detect_irq:
 		gpio_free(boarddata->wp_gpio);
 no_card_detect_pin:
 no_board_data:
+pin_err:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
-- 
1.7.0.4



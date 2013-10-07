From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: Remove custom properties
Date: Mon, 7 Oct 2013 14:32:24 -0300
Message-ID: <1381167144-18098-2-git-send-email-fabio.estevam@freescale.com>
References: <1381167144-18098-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381167144-18098-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

According to Documentation/devicetree/bindings/mmc/mmc.txt:

"Card detection:
If no property below is supplied, host native card detect is used.
Only one of the properties in this section should be supplied:
  - broken-cd: There is no card detection available; polling must be used.
  - cd-gpios: Specify GPIOs for card detection, see gpio binding
  - non-removable: non-removable slot (like eMMC); assume always present. "

So remove the custom fsl,cd-controller and fsl,wp-controller properties, as the
mmc core can take care of it.

Tested on mx51babbage, mx53qsb boards and mx6qsabresd boards.

Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 6 ------
 drivers/mmc/host/sdhci-esdhc-imx.c                      | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 1dd6225..5da8ab0 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -9,18 +9,12 @@ by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
 Required properties:
 - compatible : Should be "fsl,<chip>-esdhc"
 
-Optional properties:
-- fsl,cd-controller : Indicate to use controller internal card detection
-- fsl,wp-controller : Indicate to use controller internal write protection
-
 Examples:
 
 esdhc@70004000 {
 	compatible = "fsl,imx51-esdhc";
 	reg = <0x70004000 0x4000>;
 	interrupts = <1>;
-	fsl,cd-controller;
-	fsl,wp-controller;
 };
 
 esdhc@70008000 {
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..07662d1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -796,12 +796,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_get_property(np, "non-removable", NULL))
 		boarddata->cd_type = ESDHC_CD_PERMANENT;
 
-	if (of_get_property(np, "fsl,cd-controller", NULL))
-		boarddata->cd_type = ESDHC_CD_CONTROLLER;
-
-	if (of_get_property(np, "fsl,wp-controller", NULL))
-		boarddata->wp_type = ESDHC_WP_CONTROLLER;
-
 	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
 	if (gpio_is_valid(boarddata->cd_gpio))
 		boarddata->cd_type = ESDHC_CD_GPIO;
-- 
1.8.1.2

From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/5] mmc: sdhci-pxav3: fix optional clock name
Date: Mon, 12 Oct 2015 13:46:32 +0800
Message-ID: <1444628796-5484-2-git-send-email-jszhang@marvell.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 8afdc9cca27f ("mmc: sdhci-pxav3: Get optional core clock") adds
additional optional clock support, but the clock names  isn't correct.
The current "io" clock is really the PXAv3 SDHCI IP's "core" clock
which is manadatory. The current "core" clock is really the IP's "axi"
clock which is optional.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  8 ++---
 arch/arm/boot/dts/berlin2.dtsi                     |  6 ++--
 arch/arm/boot/dts/berlin2cd.dtsi                   |  2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    |  2 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 40 +++++++++++-----------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 3d1b449..25d5ba8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -17,9 +17,9 @@ Required properties:
 - reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
   for "marvell,armada-380-sdhci"
 - clocks: Array of clocks required for SDHCI; requires at least one for
-    I/O clock.
+    core clock.
 - clock-names: Array of names corresponding to clocks property; shall be
-    "io" for I/O clock and "core" for optional core clock.
+    "core" for core clock and "axi" for optional axi clock.
 
 Optional properties:
 - mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
@@ -32,7 +32,7 @@ sdhci@d4280800 {
 	bus-width = <8>;
 	interrupts = <27>;
 	clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
-	clock-names = "io", "core";
+	clock-names = "core", "axi";
 	non-removable;
 	mrvl,clk-delay-cycles = <31>;
 };
@@ -45,6 +45,6 @@ sdhci@d8000 {
 		<0x18454 0x4>;
 	interrupts = <0 25 0x4>;
 	clocks = <&gateclk 17>;
-	clock-names = "io";
+	clock-names = "core";
 	mrvl,clk-delay-cycles = <0x1F>;
 };
diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ef811de..9d0a945 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -85,7 +85,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
 			clocks = <&chip_clk CLKID_SDIO0XIN>, <&chip_clk CLKID_SDIO0>;
-			clock-names = "io", "core";
+			clock-names = "core", "axi";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -94,7 +94,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0800 0x200>;
 			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO1>;
-			clock-names = "io", "core";
+			clock-names = "core", "axi";
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -104,7 +104,7 @@
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
-			clock-names = "io", "core";
+			clock-names = "core", "axi";
 			pinctrl-0 = <&emmc_pmux>;
 			pinctrl-names = "default";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d..11498ad 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -82,7 +82,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
 			clocks = <&chip_clk CLKID_SDIO0XIN>, <&chip_clk CLKID_SDIO0>;
-			clock-names = "io", "core";
+			clock-names = "core", "axi";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a4849..4ad585c 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -120,7 +120,7 @@
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
-			clock-names = "io", "core";
+			clock-names = "core", "axi";
 			status = "disabled";
 		};
 
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d..cec95f1 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -59,8 +59,8 @@
 #define SDCE_MISC_INT_EN	(1<<1)
 
 struct sdhci_pxa {
+	struct clk *clk_axi;
 	struct clk *clk_core;
-	struct clk *clk_io;
 	u8	power_mode;
 	void __iomem *sdio3_conf_reg;
 };
@@ -381,20 +381,20 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = pxa;
 
-	pxa->clk_io = devm_clk_get(dev, "io");
-	if (IS_ERR(pxa->clk_io))
-		pxa->clk_io = devm_clk_get(dev, NULL);
-	if (IS_ERR(pxa->clk_io)) {
-		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(pxa->clk_io);
+	pxa->clk_core = devm_clk_get(dev, "core");
+	if (IS_ERR(pxa->clk_core))
+		pxa->clk_core = devm_clk_get(dev, NULL);
+	if (IS_ERR(pxa->clk_core)) {
+		dev_err(dev, "failed to get core clock\n");
+		ret = PTR_ERR(pxa->clk_core);
 		goto err_clk_get;
 	}
-	pltfm_host->clk = pxa->clk_io;
-	clk_prepare_enable(pxa->clk_io);
+	pltfm_host->clk = pxa->clk_core;
+	clk_prepare_enable(pxa->clk_core);
 
-	pxa->clk_core = devm_clk_get(dev, "core");
-	if (!IS_ERR(pxa->clk_core))
-		clk_prepare_enable(pxa->clk_core);
+	pxa->clk_axi = devm_clk_get(dev, "axi");
+	if (!IS_ERR(pxa->clk_axi))
+		clk_prepare_enable(pxa->clk_axi);
 
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
@@ -475,8 +475,8 @@ err_add_host:
 err_of_parse:
 err_cd_req:
 err_mbus_win:
-	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_axi);
 err_clk_get:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -494,8 +494,8 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 1);
 
-	clk_disable_unprepare(pxa->clk_io);
 	clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_axi);
 
 	sdhci_pltfm_free(pdev);
 
@@ -542,9 +542,9 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
+	if (!IS_ERR(pxa->clk_axi))
+		clk_disable_unprepare(pxa->clk_axi);
 
 	return 0;
 }
@@ -555,9 +555,9 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
-	clk_prepare_enable(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_prepare_enable(pxa->clk_core);
+	clk_prepare_enable(pxa->clk_core);
+	if (!IS_ERR(pxa->clk_axi))
+		clk_prepare_enable(pxa->clk_axi);
 
 	return sdhci_runtime_resume_host(host);
 }
-- 
2.6.1


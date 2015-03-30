From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 7/9] mmc: sdhci-st: Update ST SDHCI binding documentation.
Date: Mon, 30 Mar 2015 15:40:00 +0100
Message-ID: <1427726402-7513-8-git-send-email-peter.griffin@linaro.org>
References: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427726402-7513-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patch updates the binding information to reflect the
extra dt options which are now supported by the sdhci-st.c
driver which enable support for stih407 family silicon.

STiH410 SoC and later support UHS modes for eMMC, so the
driver now makes use of these common bindings. Examples
are provided for both eMMC (which has additional bindings)
and also sd slot for STiH407.

Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 ++++++++++++++++++---
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
index 7527db4..18d950d 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
@@ -5,20 +5,62 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties
 used by the sdhci-st driver.
 
 Required properties:
-- compatible :  Must be "st,sdhci"
-- clock-names : Should be "mmc"
-                See: Documentation/devicetree/bindings/resource-names.txt
-- clocks :      Phandle of the clock used by the sdhci controler
-                See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- compatible:		Must be "st,sdhci" and it can be compatible to "st,sdhci-stih407"
+			to set the internal glue logic used for configuring the MMC
+			subsystem (mmcss) inside the FlashSS (available in STiH407 SoC
+			family).
+
+- clock-names:		Should be "mmc".
+			See: Documentation/devicetree/bindings/resource-names.txt
+- clocks:		Phandle to the clock.
+			See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+- interrupts:		One mmc interrupt should be described here.
+- interrupt-names:	Should be "mmcirq".
+
+- pinctrl-names:	A pinctrl state names "default" must be defined.
+- pinctrl-0:		Phandle referencing pin configuration of the sd/emmc controller.
+			See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+- reg:			This must provide the host controller base address and it can also
+			contain the FlashSS Top register for TX/RX delay used by the driver
+			to configure DLL inside the flashSS, if so reg-names must also be
+			specified.
 
 Optional properties:
-- non-removable: non-removable slot
-                 See: Documentation/devicetree/bindings/mmc/mmc.txt
-- bus-width: Number of data lines
-                 See: Documentation/devicetree/bindings/mmc/mmc.txt
+- reg-names:		Should be "mmc" and "top-mmc-delay". "top-mmc-delay" is optional
+			for eMMC on stih407 family silicon to configure DLL inside FlashSS.
+
+- non-removable:	Non-removable slot. Also used for configuring mmcss in STiH407 SoC
+			family.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
+
+- bus-width:		Number of data lines.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
+
+- max-frequency: 	Can be 200MHz, 100Mz or 50MHz (default) and used for
+			configuring the CCONFIG3 in the mmcss.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
+
+- resets:		Phandle and reset specifier pair to softreset line of HC IP.
+			See: Documentation/devicetree/bindings/reset/reset.txt
+
+- vqmmc-supply:		Phandle to the regulator dt node, mentioned as the vcc/vdd
+			supply in eMMC/SD specs.
+
+- sd-uhs--sdr50:	To enable the SDR50 in the mmcss.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
+
+- sd-uhs-sdr104:	To enable the SDR104 in the mmcss.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
+
+- sd-uhs-ddr50:		To enable the DDR50 in the mmcss.
+			See:  Documentation/devicetree/bindings/mmc/mmc.txt.
 
 Example:
 
+/* Example stih416e eMMC configuration */
+
 mmc0: sdhci@fe81e000 {
 	compatible	= "st,sdhci";
 	status		= "disabled";
@@ -29,5 +71,43 @@ mmc0: sdhci@fe81e000 {
 	pinctrl-0	= <&pinctrl_mmc0>;
 	clock-names	= "mmc";
 	clocks		= <&clk_s_a1_ls 1>;
-	bus-width       = <8>
+	bus-width	= <8>
+
+/* Example SD stih407 family configuration */
+
+mmc1: sdhci@09080000 {
+	compatible	= "st,sdhci-stih407", "st,sdhci";
+	status		= "disabled";
+	reg		= <0x09080000 0x7ff>;
+	reg-names	= "mmc";
+	interrupts	= <GIC_SPI 90 IRQ_TYPE_NONE>;
+	interrupt-names	= "mmcirq";
+	pinctrl-names	= "default";
+	pinctrl-0	= <&pinctrl_sd1>;
+	clock-names	= "mmc";
+	clocks		= <&clk_s_c0_flexgen CLK_MMC_1>;
+	resets		= <&softreset STIH407_MMC1_SOFTRESET>;
+	bus-width	= <4>;
+};
+
+/* Example eMMC stih407 family configuration */
+
+mmc0: sdhci@09060000 {
+	compatible	= "st,sdhci-stih407", "st,sdhci";
+	status		= "disabled";
+	reg		= <0x09060000 0x7ff>, <0x9061008 0x20>;
+	reg-names	= "mmc", "top-mmc-delay";
+	interrupts	= <GIC_SPI 92 IRQ_TYPE_NONE>;
+	interrupt-names	= "mmcirq";
+	pinctrl-names	= "default";
+	pinctrl-0	= <&pinctrl_mmc0>;
+	clock-names	= "mmc";
+	clocks		= <&clk_s_c0_flexgen CLK_MMC_0>;
+	vqmmc-supply	= <&vmmc_reg>;
+	max-frequency	= <200000000>;
+	bus-width	= <8>;
+	non-removable;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

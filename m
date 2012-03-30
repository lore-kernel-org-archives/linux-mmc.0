From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Fri, 30 Mar 2012 11:36:04 +0000
Message-ID: <201203301136.05038.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <201203271619.13320.arnd@arndb.de> <4F7553D1.4030008@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54404 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934162Ab2C3LgP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 07:36:15 -0400
In-Reply-To: <4F7553D1.4030008@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, "cjb@laptop.org" <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "patches@linaro.org" <patches@linaro.org>

On Friday 30 March 2012, Viresh Kumar wrote:
> On 3/27/2012 9:49 PM, Arnd Bergmann wrote:
> > These bindings came up in a discussion IRC today. I think it's rather bad that
> > we can't agree on a common way to name the properties for mmc. We have
> > bindings being proposed or already included from Anton, Stephen, Shawn,
> > Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
> > for card detect and write protect, as well properties to define the bus
> > width and high-speed modes, but we seem to have almost as many different
> > definitions of these as we have drivers.
> > 
> > Can we please come up with a common binding for these?
> 
> Is there any progress on this? Sorry i wasn't following all mails.
> How should i progress for sdhci-spear?

No progress so far. I would suggest we apply the patch below to unify
the bindings we have. I tried to minimize the impact by picking the most
common version for each property, but if we know about devices that would
get broken by this, we may have to be more careful.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -0,0 +1,25 @@
+These properties are common to multiple MMC host controllers. Any host
+that requires the respective functionality should implement them using
+these definitions.
+
+Required properties:
+- bus-width: Number of data lines, can be <1>, <4>, or <8>
+
+Optional properties:
+- cd-gpios : Specify GPIOs for card detection, see gpio binding
+- wp-gpios : Specify GPIOs for write protection, see gpio binding
+- cd-inverted: when present, polarity on the wp gpio line is inverted
+- wp-inverted: when present, polarity on the wp gpio line is inverted
+- non-removable: non-removable slot (like eMMC)
+
+Example:
+
+sdhci@ab000000 {
+	compatible = "sdhci";
+	reg = <0xab000000 0x200>;
+	interrupts = <23>;
+	bus-width = <4>;
+	cd-gpios = <&gpio 69 0>;
+	cd-inverted;
+	wp-gpios = <&gpio 70 0>;
+}
diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index 64bcb8b..0d93b4b 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -11,9 +11,11 @@ Required properties:
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
   - sdhci,wp-inverted : (optional) specifies that eSDHC controller
-    reports inverted write-protect state;
+    reports inverted write-protect state; New devices should use
+    the generic "wp-inverted" property.
   - sdhci,1-bit-only : (optional) specifies that a controller can
-    only handle 1-bit data transfers.
+    only handle 1-bit data transfers. New devices should use the
+    generic "bus-width = <1>" property.
   - sdhci,auto-cmd12: (optional) specifies that a controller can
     only handle auto CMD12.
 
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index ab22fe6..c7e404b 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -9,7 +9,7 @@ Required properties:
 - interrupts : Should contain eSDHC interrupt
 
 Optional properties:
-- fsl,card-wired : Indicate the card is wired to host permanently
+- non-removable : Indicate the card is wired to host permanently
 - fsl,cd-internal : Indicate to use controller internal card detection
 - fsl,wp-internal : Indicate to use controller internal write protection
 - cd-gpios : Specify GPIOs for card detection
diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
index 89a0084..d64aea5 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
@@ -10,7 +10,8 @@ Required properties:
 
 Optional properties:
 - gpios : may specify GPIOs in this order: Card-Detect GPIO,
-  Write-Protect GPIO.
+  Write-Protect GPIO. Note that this does not follow the
+  binding from mmc.txt, for historic reasons.
 - interrupts : the interrupt of a card detect interrupt.
 - interrupt-parent : the phandle for the interrupt controller that
   services interrupts for this device.
diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
index 7e51154..690a226 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
@@ -6,13 +6,13 @@ and SDIO types of memory cards.
 Required properties:
 - compatible : Should be "nvidia,<chip>-sdhci"
 - reg : Should contain SD/MMC registers location and length
-- interrupts : Should contain SD/MMC interrupt
+- interrupt  : Should contain SD/MMC interrupt
+- bus-width : Number of data lines, can be <1>, <4>, or <8>
 
 Optional properties:
 - cd-gpios : Specify GPIOs for card detection
 - wp-gpios : Specify GPIOs for write protection
 - power-gpios : Specify GPIOs for power control
-- support-8bit : Boolean, indicates if 8-bit mode should be used.
 
 Example:
 
@@ -23,5 +23,5 @@ sdhci@c8000200 {
 	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
-	support-8bit;
+	bus-width = <8>;
 };
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index dbd4368..90b86e5 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -15,10 +15,10 @@ Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
-ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
+bus-width: Number of data lines, default assumed is 1 if the property is missing.
 cd-gpios: GPIOs for card detection
 wp-gpios: GPIOs for write protection
-ti,non-removable: non-removable slot (like eMMC)
+non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 
 Example:
@@ -27,7 +27,7 @@ Example:
 		reg = <0x4809c000 0x400>;
 		ti,hwmods = "mmc1";
 		ti,dual-volt;
-		ti,bus-width = <4>;
+		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
 		ti,non-removable;
 	};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index c7ee86c..139138a 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -35,7 +35,7 @@
 				};
 
 				esdhc@50008000 { /* ESDHC2 */
-					fsl,card-wired;
+					non-removable;
 					status = "okay";
 				};
 
@@ -76,7 +76,7 @@
 				};
 
 				esdhc@50020000 { /* ESDHC3 */
-					fsl,card-wired;
+					non-removable;
 					status = "okay";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..d2eaf52 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -41,7 +41,7 @@
 			};
 
 			usdhc@0219c000 { /* uSDHC4 */
-				fsl,card-wired;
+				non-removable;
 				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 8c756be..5b4506c 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -57,7 +57,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
-	ti,bus-width = <8>;
+	bus-width = <8>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index ea6f5bb..31fb421 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -55,7 +55,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
-	ti,bus-width = <8>;
+	bus-width = <8>;
 };
 
 &mmc2 {
@@ -72,5 +72,5 @@
 
 &mmc5 {
 	ti,non-removable;
-	ti,bus-width = <4>;
+	bus-width = <4>;
 };
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 67b2e98..a1dd873 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -94,12 +94,12 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
-	ti,bus-width = <8>;
+	bus-width = <8>;
 };
 
 &mmc2 {
 	vmmc-supply = <&vaux1>;
-	ti,bus-width = <8>;
+	bus-width = <8>;
 	ti,non-removable;
 };
 
@@ -112,6 +112,6 @@
 };
 
 &mmc5 {
-	ti,bus-width = <4>;
+	bus-width = <4>;
 	ti,non-removable;
 };
diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index ac3fb75..67c6511 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -54,6 +54,7 @@
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
 		power-gpios = <&gpio 31 0>; /* gpio PD7 */
+		bus-width = <4>;
 	};
 
 	sdhci@78000200 {
@@ -66,5 +67,6 @@
 
 	sdhci@78000400 {
 		support-8bit;
+		bus-width = <8>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 6e8447d..e9cae68 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -100,6 +100,7 @@
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 155 0>; /* gpio PT3 */
+		bus-width = <4>;
 	};
 
 	sdhci@c8000400 {
@@ -111,5 +112,6 @@
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		support-8bit;
+		bus-width = <8>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 6c02abb..03d3d79 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -97,6 +97,7 @@
 		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
 		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
 		power-gpios = <&gpio 169 0>; /* gpio PV1 */
+		bus-width = <4>;
 	};
 
 	sdhci@c8000200 {
@@ -109,6 +110,7 @@
 
 	sdhci@c8000600 {
 		support-8bit;
+		bus-width = <8>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index dbf1c5a..8decf72 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -104,10 +104,12 @@
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		bus-width = <4>;
 	};
 
 	sdhci@c8000600 {
 		support-8bit;
+		bus-width = <8>;
 	};
 
 	usb@c5000000 {
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 2dcff87..29e54c7 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -100,9 +100,11 @@
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		bus-width = <4>;
 	};
 
 	sdhci@c8000600 {
 		support-8bit;
+		bus-width = <8>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 7e283c8..fe0d609 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -119,6 +119,7 @@
 		sdhc@2e000 {
 			status = "disabled";
 			sdhci,1-bit-only;
+			bus-width = <1>;
 		};
 
 		par_io@e0100 {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 47adb16..ae48fc7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1766,7 +1766,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 		pdata->slots[0].nonremovable = true;
 		pdata->slots[0].no_regulator_off_init = true;
 	}
-	of_property_read_u32(np, "ti,bus-width", &bus_width);
+	of_property_read_u32(np, "bus-width", &bus_width);
 	if (bus_width == 4)
 		pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6193a0d..586a818 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -402,7 +402,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	if (of_get_property(np, "fsl,card-wired", NULL))
+	if (of_get_property(np, "non-removable", NULL))
 		boarddata->cd_type = ESDHC_CD_PERMANENT;
 
 	if (of_get_property(np, "fsl,cd-controller", NULL))
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5c2a48..a3858d0 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -42,7 +42,8 @@ static struct sdhci_ops sdhci_pltfm_ops = {
 #ifdef CONFIG_OF
 static bool sdhci_of_wp_inverted(struct device_node *np)
 {
-	if (of_get_property(np, "sdhci,wp-inverted", NULL))
+	if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
+	    of_get_property(np, "wp-inverted", NULL))
 		return true;
 
 	/* Old device trees don't have the wp-inverted property. */
@@ -59,13 +60,16 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	const __be32 *clk;
+	u32 bus_width;
 	int size;
 
 	if (of_device_is_available(np)) {
 		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-		if (of_get_property(np, "sdhci,1-bit-only", NULL))
+		if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
+		    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+		    bus_width = 1))
 			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
 		if (sdhci_of_wp_inverted(np))

From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH v2 16/16] ARM: dts: add AM33XX SPI support
Date: Thu, 11 Oct 2012 15:04:41 -0400
Message-ID: <1349982281-10785-17-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1349982281-10785-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Adds AM33XX SPI support to the am33xx.dtsi and the BeagleBone
dts.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts |   17 +++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 5510979..23edfd8 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,6 +18,17 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux@44e10800 {
+		spi1_pins: pinmux_spi1_pins {
+			pinctrl-single,pins = <
+				0x190 0x13	/* mcasp0_aclkx.spi1_sclk, OUTPUT_PULLUP | MODE3 */
+				0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
+				0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
+				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44e09000 {
 			status = "okay";
@@ -84,3 +95,9 @@
 &mmc1 {
 	vmmc-supply = <&ldo3_reg>;
 };
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index ef8e105..854235e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux@44e10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44e10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7f>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
@@ -260,6 +269,40 @@
 			status = "disabled";
 		};
 
+		spi0: spi@48030000 {
+			compatible = "ti,omap4-mcspi";
+			ti,hwmods = "spi0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x48030000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <65>;
+			dmas = <&edma 16
+				&edma 17
+				&edma 18
+				&edma 19>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+			ti,spi-num-cs = <2>;
+			status = "disabled";
+		};
+
+		spi1: spi@481a0000 {
+			compatible = "ti,omap4-mcspi";
+			ti,hwmods = "spi1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x481a0000 0x400>;
+			interrupt-parent = <&intc>;
+			interrupt = <125>;
+			dmas = <&edma 42
+				&edma 43
+				&edma 44
+				&edma 45>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+			ti,spi-num-cs = <2>;
+			status = "disabled";
+		};
+
 		wdt2: wdt@44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev

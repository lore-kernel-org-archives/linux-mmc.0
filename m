From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 11/14] ARM: dts: dra76-evm: Add wilink8 wlan support
Date: Fri, 27 Apr 2018 17:39:02 +0530
Message-ID: <20180427120905.3665-12-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com, Vishal Mahaveer <vishalm@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Vishal Mahaveer <vishalm@ti.com>

Add support for WLAN using wilink8 module. On dra76-evm, MMC4 is
used for connecting to wilink8 module.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb96405d06..ad154c7b0632 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -42,6 +42,16 @@
 		regulator-boot-on;
 	};
 
+	vio_3v6: fixedregulator-vio_3v6 {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_3v6";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+		vin-supply = <&vsys_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_3v3: fixedregulator-vsys3v3 {
 		/* Output of Cntlr A of TPS43351-Q1 on dra76-evm */
 		compatible = "regulator-fixed";
@@ -81,6 +91,16 @@
 		vin-supply = <&smps5_reg>;
 	};
 
+	vmmcwl_fixed: fixedregulator-mmcwl {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcwl_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 8 0>;	/* gpio5_8 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	vtt_fixed: fixedregulator-vtt {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt_fixed";
@@ -331,6 +351,17 @@
 	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_conf>;
 };
 
+&mmc4 {
+	status = "okay";
+	vmmc-supply = <&vio_3v6>;
+	vqmmc-supply = <&vmmcwl_fixed>;
+	pinctrl-names = "default", "hs", "sdr12", "sdr25";
+	pinctrl-0 = <&mmc4_pins_hs &mmc4_iodelay_default_conf>;
+	pinctrl-1 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+	pinctrl-2 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+	pinctrl-3 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+};
+
 /* No RTC on this device */
 &rtc {
 	status = "disabled";
-- 
2.17.0

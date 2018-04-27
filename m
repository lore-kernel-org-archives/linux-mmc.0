From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 10/14] ARM: dts: dra7-evm: Add wilink8 wlan support
Date: Fri, 27 Apr 2018 17:39:01 +0530
Message-ID: <20180427120905.3665-11-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com, Hari Nagalla <hnagalla@ti.com>, Ido Yariv <ido@wizery.com>, Eyal Reizer <eyalr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Hari Nagalla <hnagalla@ti.com>

The wilink module is a combo wireless connectivity sdio
card based on Texas Instrument's wl18xx solution. It is a
4-wire, 1.8V, embedded sdio wlan device with an external
irq line and is power-controlled by a gpio-based fixed
regulator.

Add pinmux configuration and IODelay values for MMC4.
On dra7-evm, MMC4 is used for connecting to wilink module.

IODelay data credits to :  Vishal Mahaveer <vishalm@ti.com>
and Sekhar Nori <nsekhar@ti.com>

Signed-off-by: Ido Yariv <ido@wizery.com>
Signed-off-by: Eyal Reizer <eyalr@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm-common.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts         | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index 05a7b1a01bc3..33230c8b2951 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -260,3 +260,18 @@
 &pcie1_rc {
 	status = "okay";
 };
+
+&mmc4 {
+	bus-width = <4>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	non-removable;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wifi@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 181289a28ca1..704947cbef48 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -96,6 +96,16 @@
 		regulator-boot-on;
 	};
 
+	vmmcwl_fixed: fixedregulator-mmcwl {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcwl_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 8 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	extcon_usb2: extcon_usb2 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
@@ -376,6 +386,21 @@
 	pinctrl-5 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev20_conf>;
 };
 
+&mmc4 {
+	status = "okay";
+	vmmc-supply = <&evm_3v6>;
+	vqmmc-supply = <&vmmcwl_fixed>;
+	pinctrl-names = "default-rev11", "default", "hs-rev11", "hs", "sdr12-rev11", "sdr12", "sdr25-rev11", "sdr25";
+	pinctrl-0 = <&mmc4_pins_default &mmc4_iodelay_ds_rev11_conf>;
+	pinctrl-1 = <&mmc4_pins_default &mmc4_iodelay_ds_rev20_conf>;
+	pinctrl-2 = <&mmc4_pins_hs &mmc4_iodelay_sdr12_hs_sdr25_rev11_conf>;
+	pinctrl-3 = <&mmc4_pins_hs &mmc4_iodelay_sdr12_hs_sdr25_rev20_conf>;
+	pinctrl-4 = <&mmc4_pins_sdr12 &mmc4_iodelay_sdr12_hs_sdr25_rev11_conf>;
+	pinctrl-5 = <&mmc4_pins_sdr12 &mmc4_iodelay_sdr12_hs_sdr25_rev20_conf>;
+	pinctrl-6 = <&mmc4_pins_sdr25 &mmc4_iodelay_sdr12_hs_sdr25_rev11_conf>;
+	pinctrl-7 = <&mmc4_pins_sdr25 &mmc4_iodelay_sdr12_hs_sdr25_rev20_conf>;
+};
+
 &cpu0 {
 	vdd-supply = <&smps123_reg>;
 };
-- 
2.17.0

From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/7] ARM: dts: dra72-evm: add evm_3v3_sd regulator
Date: Thu, 30 Jul 2015 13:43:34 +0530
Message-ID: <1438244020-4244-2-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a node for evm_3v3_sd using pcf which feeds on to mmc vdd.
Update mapping for vmmc-supply and vmmc_aux-supply.
evm_3v3_sd supplies to SD card vdd, and ldo1 to sdcard i/o lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 8037384..3998d37 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -30,6 +30,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	evm_3v3_sd: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pcf_gpio_21 5 GPIO_ACTIVE_HIGH>;
+	};
+
 	extcon_usb1: extcon_usb1 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
@@ -491,8 +500,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_default>;
-
-	vmmc-supply = <&ldo1_reg>;
+	vmmc-supply = <&evm_3v3_sd>;
+	vmmc_aux-supply = <&ldo1_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
-- 
1.7.9.5
